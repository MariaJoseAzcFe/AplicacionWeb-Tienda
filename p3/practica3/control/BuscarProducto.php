<?php
require_once '../model/AccesoBD.php'; 

session_start();


if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}


$busqueda = trim($_GET['buscar'] ?? '');

if ($busqueda !== '') {

    $productos = AccesoBD::buscarProductosPorCriterio($busqueda);
    $_SESSION['resultado_busqueda'] = $productos;
    $_SESSION['termino_busqueda'] = $busqueda;
} else {
    
    unset($_SESSION['resultado_busqueda']);
    unset($_SESSION['termino_busqueda']);
}

header("Location: ../control/ListarProductos.php");
exit;