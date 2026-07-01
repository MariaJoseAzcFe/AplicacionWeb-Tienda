<?php
require_once '../model/AccesoBD.php'; 
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}

// Si se pide limpiar los filtros
if (isset($_GET['limpiar'])) {
    unset($_SESSION['resultado_busqueda_pedidos']);
    unset($_SESSION['filtros_pedidos']);
    header("Location: ../control/ListarPedidos.php");
    exit;
}

// Recoger los valores del formulario
$filtros = [
    'usuario'  => trim($_GET['usuario'] ?? ''),
    'producto' => trim($_GET['producto'] ?? ''),
    'fecha_op' => $_GET['fecha_op'] ?? '=',
    'fecha'    => trim($_GET['fecha'] ?? '')
];

// Comprobar si hay al menos un filtro activo
if ($filtros['usuario'] !== '' || $filtros['producto'] !== '' || $filtros['fecha'] !== '') {
    $pedidos = AccesoBD::buscarPedidosAvanzado($filtros);
    $_SESSION['resultado_busqueda_pedidos'] = $pedidos;
    $_SESSION['filtros_pedidos'] = $filtros;
} else {
    unset($_SESSION['resultado_busqueda_pedidos']);
    unset($_SESSION['filtros_pedidos']);
}

header("Location: ../control/ListarPedidos.php");
exit;