import ResultsDisplayer from '../../app/javascript/packs/ResultsDisplayer';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div id="parent">
        <input id="search" type="search" data-url="/search">
      </div>
  `
};

describe('init', () => {
  it('attaches required event listeners to DOM elements', () => {
    setDocumentBody()

    const spy = jest.spyOn(document.getElementById('search'), 'addEventListener');

    ResultsDisplayer.init('search');

    expect(spy).toHaveBeenCalledTimes(1);
    expect(spy).toHaveBeenCalledWith('input', ResultsDisplayer.handleUpdateEvent);
  })
})

describe('appendResultsTo', () => {
  it('inserts an element as sibling to inputId', () => {
    setDocumentBody()

    const searchElement = document.querySelector('#search').parentElement.children
    const resultsElement = document.createElement("p");

    ResultsDisplayer.appendResultsTo('search', resultsElement)

    expect(searchElement.length).toEqual(2)
  })
})

describe('generateResultsHTML', () => {
    it('generates results HTML from JSON', () => {
      const searchResults = ["result 1", "result 2"]
      const resultsHTMLString = ResultsDisplayer.generateResultsHTML(searchResults, "parentClass", "itemClass")

      expect(resultsHTMLString.querySelector('.parentClass').childElementCount).toEqual(2)
    })

    it('return empty div when searchResults is not an array', () => {
      const searchResults = ""
      const resultsHTMLString = ResultsDisplayer.generateResultsHTML(searchResults, "parentClass", "itemClass")

      expect(resultsHTMLString.querySelector('.parentClass').childElementCount).toEqual(0)
    })

    it('assigns the value of resultsParentClass and resultItemClass to the class of results parent and each result item', () => {
      const searchResults = ["result 1", "result 2"]
      const resultsHTMLString = ResultsDisplayer.generateResultsHTML(searchResults, "parentClass", "itemClass")

      const resultsParent = resultsHTMLString.querySelectorAll('.parentClass')
      expect(resultsParent.length).toEqual(1)

      const resultItems = resultsHTMLString.querySelectorAll('.itemClass')
      expect(resultItems.length).toEqual(2)
    })
})
