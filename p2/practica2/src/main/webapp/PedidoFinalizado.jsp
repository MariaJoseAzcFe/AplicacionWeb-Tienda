<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Pedido Finalizado</title>
    <link rel="stylesheet" href="./css/styles.css"> 
</head>
<body>

    <header>
        <h1>¡Gracias por tu compra!</h1>
        <p>Tu pedido ha sido procesado con éxito.</p>
    </header>

    <div class="contenido">
        <h2>Resumen del Pedido</h2>
        <table border="1">
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="producto" items="${sessionScope.carritoJSON}">
                    <tr>
                        <td>${producto.descripcion}</td>
                        <td>${producto.cantidad}</td>
                        <td>${producto.precio}</td>
                        <td>${producto.cantidad * producto.precio}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h3>Datos de Envío y Facturación</h3>
        <p><strong>Nombre:</strong> ${sessionScope.nombre}</p>
        <p><strong>Dirección:</strong> ${sessionScope.direccion}</p>
        <p><strong>Código Postal:</strong> ${sessionScope.codigoPostal}</p>
        <p><strong>Forma de Pago:</strong> ${sessionScope.formaPago}</p>

        <h3>Total del Pedido</h3>
        <p>
            <strong>Total a pagar:</strong>
            <c:set var="total" value="0" />
            <c:forEach var="producto" items="${sessionScope.carritoJSON}">
                <c:set var="total" value="${total + (producto.cantidad * producto.precio)}" />
            </c:forEach>
            ${total}
        </p>

        <div class="acciones">
            <a href="inicio.jsp" class="boton">Volver a la tienda</a>
            <a href="historialPedidos.jsp" class="boton">Ver mis pedidos</a>
        </div>
    </div>

    <mi-pie></mi-pie>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./js/mis-etiquetas.js"></script>
    <script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
    <script src="./js/carrito.js"></script>
</body>
</html>
