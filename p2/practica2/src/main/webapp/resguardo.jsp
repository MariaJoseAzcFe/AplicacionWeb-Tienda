<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resguardo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
  </head>
  
<body>
 
<%-- Verificación de sesión y mensaje de error --%>
<%
String mensaje = (String)session.getAttribute("mensaje");
if (mensaje != null) {
  session.removeAttribute("mensaje");
%>
<h1> <%=mensaje%> </h1>
<%
}
%>

<%
String nombre = "Sin rellenar";
String apellidos = "Sin rellenar";
String clave = "Sin rellenar";
String telefono = "Sin rellenar";
String direccion = "Sin rellenar";
String codigoPostal = "Sin rellenar";
String provincia = "Sin rellenar";
String poblacion = "Sin rellenar";
String formaPago = "Sin rellenar";

if ((session.getAttribute("codigo") == null) || ((Integer)session.getAttribute("codigo") <= 0 )) {
    response.sendRedirect("loginUsuario.jsp");
} else {
    
    UsuarioBD usuarioBD = (UsuarioBD) session.getAttribute("usuarioBD");
    if (usuarioBD != null) {
        nombre = usuarioBD.getNombre();
        apellidos = usuarioBD.getApellidos();
        clave = usuarioBD.getClave();
        telefono = usuarioBD.getTelefono();
        direccion = usuarioBD.getDireccion();
        codigoPostal = usuarioBD.getCodigoPostal();
        provincia = usuarioBD.getProvincia();
        poblacion = usuarioBD.getPoblacion();
        formaPago = (String) session.getAttribute("formatopago");
    }
   
    
}
%> 
<mi-menu></mi-menu>
<h3 class="titulos">Datos de Compra</h3>
<main class="container my-4">
  <div class="row g-4">
    <!-- Datos personales -->
    <div class="col-lg-6">
      <div class="profile-card h-100 border border-primary rounded-3">
        <div class="card-header bg-primary text-black ">
          <h5 class="mb-0">Datos del usuario</h5>
        </div>
        <div class="card-body">
          <p class="bg-light p-2">Nombre: <%= nombre %></p>
          <p class="bg-light p-2">Apellidos: <%= apellidos  %></p>
          <p class="bg-light p-2">Contraseña: <%= clave %></p>
          <p class="bg-light p-2 ">Teléfono: <%= telefono %></p>
          <p class="bg-light p-2">Dirección: <%= direccion %></p>
          <p class="bg-light p-2 ">Código Postal: <%= codigoPostal %></p>
          <p class="bg-light p-2 ">Provincia: <%= provincia  %></p>
          <p class="bg-light p-2 ">Población: <%= poblacion  %></p>
          <p class="bg-light p-2 ">Formato Pago: <%= formaPago %></p>

        </div>
      </div>
    </div>

    <!-- Modificar datos -->
    <div class="col-lg-6">
      <div class="profile-card h-100 border border-primary rounded-3">
        <div class="card-header bg-primary text-black fw-bold">
          <h5 class="mb-0">Modificar datos</h5>
        </div>
        <form action="ActualizarDatosServlet2" method="post">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Nombre:</label>
              <input type="text" class="form-control" name="nombre" value="<%= nombre %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Apellidos:</label>
              <input type="text" class="form-control" name="apellidos" value="<%= apellidos %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Contraseña:</label>
              <input type="password" class="form-control" name="clave" value="<%= clave %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Teléfono:</label>
              <input type="tel" class="form-control" name="telefono" value="<%= telefono %>">
            </div>
            <div class="col-12">
              <label class="form-label">Dirección:</label>
              <input type="text" class="form-control" name="direccion" value="<%= direccion %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Código Postal:</label>
              <input type="text" class="form-control" name="codigoPostal" value="<%= codigoPostal %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Provincia:</label>
              <input type="text" class="form-control" name="provincia" value="<%= provincia %>">
            </div>
            <div class="col-md-6">
              <label class="form-label">Población:</label>
              <input type="text" class="form-control" name="poblacion" value="<%= poblacion %>">
            </div>
          </div>
          <div class="col-12">
          <label class="form-label d-block">Forma de pago:</label>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="formaPago" id="tarjeta" value="tarjeta">
            <label class="form-check-label" for="tarjeta">Tarjeta</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="formaPago" id="cuenta" value="cuenta">
            <label class="form-check-label" for="cuenta">Cuenta</label>
          </div>
        </div>
          <div class="card-footer bg-transparent p-3">
            <button type="submit" class="btn btn-warning w-100">Guardar cambios</button>
          </div>
        </form>
      </div>
    </div>

    <!-- Carrito -->
      <%
                List<Producto> carrito = (List<Producto>) session.getAttribute("carritoJSON");
                if (carrito != null && !carrito.isEmpty()) {
            %>
    <div class="col-12">
      <div class="profile-card border border-primary rounded-3">
        <div class="card-header bg-primary text-black ">
          <h5 class="mb-0">Carrito actual</h5>
        </div>
        <div class="card-body">
          <button class="btn text-black btn-secondary w-100 mb-3 " onclick="pedidoFormalizado('contenedor-pedidos')">Mostrar pedido</button>
          <div id="contenedor-pedidos" class="overflow-auto" style="max-height: 300px;">
          <% 
                            float totalPedido = 5;
                            for (Producto producto : carrito) {
                                float totalProducto = producto.getPrecio() * producto.getCantidad();
                                totalPedido += totalProducto;
                            }
                        %>
          <h5>Total del pedido: <%= totalPedido %> €</h5>
          <%
                } else {
            %>
                <p>No hay productos en el carrito.</p>
            <%
                }
            %> 
          </div>
          <div class="mt-4 border-top pt-3">
            <div class="row">
              <div class="col-md-6 mb-3 mb-md-0">
                <a href="carrito.html" class="btn btn-outline-bg-primary w-100 bg-blue text-white">
                  <i class="fas fa-arrow-left me-2"></i>Seguir comprando
                </a>
              </div>
              <div class="col-md-6 mb-3 mb-md-0">
                  <form action="TramitacionPedidoServlet" method="POST" class="d-inline">
                    
                     <button type="submit" id="comprar" class="btn btn-outline-bg-primary w-100 bg-blue text-white"><i class="fas fa-credit-card me-2 ">
                     </i>Finalizar pedido</button>
                     </div>
                  </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    
</main>

<mi-pie></mi-pie>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="./js/mis-etiquetas.js"></script>
<script src="./js/carrito.js"></script>
<script src="./js/libjson.js"></script>
<script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
</body>
</html>