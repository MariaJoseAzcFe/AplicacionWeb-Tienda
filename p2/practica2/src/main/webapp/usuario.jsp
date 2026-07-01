<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="tienda.*,java.util.List,java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi perfil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>

<%-- Verificación de sesión y mensaje de error --%>
<%
String mensaje = (String)session.getAttribute("mensaje");
String usuario = "Sin rellenar";
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
    }
   
    if (session.getAttribute("usuario") != null) {
        usuario = (String) session.getAttribute("usuario");
    }
}
%>

<mi-menu></mi-menu>

<div class="bubbles-container">
    <main class="container py-5">
        
        <%-- Mostrar mensajes de la sesión si existen --%>
        <% if (mensaje != null) { session.removeAttribute("mensaje"); %>
            <div class="alert alert-info text-center shadow-sm" role="alert">
                <h4 class="mb-0"><%=mensaje%></h4>
            </div>
        <% } %>

        <div class="mb-5 w-100">
            <h2 class="titulos text-center mb-5">Mi Perfil</h2>
            
            <div class="row g-4">
                <div class="col-lg-6">
                    <div class="table-responsive bg-white rounded shadow-sm p-4 h-100">
                        <table class="table table-borderless mb-0">
                            <thead class="table-light border-bottom">
                                <tr>
                                    <th colspan="2" class="text-center h5 py-3"><i class="fa-solid fa-user me-2"></i> Datos Personales</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><th scope="row" class="w-25">Usuario:</th><td><%= usuario %></td></tr>
                                <tr><th scope="row">Nombre:</th><td><%= nombre %></td></tr>
                                <tr><th scope="row">Apellidos:</th><td><%= apellidos %></td></tr>
                                <tr><th scope="row">Contraseña:</th><td><%= clave %></td></tr>
                                <tr><th scope="row">Teléfono:</th><td><%= telefono %></td></tr>
                                <tr><th scope="row">Dirección:</th><td><%= direccion %></td></tr>
                                <tr><th scope="row">C. Postal:</th><td><%= codigoPostal %></td></tr>
                                <tr><th scope="row">Provincia:</th><td><%= provincia %></td></tr>
                                <tr><th scope="row">Población:</th><td><%= poblacion %></td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="bg-white rounded shadow-sm p-4 h-100">
                        <div class="table-light border-bottom mb-3 pb-3">
                            <h5 class="text-center mb-0 fw-bold"><i class="fa-solid fa-pen-to-square me-2"></i> Modificar datos</h5>
                        </div>
                        <form action="ActualizarDatosServlet" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Nombre:</label>
                                    <input type="text" class="form-control" name="nombre" value="<%= nombre %>">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Apellidos:</label>
                                    <input type="text" class="form-control" name="apellidos" value="<%= apellidos %>">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Contraseña:</label>
                                    <input type="password" class="form-control" name="clave" value="<%= clave %>">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-bold">Teléfono:</label>
                                    <input type="tel" class="form-control" name="telefono" value="<%= telefono %>">
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-bold">Dirección:</label>
                                    <input type="text" class="form-control" name="direccion" value="<%= direccion %>">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">C. Postal:</label>
                                    <input type="text" class="form-control" name="codigoPostal" value="<%= codigoPostal %>">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Provincia:</label>
                                    <input type="text" class="form-control" name="provincia" value="<%= provincia %>">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label fw-bold">Población:</label>
                                    <input type="text" class="form-control" name="poblacion" value="<%= poblacion %>">
                                </div>
                                <div class="col-12 mt-3 text-center">
                                    <label class="form-label d-block fw-bold mb-2">Forma de pago:</label>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="formaPago" id="tarjeta" value="tarjeta">
                                        <label class="form-check-label" for="tarjeta">Tarjeta</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="formaPago" id="cuenta" value="cuenta">
                                        <label class="form-check-label" for="cuenta">Cuenta</label>
                                    </div>
                                </div>
                                <div class="col-12 mt-4 text-center">
                                    <button type="submit" class="btn bg-yellow text-black px-4 py-2 fw-bold w-100">Guardar cambios</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        
        <div class="w-100 mt-5">
            <h2 id="perfil" class="titulos text-center mb-5">Pedidos realizados</h2>
            
        </div>

    
        <div class="w-100 mt-4 text-center">
            <form action="PedidosServlet" method="post" class="mb-4">
                <button type="submit" class="btn bg-blue px-5 py-3 text-white fw-bold shadow">Ver Historial de Pedidos Completo</button>
            </form>
        </div>

        <%
        List<PedidoBD> pedidos = (List<PedidoBD>) request.getAttribute("pedidos");
        if (pedidos != null && !pedidos.isEmpty()) {
        %>
        <div class="w-100 mb-5">
            <div class="bg-white rounded shadow-sm p-4">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light border-bottom">
                            <tr>
                                <th class="text-center py-3">ID</th>
                                <th class="py-3">Importe</th>
                                <th class="py-3">Estado</th>
                                <th class="text-center py-3">Detalles</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (PedidoBD pedido : pedidos) { %>
                            <tr>
                                <td class="text-center fw-bold">#<%= pedido.getCodigo() %></td>
                                <td><%= pedido.getImporte() %> €</td>
                                <td>
                                    <%
                                        List<EstadoBD> estados = (List<EstadoBD>) request.getAttribute("estados");
                                        String estadoTexto = "Desconocido";
                                        if (estados != null) {
                                            for (EstadoBD est : estados) {
                                                if (est.getEstado() == pedido.getEstado()) {
                                                    estadoTexto = est.getEstadoLetra();
                                                    break;
                                                }
                                            }
                                        }
                                    %>
                                    <span class="badge bg-secondary text-white px-3 py-2"><%= estadoTexto %></span>
                                    
                                    <% if (pedido.getEstado() == 1) { %>
                                    <form action="EstadoServlet" method="post" class="d-inline-block ms-2 m-0">
                                        <input type="hidden" name="accion" value="cancelar">
                                        <input type="hidden" name="idPedido" value="<%= pedido.getCodigo() %>">
                                        <button type="submit" class="btn btn-warning btn-sm fw-bold">Cancelar</button>
                                    </form>
                                    <% } %>
                                </td>
                                <td class="text-center">
                                    <form action="PedidosServlet" method="post" class="m-0">
                                        <input type="hidden" name="accion" value="verDetalles">
                                        <input type="hidden" name="idPedido" value="<%= pedido.getCodigo() %>">
                                        <button type="submit" class="btn bg-yellow text-black btn-sm px-3">Ver Detalles</button>
                                    </form>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <% } %>

        <%
        List<DetallesBD> detalles = (List<DetallesBD>) request.getAttribute("detalles");
        if (detalles != null && !detalles.isEmpty()) {
        %>
        <div class="w-100 mb-5">
            <div class="bg-white rounded shadow-sm p-4 border border-success">
                <h4 class="text-center text-success mb-4"><i class="fa-solid fa-list-check me-2"></i>Detalles del Pedido</h4>
                <div class="table-responsive">
                    <table class="table table-borderless table-hover align-middle mb-0">
                        <thead class="table-success border-bottom">
                            <tr>
                                <th class="py-3">Descripción</th>
                                <th class="text-center py-3">Cantidad</th>
                                <th class="text-end py-3">Precio Unitario</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (DetallesBD detalle : detalles) { %>
                            <tr>
                                <td class="fw-normal"><%= detalle.getDescripcion() %></td>
                                <td class="text-center"><span class="badge bg-light text-dark border"><%= detalle.getCantidad() %></span></td>
                                <td class="text-end text-success "><%= detalle.getPrecioUnitario() %> €</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <% } %>

        <div class="w-100 mt-5 text-center">
            <form action="logout.html" method="POST">
                <input type="hidden" name="url" value="./usuario.jsp">
                <button type="submit" value="Cerrar Sesión" class="btn btn-danger px-5 py-2  shadow-sm">
                    <i class="fa-solid  fa-right-from-bracket me-2"></i> Cerrar Sesión
                </button>
            </form>
        </div>

    </main>
</div>

<mi-pie></mi-pie>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="./js/mis-etiquetas.js"></script>
<script src="./js/carrito.js"></script>
<script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
</body>
</html>