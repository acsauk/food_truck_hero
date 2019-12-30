import ResultsDisplayer from './ResultsDisplayer';

class Search {
    constructor() {
        this.searchResults = []
        this.searchEndpoint = null
        this.inputId = inputId
    }

    static init(inputId) {
        Search.inputId = inputId
        Search.searchResults = []
        let inputElement = document.getElementById(inputId)
        
        inputElement.addEventListener('input', Search.handleUpdateValue);
        Search.searchEndpoint = inputElement.dataset.url
    }

    static async handleUpdateValue(event) {
        const results = await Search.searchProducts(event.target.value)

        if (!Search.resultsAreEqual(results)) {
            Search.searchResults = results
            const resultsHTML = ResultsDisplayer.generateResultsHTML(Search.searchResults)
            ResultsDisplayer.appendResultsTo(Search.inputId, resultsHTML)
        }
    }

    static async searchProducts(searchString) {
        const response = await fetch(`${Search.searchEndpoint}?q=${searchString}`)
        const data = await response.json()

        return data
    }

    static resultsAreEqual(newResults) {
        return (newResults.length == Search.searchResults.length) && newResults.every(function(element, index) {
            return element.name === Search.searchResults[index].name; 
        });
    }
}

export default Search