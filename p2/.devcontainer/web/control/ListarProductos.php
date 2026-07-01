<?php 
    require_once('../model/AccesoBD.php');

	session_start();

	if (isset($_SESSION['usuario'])) {
		if (isset($_SESSION['resultado_busqueda'])) {
			$productos = $_SESSION['resultado_busqueda'];
			$_REQUEST['termino-buscado'] = $_SESSION['termino_busqueda'];
			
			unset($_SESSION['resultado_busqueda']);
			unset($_SESSION['termino_busqueda']);
		} else {
			
			$productos = AccesoBD::obtenerListadoProductos();
			$_REQUEST['termino-buscado'] = ''; 
		}
		$_REQUEST['listado-productos'] = $productos;
		include_once '../view/ListadoProductos.php';
	} else {
    	header("Location: Login.php");
	}
      
?>