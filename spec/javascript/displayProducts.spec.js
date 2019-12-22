import ResultsDisplayer from '../../app/javascript/src/ResultsDisplayer';
import expectExport from 'expect';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div>
        <input id="search" type="search" data-url="/search">
      </div>
  `
};

describe('appendResults', () => {
    it('inserts an element as sibling to inputId', () => {
        setDocumentBody()

        const searchParent = document.querySelector('#search').parentElement.children

        ResultsDisplayer.appendResults('search')

        expect(searchParent.length).toEqual(2)
    })
})