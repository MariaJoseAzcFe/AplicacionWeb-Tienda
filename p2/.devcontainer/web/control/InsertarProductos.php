<?php
include_once('../model/AccesoBD.php');
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $descripcion = $_POST['descripcion'] ?? '';
    $precio = floatval($_POST['precio'] ?? 0);
    $existencias = intval($_POST['existencias'] ?? 0);
    $imagen = $_POST['imagen'] ?? ''; 

    $insertado = AccesoBD::insertarProducto($descripcion, $precio, $existencias, $imagen);
    if ($insertado) {
        $_SESSION['mensaje_exito'] = "El producto se ha creado correctamente.";
    } else {
        $_SESSION['mensaje_error'] = "Ha ocurrido un error al guardar el producto.";
    }
    
    header("Location: ../control/ListarProductos.php");
    exit;
}


