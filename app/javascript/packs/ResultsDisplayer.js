class ResultsDisplayer {
    static init(elementId) {
        document.getElementById(elementId).addEventListener('input', this.handleUpdateEvent)
    } 

    static appendResultsTo(inputId, resultsElement) {
        let element = document.getElementById(inputId).parentElement
        element.replaceChild(resultsElement, element.lastChild)
    }

    static generateResultsHTML(searchResults, resultsParentClass, resultItemClass) {
        let parser = new DOMParser()
        let resultsHTML = parser.parseFromString(`<div class='${resultsParentClass} list is-hoverable'></div>`, 'text/html').body

        if (Array.isArray(searchResults)) {
            searchResults.forEach(r => {
                let result = parser.parseFromString(`<a href='#' class='${resultItemClass}'>${r.name}</p>`, 'text/html').body
                resultsHTML.firstChild.appendChild(result.firstChild)
            })
        }

        return resultsHTML
    }
}

export default ResultsDisplayer