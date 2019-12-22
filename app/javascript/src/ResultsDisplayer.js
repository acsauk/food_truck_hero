class ResultsDisplayer {
    static appendResults(inputId) {
        const p = document.createElement("p");
        document.getElementById(inputId).parentElement.appendChild(p)
    }
}

export default ResultsDisplayer