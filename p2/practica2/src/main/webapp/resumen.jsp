<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="css/style.css" />
  <title>Resumen Pedido</title>
</head>
<body>

<%
  String mensaje = (String) session.getAttribute("mensaje");
  if (mensaje != null) {
    session.removeAttribute("mensaje");
%>
  <div class="alert alert-info text-center" role="alert">
    <%= mensaje %>
  </div>
<%
  }

  Integer idPedido = (Integer) request.getAttribute("idPedido");

  UsuarioBD usuarioBD = (UsuarioBD) session.getAttribute("usuarioBD");

  String nombre = "Sin rellenar";
  String apellidos = "Sin rellenar";
  String direccion = "Sin rellenar";
  String codigoPostal = "Sin rellenar";
  String fpago = "Sin rellenar";

  if (usuarioBD != null) {
    nombre = usuarioBD.getNombre();
    apellidos = usuarioBD.getApellidos();
    direccion = usuarioBD.getDireccion();
    codigoPostal = usuarioBD.getCodigoPostal();
    fpago = (String) session.getAttribute("formatopago");
  }

  List<Producto> carrito = (List<Producto>) session.getAttribute("carritoJSON");
%>

<div class="container my-5">
  <h2 class="titulos">Resumen del Pedido</h2>

  <div class="row g-4">
    <!-- Datos del cliente -->
    <div class="col-lg-6 mx-auto">
      <div class="card border border-primary">
        <div class="card-header bg-primary text-black">
          <h5 class="mb-0">Datos del Cliente</h5>
        </div>
        <div class="card-body bg-light">
          <p><strong>Pedido Nº:</strong> <span class="text-primary"><%= (idPedido != null ? idPedido : "No disponible") %></span></p>
          <p><strong>Nombre:</strong> <%= nombre %></p>
          <p><strong>Apellidos:</strong> <%= apellidos %></p>
          <p><strong>Dirección:</strong> <%= direccion %></p>
          <p><strong>Código Postal:</strong> <%= codigoPostal %></p>
          <p><strong>Forma de Pago:</strong> <%= fpago %></p>
        </div>
      </div>
    </div>

    <!-- Productos en el carrito -->
    <div class="col-12">
<%
  if (carrito != null && !carrito.isEmpty()) {
%>
      <div class="card border border-primary">
        <div class="card-header bg-primary text-black">
          <h5 class="mb-0">Productos del Pedido</h5>
        </div>
        <div class="card-body table-responsive">
          <table class="table table-bordered table-hover align-middle mb-0">
            <thead class="table-light">
              <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
<%
    float totalPedido = 0f;
    for (Producto producto : carrito) {
        float totalProducto = producto.getPrecio() * producto.getCantidad();
        totalPedido += totalProducto;
%>
              <tr>
                <td><%= producto.getDescripcion() %></td>
                <td><%= producto.getCantidad() %></td>
                <td><%= String.format("%.2f", producto.getPrecio()) %> €</td>
                <td><%= String.format("%.2f", totalProducto) %> €</td>
              </tr>
<%
    }
%>
            </tbody>
          </table>
        </div>
        <div class="card-footer text-end">
          <h5 class="text-success">Total del pedido: <strong><%= String.format("%.2f", totalPedido) %> €</strong></h5>
        </div>
      </div>

      <% session.removeAttribute("carritoJSON"); %>
    

      <div class="mt-4 text-center">
        <a href="index.jsp" class="btn btn-primary text-black">
          <i class="fas fa-arrow-left me-2"></i>Volver a la tienda
        </a>
      </div>
<%
  } else {
%>
      <div class="alert alert-warning text-center">
        No hay productos en el carrito.
      </div>
<%
  }
%>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="./js/mis-etiquetas.js"></script>
<script src="./js/carrito.js"></script>
<script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
<!--  <script>eliminarCarrito()</script> -->
</body>
</html>
