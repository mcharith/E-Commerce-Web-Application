document.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("#categoryTableBody tr");
    const categoryNameField = document.getElementById("categoryName");
    const categoryDescriptionField = document.getElementById("categoryDescription");
    const categoryIdField = document.getElementById("categoryId");

    rows.forEach(row => {
        row.addEventListener("click", () => {
            const id = row.getAttribute("data-id");
            const name = row.getAttribute("data-name");
            const description = row.getAttribute("data-description");

            // Populate form fields
            categoryIdField.value = id;
            categoryNameField.value = name;
            categoryDescriptionField.value = description;
        });
    });
});