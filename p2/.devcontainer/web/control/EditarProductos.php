<?php
include_once('../model/AccesoBD.php');
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Mostrar formulario para editar producto
    $codigo = $_GET['codigo'] ?? '';

    if ($codigo === '') {
        header("Location: ../control/ListarProductos.php");
        exit;
    }

    $producto = AccesoBD::obtenerProductoPorCodigo($codigo);

    if (!$producto) {
        // Producto no encontrado
        header("Location: ../control/ListarProductos.php");
        exit;
    }
    $_REQUEST['producto'] = $producto;
    include '../view/FormularioEditarProducto.php';

} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Procesar edición y guardar cambios
    $codigo = $_POST['codigo'] ?? '';
    $descripcion = $_POST['descripcion'] ?? '';
    $precio = floatval($_POST['precio'] ?? 0);
    $existencias = intval($_POST['existencias'] ?? 0);
    $imagen = $_POST['imagen'] ?? '';

    if ($codigo !== '') {
        AccesoBD::editarProducto($codigo, $descripcion, $precio, $existencias, $imagen);
    }

    header("Location: ../control/ListarProductos.php");
    exit;
} else {

    header("Location: ../control/ListarProductos.php");
    exit;
}
?>
