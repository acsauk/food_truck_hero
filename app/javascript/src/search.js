class search {
    static init() {
        let search = document.getElementById('search')

        search.addEventListener('keyup', (e) => {});
    }

    static async searchProducts(searchString) {
        const url = document.getElementById('search').dataset.url
        const response = await fetch(`${url}?q=${searchString}`)
        const data = await response.json()

        return data.products
    }
}

export default search