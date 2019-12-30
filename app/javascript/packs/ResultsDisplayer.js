class ResultsDisplayer {
    static init(elementId) {
        document.getElementById('search').addEventListener('input', this.handleUpdateEvent)
    } 

    static appendResultsTo(inputId, resultsElement) {
        document.getElementById(inputId).parentElement.appendChild(resultsElement)
    }

    static generateResultsHTML(searchResults) {
        let parser = new DOMParser()
        let resultsHTML = parser.parseFromString(`<div class='results-list'></div>`, 'text/html')

        searchResults.forEach(r => {
            let result = parser.parseFromString(`<span class='result'>${r.name}</span>`, 'text/html')
            resultsHTML.body.firstChild.appendChild(result.body.firstChild)
        })

        return resultsHTML.body
    }
}

export default ResultsDisplayer