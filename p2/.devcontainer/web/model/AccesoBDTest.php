<?php require_once('AccesoBD.php'); ?>
<html lang="es">
	<head>
		<style>
		  .ok { 
            color: green;
           }
           .error { 
            color: red;
           }
		</style>
	</head>
	<body>
		<h1>Tests unitarios</h1>
		<ul>
<?php
    if (AccesoBD::comprobarUsuarioAdmin("rpenya", "12345"))
        echo "<li class='error'>Error en  unit test comprobarUsuarioAdmin 1</li>";
    else 
        echo "<li class='ok'>Correcto unit test comprobarUsuarioAdmin 1</li>";
?>
<?php
    if (AccesoBD::comprobarUsuarioAdmin("admin", "4dm1N"))
       echo "<li class='ok'>Correcto unit test comprobarUsuarioAdmin 2</li>";
    else 
        echo "<li class='error'>Error en  unit test comprobarUsuarioAdmin 2</li>";
?>
<?php
    if (AccesoBD::comprobarUsuarioAdmin("admin", "admin"))
       echo "<li class='error'>Error en  unit test comprobarUsuarioAdmin 3</li>";
    else 
        echo "<li class='ok'>Correcto unit test comprobarUsuarioAdmin 3</li>";
        
?>
<?php
if (AccesoBD::insertarProducto("TestProducto",69.69,69,"test.png"))
       echo "<li class='ok'>Correcto en  unit test insertarProducto</li>";
    else 
        echo "<li class='error'>Error en unit test insertarProducto</li>";
        
?>
<?php
if (count(AccesoBD::obtenerListadoUsuarios())>0)
       echo "<li class='ok'>Correcto en  unit test obtenerListadoUsuarios</li>";
    else 
        echo "<li class='error'>Error en unit test obtenerListadoUsuarios</li>";
        
?>
	</ul>
</body>
</html>
