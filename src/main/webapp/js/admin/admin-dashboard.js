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

    homeNav.addEventListener("click", () => showSection(homeSection));
    categoryNav.addEventListener("click", () => showSection(adminCategorySection));
    productNav.addEventListener("click", () => showSection(adminProductSection));
    customerDetailsNav.addEventListener("click", () => showSection(adminCustomerSection));
    orderDetailsNav.addEventListener("click", () => showSection(adminOrderDetailsSection));

    showSection(homeSection);
});