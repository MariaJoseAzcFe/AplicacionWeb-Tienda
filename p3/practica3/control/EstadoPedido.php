<?php

include_once('../model/AccesoBD.php');
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $codigo = intval($_POST['codigo']);
    $nuevo_estado_descripcion = $_POST['nuevo_estado'];  // ej: 'Pendiente', 'Enviado', etc.

    
    $nuevo_estado_codigo = AccesoBD::obtenerCodigoEstado($nuevo_estado_descripcion);

    if ($nuevo_estado_codigo !== null) {
        $resultado = AccesoBD::actualizarEstadoPedido($codigo, $nuevo_estado_codigo);
        if (!$resultado) {
            error_log("Error: No se pudo actualizar el pedido ID " . $codigo);
        }
    } else {
        exit("Estado no válido.");
    }

    header("Location: ../control/ListarPedidos.php");
}
?>
