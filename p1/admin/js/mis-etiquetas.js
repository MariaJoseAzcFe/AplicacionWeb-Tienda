
class Cabecera extends HTMLElement {
    constructor() {
        super()
        this.innerHTML = `<header class="header">
                            <div class="logo-container">
                                <img src="img/logo.png" alt="Logo" class="logo">
                                <span class="brand-text">Fish it!</span>
                            </div>
                        </header>`
    }
}
window.customElements.define('mi-cabecera', Cabecera);

class Pie extends HTMLElement {
    constructor() {
        super()
        this.innerHTML = ` <footer>
                        <a href="https://www.instagram.com/mariajo_arts/"><i class="fa-brands fa-instagram"></i></a>
                        <a href="https://x.com/home"><i class="fa-brands fa-x-twitter" ></i></a>
                <p id="copyright">&copy; 2026 - María José Azcárate Ferrando - Información de redes sociales</p>
            </footer>`
    }
}
window.customElements.define('mi-pie', Pie);

class MenuAdmin extends HTMLElement {
    constructor() {
        super()
        this.innerHTML = `
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
                <div class="container">
                    <a class="navbar-brand d-flex align-items-center" href="panel.html">Administración</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link" href="usuarios.html"><i class="fas fa-users me-1"></i> Usuarios</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="productos.html"><i class="fas fa-box-open me-1"></i> Productos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="pedidos.html"><i class="fas fa-shopping-cart me-1"></i> Pedidos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="index.html" ><i class="fas fa-sign-out-alt me-1"></i> Salir</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>`
    }
}
window.customElements.define('mi-menu-admin', MenuAdmin);

// EFECTO DE BURBUJAS
function createBubble() {
    const bubble = document.createElement("div");
    bubble.classList.add("bubble");

    const size = Math.random() * 60 + 20; 
    bubble.style.width = `${size}px`;
    bubble.style.height = `${size}px`;

    const left = Math.random() * window.innerWidth;
    bubble.style.left = `${left}px`;

    const duration = Math.random() * 6 + 3; 
    bubble.style.animationDuration = `${duration}s`;

    document.querySelector(".bubbles-container")?.appendChild(bubble);

    setTimeout(() => {
        bubble.remove();
    }, duration * 1000);
}

setInterval(createBubble, 300);