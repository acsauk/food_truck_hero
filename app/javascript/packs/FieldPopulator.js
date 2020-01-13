class FieldPopulator{
    static populateField(text, elementIDToUpdate) {
        document.getElementById(elementIDToUpdate).value = text
    }

    static handleOnClick(event, elementIDToUpdate) {
        FieldPopulator.populateField(event.target.textContent, elementIDToUpdate)
        event.stopPropagation()
    }
}

export default FieldPopulator