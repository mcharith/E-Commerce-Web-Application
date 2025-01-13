const togglePassword = document.querySelector("#togglePassword");
const passwordInput = document.querySelector("#password");
const toggleIcon = document.querySelector("#toggleIcon");

togglePassword.addEventListener("click", function () {
    const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", type);

    toggleIcon.classList.toggle("bi-eye");
    toggleIcon.classList.toggle("bi-eye-slash");
})