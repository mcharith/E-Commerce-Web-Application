const toggledPassword = document.querySelector("#toggledPassword");
const passwordInput = document.querySelector("#password");
const toggledIcon = document.querySelector("#toggleIcon");

toggledPassword.addEventListener("click", function () {
    const type = passwordInput.getAttribute("type") === "password" ? "text" : "password";
    passwordInput.setAttribute("type", type);

    toggledIcon.classList.toggle("bi-eye");
    toggledIcon.classList.toggle("bi-eye-slash");
})

const password = document.getElementById('password');
const rePassword = document.getElementById('re-password');
const passwordMatchMessage = document.getElementById('passwordMatchMessage');
const togglePassword = document.getElementById('toggledPassword');
const toggleIcon = document.getElementById('toggledIcon');

// Toggle password visibility
togglePassword.addEventListener('click', () => {
    const type = password.type === 'password' ? 'text' : 'password';
    password.type = type;
    toggleIcon.classList.toggle('bi-eye');
    toggleIcon.classList.toggle('bi-eye-slash');
});

// Validate password match
rePassword.addEventListener('input', () => {
    if (rePassword.value === password.value && rePassword.value !== '') {
        rePassword.style.borderColor = 'green';
        passwordMatchMessage.textContent = 'Passwords match!';
        passwordMatchMessage.style.color = 'green';
    } else if (rePassword.value !== '') {
        rePassword.style.borderColor = 'red';
        passwordMatchMessage.textContent = 'Passwords do not match.';
        passwordMatchMessage.style.color = 'red';
    } else {
        rePassword.style.borderColor = '';
        passwordMatchMessage.textContent = '';
    }
});