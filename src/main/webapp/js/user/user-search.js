function loadProducts(search = '', category = 'all', sort = 'none') {
    $.ajax({
        url: 'ProductController',
        method: 'GET',
        data: { search, category, sort },
        success: function (response) {
            $('#product-list').html(response);
        },
        error: function (xhr, status, error) {
            console.error('Error loading products:', error);
        }
    });
}

function loadCategories() {
    $.ajax({
        url: 'CategoryController',
        method: 'GET',
        success: function (response) {
            const categories = JSON.parse(response);
            categories.forEach(category => {
                $('#category-select').append(`<option value="${category.id}">${category.name}</option>`);
            });
        },
        error: function (xhr, status, error) {
            console.error('Error loading categories:', error);
        }
    });
}

$(document).ready(function () {
    loadCategories();
    loadProducts();

    // Filter by category
    $('#category-select').on('change', function () {
        const category = $(this).val();
        const search = $('#search-input').val();
        const sort = $('#sort-select').val();
        loadProducts(search, category, sort);
    });

    // Sort products
    $('#sort-select').on('change', function () {
        const sort = $(this).val();
        const search = $('#search-input').val();
        const category = $('#category-select').val();
        loadProducts(search, category, sort);
    });

    // Search functionality
    $('#search-form').on('submit', function (e) {
        e.preventDefault();
        const search = $('#search-input').val();
        const category = $('#category-select').val();
        const sort = $('#sort-select').val();
        loadProducts(search, category, sort);
    });
});