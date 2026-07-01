<%@page language="java" contentType="text/html;charset=UTF-8" import="tienda.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
	<%-- Utilizamos una variable en la sesión para informar de los mensajes de Error --%>
	<%
	String mensaje = (String)session.getAttribute("mensaje");

	if (mensaje != null) {
	%>
	<%-- Eliminamos el mensaje consumido --%>
	<%
		session.removeAttribute("mensaje");
	%>
	<h1> <%=mensaje%> </h1>
	<%
	}
	%>

	<%-- Si no hay código de usuario o no es válido --%>

	<%
	if ((session.getAttribute("codigo") == null) ||
	    ((Integer)session.getAttribute("codigo") <=0 ))
	{
	%>
        <%-- Mostramos el formulario para la introducción del usuario y la clave --%>
        
        <mi-menu></mi-menu>
		<div class="bubbles-container">
        <div class="login-container">
        <h2 class="titulos">Iniciar sesión</h2>
            <form method="post" action="login.html">
                <input type="hidden" name="url" value="./loginUsuario.jsp">
                Usuario: <input name="usuario" type="text"/> <br/><br/>
                Contrase&ntilde;a : <input name="clave" type="password"/>
                <br/><br/>
               
                <input type="submit" value="Entrar" class="btn bg-yellow text-black"/>
                <p class="text-center">¿No tienes cuenta? <a href="registro.jsp">Regístrate</a></p>
                
            </form>
		
        </div>
		</div>
        <mi-pie></mi-pie>
	<%
	} else {
		// Si existe un usuario, se redirige a la página que toca, por ejemplo compra.jsp, aunque podría ser las preferencias del usuario.
		response.sendRedirect("./carrito.html");
	}
	%>
    
    <script src="https://kit.fontawesome.com/b94f3ebffd.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./js/mis-etiquetas.js"></script>
</body>
</html>