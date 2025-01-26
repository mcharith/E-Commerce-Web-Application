document.addEventListener("DOMContentLoaded", () => {
    const homeNav = document.getElementById("home_nav");
    const categoryNav = document.getElementById("category_nav");
    const productNav = document.getElementById("product_nav");
    const customerDetailsNav = document.getElementById("customer_details_nav");
    const orderDetailsNav = document.getElementById("order_details_nav");

    const homeSection = document.getElementById("home_section");
    const adminCategorySection = document.getElementById("admin_category_section");
    const adminProductSection = document.getElementById("admin_product_section");
    const adminCustomerSection = document.getElementById("admin_customer_activate_deactivate_section");
    const adminOrderDetailsSection = document.getElementById("admin_order_details_section");

    // Function to show the specified section and hide the others
    function showSection(sectionToShow) {
        const sections = [
            homeSection,
            adminCategorySection,
            adminProductSection,
            adminCustomerSection,
            adminOrderDetailsSection,
        ];

        sections.forEach((section) => {
            if (section) {
                section.style.display = section === sectionToShow ? "block" : "none";
            }
        });
    }

    // Add event listeners for navigation items
    homeNav.addEventListener("click", () => showSection(homeSection));
    categoryNav.addEventListener("click", () => showSection(adminCategorySection));
    productNav.addEventListener("click", () => showSection(adminProductSection));
    customerDetailsNav.addEventListener("click", () => showSection(adminCustomerSection));
    orderDetailsNav.addEventListener("click", () => showSection(adminOrderDetailsSection));

    // Show the home section by default
    showSection(homeSection);

    // Automatically navigate to a specific section based on the "section" query parameter
    const urlParams = new URLSearchParams(window.location.search);
    const section = urlParams.get("section");

    if (section === "category") {
        showSection(adminCategorySection);
    } else if (section === "product") {
        showSection(adminProductSection);
    } else if (section === "customer") {
        showSection(adminCustomerSection);
    } else if (section === "order") {
        showSection(adminOrderDetailsSection);
    } else {
        showSection(homeSection); // Default to home section if no query parameter is provided
    }

    // Handle optional success or error messages in the query parameters
    const message = urlParams.get("message");
    const error = urlParams.get("error");

    if (message) {
        alert(message); // Display success message
    }

    if (error) {
        alert(error); // Display error message
    }
});