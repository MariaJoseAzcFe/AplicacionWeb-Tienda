<?php 
    require_once('../model/AccesoBD.php');

	session_start();

	if (isset($_SESSION['usuario'])) {
    
    	$usuarios = AccesoBD::obtenerListadoUsuarios();
    
    	$_REQUEST['listado-usuarios']=$usuarios;
    	
    	include_once '../view/ListadoUsuarios.php';
	} else {
    	header("Location: Login.php");
	}
      
?>