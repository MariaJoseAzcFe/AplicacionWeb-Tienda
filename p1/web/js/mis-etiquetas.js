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
        this.innerHTML = ` <footer >
        
                        <a href="https://www.instagram.com/mariajo_arts/">
                            <i class="fa-brands fa-instagram"></i>
                        </a>
                  
                        <a href="https://x.com/home">
                            <i class="fa-brands fa-x-twitter" ></i>
                        </a>
                   
                
                <p id="copyright">&copy; 2026 - María José Azcárate Ferrando - Información de redes sociales</p>
          
            </footer>
        `
    }
}
window.customElements.define('mi-pie', Pie);

class Menu extends HTMLElement {
    constructor() {
        super()
        this.innerHTML = `
                    <nav class="navbar navbar-expand-lg">
  <div class="container-fluid">
    <button class="navbar-toggler btn-yellow" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="collapsibleNavbar">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item">
          <a class="nav-link" href="index.html">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="productos.html">Productos</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="contacto.html">Contacto</a>
        </li>  
        <li class="nav-item">
          <a class="nav-link" href="empresa.html">Empresa</a>
        </li> 
        <li class="nav-item">
          <a class="nav-link" href="carrito.html">Carrito</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Usuario</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="login.html">Inicio sesion</a></li>
            <li><a class="dropdown-item" href="registro.html">Registro</a></li>
            <li><a class="dropdown-item" href="usuario.html">Perfil</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>  
        `
    }
}
window.customElements.define('mi-menu', Menu);
//BURBUJAS
function createBubble() {
    const bubble = document.createElement("div");
    bubble.classList.add("bubble");

    // Tamaño aleatorio
    const size = Math.random() * 60 + 20; 
    bubble.style.width = `${size}px`;
    bubble.style.height = `${size}px`;

    // Posición horizontal aleatoria
    const left = Math.random() * window.innerWidth;
    bubble.style.left = `${left}px`;

    // Duración de la animación aleatoria
    const duration = Math.random() * 6 + 3; // Entre 3s y 9s
    bubble.style.animationDuration = `${duration}s`;

    // Agregar la burbuja al contenedor
    document.querySelector(".bubbles-container").appendChild(bubble);

    // Eliminar la burbuja después de que termine la animación
    setTimeout(() => {
        bubble.remove();
    }, duration * 1000);
}

// Crear burbujas cada cierto tiempo
setInterval(createBubble, 300); // Cada 300ms