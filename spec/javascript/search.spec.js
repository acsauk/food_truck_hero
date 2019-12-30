import Search from '../../app/javascript/packs/Search';
import ResultsDisplayer from '../../app/javascript/packs/ResultsDisplayer';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div>
        <input id="search" type="search" data-url="/search" value="test">
      </div>
  `
};

let failTest = err => {
  fail(err)
}

beforeEach(() => {
  fetch.resetMocks()
  setDocumentBody()
  fetch.mockResponseOnce(JSON.stringify([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}]))
});

describe('search', () => {
  describe('init', () => {
    it('adds required eventListeners to search element', () => {
      const spy = jest.spyOn(document.getElementById('search'), 'addEventListener');

      Search.init('search');

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('input', Search.handleUpdateValue);
    });

    it('sets search endpoint from value of data-url on input element', () => {
      Search.init('search');
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
      const res = await Search.searchProducts('abc').catch(failTest)
      expect(res).toEqual([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}])
    })
  })

  describe('handleUpdateValue', () => {
    it('calls searchProduct with the element value of event target', async () => {
      const spy = jest.spyOn(Search, 'searchProducts')

      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('test');
    })

    it('adds search results to search.searchResults', async () => {
      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)
      expect(Search.searchResults).toEqual([{id: 1, name: "Ham"}, {id: 2, name: "Eggs"}, {id: 3, name: "Chips"}])
    })

    it('appends search results below search input', async () => {
      const event = new Event('input')
      const searchInput = document.getElementById('search')
      searchInput.dispatchEvent(event)

      await Search.handleUpdateValue(event).catch(failTest)

      expect(searchInput.parentElement.innerHTML).toMatch(/Ham/)
      expect(searchInput.parentElement.innerHTML).toMatch(/Eggs/)
      expect(searchInput.parentElement.innerHTML).toMatch(/Chips/)
    })
  })
});