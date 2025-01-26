const homeNav = document.getElementById("user_home_nav");
const productNav = document.getElementById("user_product_nav");
const cartNav = document.getElementById("user_cart_nav");
const searchNav = document.getElementById("user_search_nav");

const homeSection = document.getElementById("customer_home_section");
const productSection = document.getElementById("customer_product_section");
const cartSection = document.getElementById("customer_cart_section");
const searchSection = document.getElementById("customer_search_section");

function hideAllSections() {
    homeSection.style.display = "none";
    productSection.style.display = "none";
    cartSection.style.display = "none";
    searchSection.style.display = "none";
}

function handleNavigation(event, targetSection) {
    event.preventDefault();
    hideAllSections();
    targetSection.style.display = "block";
}

homeNav.addEventListener("click", (e) => handleNavigation(e, homeSection));
productNav.addEventListener("click", (e) => handleNavigation(e, productSection));
cartNav.addEventListener("click", (e) => handleNavigation(e, cartSection));
searchNav.addEventListener("click", (e) => handleNavigation(e, searchSection));

hideAllSections();
homeSection.style.display = "block";

function handleNavigation(event, targetSection, hash) {
    event.preventDefault();
    hideAllSections();
    targetSection.style.display = "block";
    window.location.hash = hash;
}

const hash = window.location.hash;
switch (hash) {
    case "#products":
        hideAllSections();
        productSection.style.display = "block";
        break;
    case "#cart":
        hideAllSections();
        cartSection.style.display = "block";
        break;
    case "#search":
        hideAllSections();
        searchSection.style.display = "block";
        break;
    default:
        hideAllSections();
        homeSection.style.display = "block";
        break;
}