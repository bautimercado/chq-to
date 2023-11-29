// menu.js

function initializeUserMenu() {
    const userMenuButton = document.getElementById('userMenu');
    const userMenuContent = document.getElementById('userMenuContent');

    userMenuButton.addEventListener('click', () => {
        userMenuContent.classList.toggle('hidden');
    });

    // Cerrar el menú desplegable al hacer clic fuera de él
    document.addEventListener('click', (event) => {
        if (!userMenuButton.contains(event.target) && !userMenuContent.contains(event.target)) {
            userMenuContent.classList.add('hidden');
        }
    });
}

// Llama a la función cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', initializeUserMenu);

/*document.addEventListener('turbo:load', () => {
    initializeUserMenu();
});*/