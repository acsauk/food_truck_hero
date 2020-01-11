import Search from '../../app/javascript/packs/Search';
import ResultsDisplayer from '../../app/javascript/packs/ResultsDisplayer';
import FieldPopulator from '../../app/javascript/packs/FieldPopulator';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div>
        <input id="search" class="commonClass" type="search" data-url="/search" value="test">
      </div>
  `
};

let failTest = err => {
  fail(err)
}

beforeEach(() => {
  fetch.resetMocks()
  setDocumentBody()
  Search.searchResults = []
});

describe('search', () => {
  describe('init', () => {
    it('adds required eventListeners to search element', () => {
      const spy = jest.spyOn(document.getElementById('search'), 'addEventListener');

      Search.init('search', 'resultsParentClass', 'resultsItemClass');

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('input', Search.handleUpdateValue);
    });

    it('sets search endpoint from value of data-url on input element', () => {
      Search.init('search', 'resultsParentClass', 'resultsItemClass');
      expect(Search.searchEndpoint).toEqual('/search')
    })
  });

  describe('searchProducts', () => {
    it('calls out to an endpoint with a search string', () => {
      const spy = jest.spyOn(global, 'fetch');

      const searchString = 'abc'
      Search.searchProducts(searchString)

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith(`/search?q=${searchString}`);
    })

    it('returns a list of product strings in an array from json fetch results', async () => {
      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))

      const res = await Search.searchProducts('abc').catch(failTest)
      expect(res).toEqual([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}])
    })
  })

  describe('handleUpdateValue', () => {
    it('calls searchProduct with the element value of event target', async () => {
      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))

      const spy = jest.spyOn(Search, 'searchProducts')

      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('test');
    })

    it('adds search results to search.searchResults', async () => {
      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))

      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)
      expect(Search.searchResults).toEqual([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}])
    })

    it('appends search results below search input', async () => {
      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))

      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)

      expect(searchInput.parentElement.innerHTML).toMatch(/Ham/)
      expect(searchInput.parentElement.innerHTML).toMatch(/Eggs/)
      expect(searchInput.parentElement.innerHTML).toMatch(/Chips/)
    })

    it('only updates results if they change', async () => {
      const spy = jest.spyOn(ResultsDisplayer, 'generateResultsHTML');

      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      Search.init('search')
      fetch.resetMocks()

      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))
      await Search.handleUpdateValue(event).catch(failTest)

      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))
      await Search.handleUpdateValue(event).catch(failTest)

      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}]))
      await Search.handleUpdateValue(event).catch(failTest)

      expect(spy).toHaveBeenCalledTimes(2)
    })

    it('adds click event listener to generated results HTML that calls FieldPopulator.handleOnClick', async () => {
      fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))
      Search.resultsParentClass = 'resultsParentClass'

      const clickEvent = new Event('input')
      const searchInput = document.getElementById('search')
      const spy = jest.spyOn(Search, 'addEventListenerToResultsParent');

      searchInput.dispatchEvent(clickEvent)
      await Search.handleUpdateValue(clickEvent).catch(failTest)

      expect(spy).toHaveBeenCalledTimes(1)
      expect(spy).toHaveBeenCalledWith('resultsParentClass')

    })
  })

  describe('resultsAreEqual', () => {
    it('returns true when Search.searchResults and input are equal', () => {
      const results = [{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]
      Search.searchResults = results
      expect(Search.resultsAreEqual(results)).toEqual(true)
    })

    it('returns false when Search.searchResults and input are inequal', () => {
      Search.searchResults = [{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]
      expect(Search.resultsAreEqual([{id: 1, name: "Cheese"}, {id: 2, name: "Tomato"}, {id: 3, name: "Bread"}])).toEqual(false)
    })

    it('handles arrays of different lengths', () => {
      Search.searchResults = [{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]
      expect(Search.resultsAreEqual([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}])).toEqual(false)
    })
  })

  describe('addEventListenerToResultsParent', () => {
    it('adds click events to elements with class name passed to function with callback to FieldPopulator.handleOnClick', () => {
      let searchSpy = jest.spyOn(document.getElementById('search'), 'addEventListener');

      Search.addEventListenerToResultsParent('commonClass')

      expect(searchSpy).toHaveBeenCalled()
      expect(searchSpy).toHaveBeenCalledWith('click', Search.handleOnResultClick)
    })
  })
})