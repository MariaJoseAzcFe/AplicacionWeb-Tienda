// Clase del producto que se almacena en el carrito
class ProductoCarrito {
    constructor(codigo, descripcion, imagen, cantidad, precio, existencias) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.cantidad = cantidad;
        this.precio = precio;
        this.existencias = existencias;
    }
}
var carrito = []; // Array que contendrá los objetos de la clase Producto

// Objeto que contendrá el producto que deseamos almacenar
let producto = new ProductoCarrito(1, "Descripción del producto", "img/imagen1.png", 1, 100.0, 8);

carrito.push(producto); // Añadimos el producto en el array

var carrito = null;

// Carga el carrito desde localStorage o lo inicializa vacío
function cargarCarrito() {
    if (carrito === null) {
        carrito = JSON.parse(localStorage.getItem("mi-carrito-almacenado"));
        if (carrito === null) {
            carrito = [];
        }
    }
}

// Guarda el carrito en localStorage
function guardarCarrito() {
    localStorage.setItem("mi-carrito-almacenado", JSON.stringify(carrito));
}

// Añade un producto al carrito (o incrementa su cantidad si ya existe)
function anadirCarrito(codigo, descripcion, imagen, precio, existencias) {
    cargarCarrito();

    const productoExistente = carrito.find(p => p.codigo === codigo);

    if (productoExistente) {
        if (productoExistente.cantidad < productoExistente.existencias) {
            productoExistente.cantidad++;
            alert("Producto actualizado en el carrito");
        } else {
            alert("No hay más existencias disponibles de este producto");
        }
    } else {
        const nuevoProducto = new ProductoCarrito(codigo, descripcion, imagen, 1, precio, existencias);
        carrito.push(nuevoProducto);
        alert("Producto añadido al carrito");
    }

    guardarCarrito();
}

// Elimina un producto por su código
function eliminarProducto(codigo) {
    cargarCarrito();
    carrito = carrito.filter(p => p.codigo !== codigo);
    guardarCarrito();
    alert("Producto eliminado del carrito");
    location.reload();
}

// Modifica la cantidad de un producto
function modificarCantidad(codigo, nuevaCantidad) {
    cargarCarrito();
    const producto = carrito.find(p => p.codigo === codigo);
    if (producto) {
        if (nuevaCantidad <= 0) {
            eliminarProducto(codigo);
        } else if (nuevaCantidad <= producto.existencias) {
            producto.cantidad = parseInt(nuevaCantidad);
            alert("Cantidad modificada");
        } else {
            alert("No puedes superar las existencias disponibles");
        }
    }
    guardarCarrito();
    location.reload();
}

// Muestra todos los productos del carrito en un contenedor HTML
function mostrarCarrito(contenedorId) {
    cargarCarrito();
    const contenedor = document.getElementById(contenedorId);
    contenedor.innerHTML = "";

    if (carrito.length === 0) {
        contenedor.innerHTML = "<p>No hay productos en el carrito.</p>";
        return;
    }

    let total = 0;

    carrito.forEach(p => {
        const subtotal = p.precio * p.cantidad;
        total += subtotal;
        contenedor.innerHTML += `
            <div class="producto-carrito">
                <img src="${p.imagen}" alt="${p.descripcion}" width="80">
                <strong>${p.descripcion}</strong> - ${p.precio}€ x ${p.cantidad} = ${subtotal.toFixed(2)}€
                <br>
                <input type="number" min="0" max="${p.existencias}" value="${p.cantidad}" onchange="modificarCantidad(${p.codigo}, this.value)">
                <button onclick="eliminarProducto(${p.codigo})">Eliminar</button>
                <hr>
            </div>
        `;
    });

    actualizarResumen();
}

function eliminarCarrito() {
    carrito = []; // Vaciamos el carrito
    guardarCarrito(); // Guardamos el carrito vacío
    location.reload();
}

function actualizarResumen() {
    cargarCarrito();
    
    const cantidadProductos = carrito.reduce((total, p) => total + Number(p.cantidad), 0);
    const subtotal = carrito.reduce((total, p) => total + (Number(p.precio) * Number(p.cantidad)), 0);
    const envio = 5.00; // Coste fijo de envío
    const total = subtotal + envio;

    document.getElementById('cantidad-productos').textContent = cantidadProductos;
    document.getElementById('subtotal').textContent = subtotal.toFixed(2) + '€';
    document.getElementById('total-pagar').textContent = total.toFixed(2) + '€';
}
function pedidoFormalizado(contenedorId) {
    cargarCarrito();
    const contenedor = document.getElementById(contenedorId);
    contenedor.innerHTML = "";

    if (carrito.length === 0) {
        contenedor.innerHTML = '<p class="text-center">No hay productos en tu pedido.</p>';
        return;
    }

    let html = '<div class="lista-productos">';

    carrito.forEach(p => {
        html += `
            <div class="producto-carrito p-3 mb-3 border rounded">
                <div class="row align-items-center">
                    <div class="col-3 col-md-2">
                        <img src="${p.imagen}" alt="${p.descripcion}" class="img-fluid">
                    </div>
                    <div class="col-6 col-md-8">
                        <h5 class="mb-1">${p.descripcion}</h5>
                        <p class="mb-1">${p.precio}€ × ${p.cantidad}</p>
                    </div>
                    
                </div>
            </div>
        `;
    });

    html += '</div>';
    contenedor.innerHTML = html;
}

function procederAlPago() {
    cargarCarrito(); 

    if (carrito.length === 0) {
        alert('Tu carrito está vacío. Añade productos antes de pagar.');
        return false; // Evita cualquier acción adicional
    }
     // Guarda momentáneamente los productos(me sirve para el apartado de pedidos realizados)
     localStorage.setItem('carrito-comprado', JSON.stringify(carrito));

    alert('Pago realizado con éxito! Gracias por su compra!');

    // Limpiar el carrito después del pago
    carrito = [];
    guardarCarrito();


    window.location.href = 'usuario.jsp'; 
    return true;
}

function mostrarPedido() {
    // atrapa los pedidos del procederpago
    const carritoComprado = JSON.parse(localStorage.getItem('carrito-comprado'));

    const contenedor = document.getElementById('contenedor-pedidos'); 

    contenedor.innerHTML = ""; 

    if (!carritoComprado || carritoComprado.length === 0) {
        contenedor.innerHTML = '<p class="text-center">No hay productos en tu pedido.</p>';
        return;
    }

    let html = '<div class="lista-productos">';

    carritoComprado.forEach(p => {
        html += `
            <div class="producto-carrito p-3 mb-3 border rounded">
                <div class="row align-items-center">
                    <div class="col-3 col-md-2">
                        <img src="${p.imagen}" alt="${p.descripcion}" class="img-fluid">
                    </div>
                    <div class="col-6 col-md-8">
                        <h5 class="mb-1">${p.descripcion}</h5>
                        <p class="mb-1">${p.precio}€ × ${p.cantidad}</p>
                    </div>
                </div>
            </div>
        `;
    });

    html += '</div>';
    contenedor.innerHTML = html;
}

