<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="./css/style.css">
    <title>Productos</title>
</head>
<body>
    <mi-menu></mi-menu>

    <div class="bubbles-container">
        <div class="container d-flex flex-column flex-grow-2 py-3">
    <h3 class="titulos ">Productos</h3>
    <div class="container-fluid">
            <%
    // Obtener productos de la base de datos
    AccesoBD con = AccesoBD.getInstance();
    List<ProductoBD> productos = con.obtenerProductosBD();

    if (productos == null || productos.isEmpty()) {
%>
    <div class="alert alert-warning text-center">No hay productos disponibles actualmente.</div>
<%
    } else {
        int count = 0;
        for (ProductoBD producto : productos) {
            // Abrimos una nueva fila cada 3 productos
            if (count % 3 == 0) {
%>
            <div class="row mb-4 "> <%
            }

            boolean esFondoAmarillo = (count % 6 == 1 || count % 6 == 4);
            String bgColor = esFondoAmarillo ? "bg-yellow text-black" : "bg-primary text-white";
            String btnClass = esFondoAmarillo ? "btn-primary bg-blue text-white" : "btn-yellow text-black";
%>
                <div class="col-12 col-sm-6 col-lg-4 efecto-pompa">
                    
                    <div class="<%= bgColor %> p-3 d-flex flex-column h-100 rounded-3">
                        <img class="imagenproducto w-100 mb-3" src="<%= request.getContextPath() %><%= producto.getImagen() %>" alt="<%= producto.getNombre() %>">
                        <h3 class="titulo-productos text-center mb-2"><%= producto.getNombre() %></h3>
                         <p><%= producto.getDescripcion() %></p> 
                        <p class="precio text-center"><%= producto.getPrecio() %>€</p>
                        <p class="stock-info text-center mb-3">Disponibles: <%= producto.getStock() %></p>
                        
                        <% if (producto.getStock() > 0) { %>
                            <button class="btn <%= btnClass %> mt-auto w-100" 
                            data-bs-toggle="modal" 
                            data-bs-target="#myModal"
                            onclick='anadirCarrito(<%= producto.getCodigo() %>, "<%= producto.getDescripcion().replace("\"", "\\\"").replace("'", "\\'") %>", "<%= request.getContextPath() %><%= producto.getImagen() %>", <%= producto.getPrecio() %>, <%= producto.getStock() %>)'>
                            Comprar
                            </button>
                        <% } else { %>
                            <button class="btn btn-secondary mt-auto py-2 w-100" disabled>Agotado</button>
                        <% } %>
                    </div>
                </div>
<%
            count++;
            // Cerramos la fila si ya imprimimos 3 productos, o si es el ÚLTIMO producto de la lista
            if (count % 3 == 0 || count == productos.size()) {
%>
            </div> <%
            }
        }
    }
%>
    </div>
</div>
</div>

    <mi-pie></mi-pie>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./js/mis-etiquetas.js"></script>
    <script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
    <script src="./js/carrito.js"></script>
</body>
</html>
