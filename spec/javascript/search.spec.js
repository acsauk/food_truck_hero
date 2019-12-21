import search from '../../app/javascript/src/search';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div>
        <input id="search" type="search" data-url="/search">
      </div>
  `
};

let failTest = err => {
  fail(err)
}

describe('search', () => {
  describe('init', () => {
    it('adds required eventListeners to search element', () => {
      setDocumentBody();

      const spy = jest.spyOn(document.getElementById('search'), 'addEventListener');

      search.init();

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('keyup', expect.any(Function));
    });
  });

  describe('searchProducts', () => {
    beforeEach(() => {
      fetch.resetMocks();
      setDocumentBody();
      fetch.mockResponseOnce(JSON.stringify({products: ["Ham", "Eggs", "Chips"]}))
    });

    it('calls out to an endpoint with a search string', () => {
      const spy = jest.spyOn(global, 'fetch');

      const searchString = 'abc'
      search.searchProducts(searchString)

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith(`/search?q=${searchString}`);
    })

    it('uses value of data-url on element #search to construct URL', () => {
      const path = '/newPath'
      
      document.body.innerHTML = `
        <div>
          <input id="search" type="search" data-url="${path}">
        </div>
      `

      const spy = jest.spyOn(global, 'fetch');

      search.searchProducts('abc')

      expect(spy).toHaveBeenCalledTimes(1);
      expect(spy).toHaveBeenCalledWith('/newPath?q=abc');
    })

    it('returns a list of product strings in an array from json fetch results', async () => {
      const res = await search.searchProducts('abc').catch(failTest)
      expect(res).toEqual(["Ham", "Eggs", "Chips"])
    })
  })
});