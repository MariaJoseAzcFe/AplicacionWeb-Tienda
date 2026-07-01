<?php 
require_once('../model/AccesoBD.php');

session_start();

if (isset($_SESSION['usuario'])) {
    
    if (isset($_SESSION['resultado_busqueda_pedidos'])) {
        $pedidos = $_SESSION['resultado_busqueda_pedidos'];
        $_REQUEST['filtros-pedidos'] = $_SESSION['filtros_pedidos']; // Pasamos el array de filtros
        
        unset($_SESSION['resultado_busqueda_pedidos']);
        unset($_SESSION['filtros_pedidos']);
    } else {
        $pedidos = AccesoBD::obtenerListadoPedidos();
        $_REQUEST['filtros-pedidos'] = ['usuario' => '', 'producto' => '', 'fecha_op' => '=', 'fecha' => ''];
    }
    
    $_REQUEST['listado-pedidos'] = $pedidos;
    
    
    include_once '../view/ListadoPedidos.php';
} else {
    header("Location: Login.php");
    exit;
}
?>