<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.List, tienda.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
	<head>
		<title>Fish it!</title>
		<link rel="icon" type="image/ico" href="img/icono.ico" sizes="64x64">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="./css/style.css">

	</head>
	<body>
		<mi-cabecera></mi-cabecera>
		<mi-menu></mi-menu>
        <header class="video-background">
	<!-- Carousel -->
       <div class="bubbles-container">
	<div class="container my-4 efecto-pompa"> 
    <div class="row justify-content-center"> 
        <div class="col-12"> 
	<div id="demo" class="carousel slide border border-5 border-primary rounded-3" data-bs-ride="carousel" autoplay="true">

	<div class="carousel-indicators">
		<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
	</div>
	
	<div class="carousel-inner">
		<div class="carousel-item active">
		<video class="d-block w-100" controls>
			<source src="videos/broly.mp4" type="video/mp4">
			Your browser does not support the video tag.
		</video>
		</div>
		<div class="carousel-item">
		<video class="d-block w-100" controls>
			<source src="videos/venom.mp4" type="video/mp4">
			Your browser does not support the video tag.
		</video>
		</div>
		<div class="carousel-item">
		<video class="d-block w-100" controls>
			<source src="videos/zenitsu.mp4" type="video/mp4">
			Your browser does not support the video tag.
		</video>
		</div>
	</div>
	

	<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
		<span class="carousel-control-prev-icon"></span>
	</button>
	<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
		<span class="carousel-control-next-icon"></span>
	</button>
	</div>
        </div>
    </div>
  </div>


	
<!-- SECCION 2 -->
		<div class=" container d-flex flex-column flex-grow-2 py-3">
			<h2 class="titulos">Novedades</h2>
			<div class="container-fluid">
        <%
        AccesoBD con = AccesoBD.getInstance();
        List<ProductoBD> productos = con.obtenerProductosBD();

        if (productos == null || productos.isEmpty()) {
        %>
            <div class="alert alert-warning text-center">No hay productos disponibles actualmente.</div>
        <%
        } else {
            int count = 0;
            // Mostramos un máximo de 3 productos
            for (int i = 0; i < productos.size() && i < 3; i++) {
                ProductoBD producto = productos.get(i);
                
                if (count % 3 == 0) {
        %>
                <div class="row">
        <%
                }

                // Lógica de colores para intercalar como en tu HTML estático (Azul, Amarillo, Azul)
                String bgColor = (count % 2 == 0) ? "bg-primary text-white" : "bg-yellow text-black";
                String btnClass = (count % 2 == 0) ? "btn-yellow text-black" : "btn-primary bg-blue text-white";
        %>
                    <div class="col-sm <%= bgColor %> p-3 efecto-pompa">
                        <div class="producto d-flex flex-column h-100">
                            
                            <img class="imagenproducto" src="<%= request.getContextPath() %><%= producto.getImagen() %>" alt="<%= producto.getDescripcion() %>">
                            
                            <h3 class="titulo-productos"><%= producto.getNombre() %></h3>
                            
                            <p><%= producto.getDescripcion() %></p> 
                            
                            <p class="precio"><%= producto.getPrecio() %>€</p>
                            <p class="stock-info text-center mb-3">Disponibles: <%= producto.getStock() %></p>
                            <% if (producto.getStock() > 0) { %>
                                <button class="btn <%= btnClass %> mt-auto" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#myModal"
                                    onclick='anadirCarrito(<%= producto.getCodigo() %>, "<%= producto.getDescripcion().replace("\"", "\\\"").replace("'", "\\'") %>", "<%= request.getContextPath() %><%= producto.getImagen() %>", <%= producto.getPrecio() %>, <%= producto.getStock() %>)'>
                                    Comprar
                                </button>
                            <% } else { %>
                                <button class="btn btn-secondary mt-auto py-2" disabled>Agotado</button>
                            <% } %>
                            
                        </div>
                    </div>
        <%
                count++;
                // Cerramos la fila cuando llegamos a 3 productos o al final de la lista
                if (count % 3 == 0 || count == Math.min(productos.size(), 3)) {
        %>
                </div>
        <% 
                }
            }
        }
        %>
    </div>
        </div>

    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    Añadido con éxito.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn text-black btn-success" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</div>
<mi-pie></mi-pie>
	
		<script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
		<script src="./js/mis-etiquetas.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
		<script src="./js/carrito.js"></script>
	</body>
</html>