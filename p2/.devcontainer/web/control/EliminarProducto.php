<?php
include_once('../model/AccesoBD.php');
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $codigo = intval($_POST['codigo'] ?? 0);

    if ($codigo > 0) {
        AccesoBD::eliminarProducto($codigo);
    }

    header("Location: ListarProductos.php");
    exit;
}

header("Location: ListarProductos.php");
exit;
