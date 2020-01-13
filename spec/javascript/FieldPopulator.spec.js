import FieldPopulator from '../../app/javascript/packs/FieldPopulator';

let setDocumentBody = () => {
  document.body.innerHTML = `
      <div id="parent">
        <input id="search" type="search" data-url="/search">
      </div>
      <span id=spanText>TestText</span>
  `
};

describe('populateField', () => {
  it('populates a text field with a text value', () => {
    setDocumentBody()

    FieldPopulator.populateField('Some random string', 'search');

    const searchField = document.querySelector('#search')
    expect(searchField.value).toEqual('Some random string');
  })
})

describe('handleOnClick', () => {
    it('calls populateField with the text value of the element its attached to', () => {
        setDocumentBody()

        const spy = jest.spyOn(FieldPopulator, 'populateField')
        const event = new MouseEvent('click')
        const spanElement = document.getElementById('spanText')

        spanElement.dispatchEvent(event)
        FieldPopulator.handleOnClick(event, 'search')

        expect(spy).toHaveBeenCalledTimes(1);
        expect(spy).toHaveBeenCalledWith('TestText', 'search');
    })
})