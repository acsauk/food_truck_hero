class ResultsDisplayer {
    static init(elementId) {
        document.getElementById(elementId).addEventListener('input', this.handleUpdateEvent)
    } 

    static appendResultsTo(inputId, resultsElement) {
        let element = document.getElementById(inputId).parentElement

        element.replaceChild(resultsElement, element.lastChild)
    }

    static generateResultsHTML(searchResults) {
        let parser = new DOMParser()
        let resultsHTML = parser.parseFromString(`<div class='results-list'></div>`, 'text/html')

        if (Array.isArray(searchResults)) {
            searchResults.forEach(r => {
                let result = parser.parseFromString(`<p class='result'>${r.name}</p>`, 'text/html')
                resultsHTML.body.firstChild.appendChild(result.body.firstChild)
            })
        }

        return resultsHTML.body
    }
}

export default ResultsDisplayer