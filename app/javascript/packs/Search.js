import ResultsDisplayer from './ResultsDisplayer';
import FieldPopulator from './FieldPopulator';

class Search {
    constructor() {
        this.searchResults = []
        this.searchEndpoint = null
        this.inputId = inputId
        this.resultsParentClass = resultsParentClass
        this.resultsItemClass = resultsItemClass
    }

    static init(inputId, resultsParentClass, resultsItemClass) {
        Search.inputId = inputId
        Search.resultsParentClass = resultsParentClass
        Search.resultsItemClass = resultsItemClass
        Search.searchResults = []
        let inputElement = document.getElementById(inputId)
        
        inputElement.addEventListener('input', Search.handleUpdateValue);
        Search.searchEndpoint = inputElement.dataset.url
    }

    static async handleUpdateValue(event) {
        const results = await Search.searchProducts(event.target.value)

        if (!Search.resultsAreEqual(results)) {
            Search.searchResults = results
            const resultsHTML = ResultsDisplayer.generateResultsHTML(Search.searchResults, Search.resultsParentClass, Search.resultsItemClass)
            ResultsDisplayer.appendResultsTo(Search.inputId, resultsHTML)
            Search.addEventListenerToResultsParent(Search.resultsParentClass)
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

    static addEventListenerToResultsParent(resultsParentClass) {
        let resultsParent = document.querySelector(`.${resultsParentClass}`)
        resultsParent.addEventListener('click', Search.handleOnResultClick)
    }

    static handleOnResultClick(e) {
        FieldPopulator.handleOnClick(e, Search.inputId)
    }
}

export default Search