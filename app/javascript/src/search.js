class Search {
    constructor() {
        this.searchResults = []
        this.searchEndpoint = null
    }

    static init(inputId) {
        let inputElement = document.getElementById(inputId)
        
        inputElement.addEventListener('input', this.handleUpdateValue);
        this.searchEndpoint = inputElement.dataset.url
    }

    static async handleUpdateValue(event) {
        this.searchResults = await this.searchProducts(event.target.value)
    }

    static async searchProducts(searchString) {
        const response = await fetch(`${this.searchEndpoint}?q=${searchString}`)
        const data = await response.json()

        return data.products
    }
}

export default Search