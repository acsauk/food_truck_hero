import ResultsDisplayer from './ResultsDisplayer';

class Search {
    constructor() {
        this.searchResults = []
        this.searchEndpoint = null
        this.inputId = inputId
    }

    static init(inputId) {
        Search.inputId = inputId
        let inputElement = document.getElementById(inputId)
        
        inputElement.addEventListener('input', Search.handleUpdateValue);
        Search.searchEndpoint = inputElement.dataset.url
    }

    static async handleUpdateValue(event) {
        Search.searchResults = await Search.searchProducts(event.target.value)
        const results = ResultsDisplayer.generateResultsHTML(Search.searchResults)
        ResultsDisplayer.appendResultsTo(Search.inputId, results)
    }

    static async searchProducts(searchString) {
        const response = await fetch(`${Search.searchEndpoint}?q=${searchString}`)
        const data = await response.json()

        return data
    }
}

export default Search