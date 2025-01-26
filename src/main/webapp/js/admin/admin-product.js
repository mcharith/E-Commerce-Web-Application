document.addEventListener("DOMContentLoaded", () => {
    const rows = document.querySelectorAll("#productTableBody tr");
    const productNameField = document.getElementById("productName");
    const productPriceField = document.getElementById("productPrice");
    const productQtyField = document.getElementById("productQty");
    const categoryIdField = document.getElementById("categoryId");
    const productIdField = document.getElementById("productId");
    const fileNameDisplay = document.getElementById("fileNameDisplay");
    const fileInput = document.getElementById("description");

    rows.forEach(row => {
        row.addEventListener("click", () => {
            const id = row.getAttribute("data-id");
            const name = row.getAttribute("data-name");
            const price = row.getAttribute("data-price");
            const quantity = row.getAttribute("data-quantity");
            const categoryId = row.getAttribute("data-category-id");
            const imageUrl = row.querySelector("img").src;

            const filename = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

            productNameField.value = name;
            productPriceField.value = price;
            productQtyField.value = quantity;
            categoryIdField.value = categoryId;
            productIdField.value = id;

            fileNameDisplay.value = filename;
        });
    });

    fileInput.addEventListener("change", event => {
        const file = event.target.files[0];
        if (file) {
            fileNameDisplay.value = file.name;
        } else {
            fileNameDisplay.value = "";
        }
    });
});