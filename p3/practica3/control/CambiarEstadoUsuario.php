<?php
// ListadoUsuariosController.php
include_once('../model/AccesoBD.php');
session_start();

if (!isset($_SESSION['usuario'])) {
    header("Location: ../Login.php");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $codigo = intval($_POST['id']);
    $nuevo_estado = intval($_POST['nuevo_estado']);

    $resultado = AccesoBD::cambiarEstadoUsuario($codigo, $nuevo_estado);
    if (!$resultado) {
        error_log("Error: No se pudo cambiar el estado del usuario ID " . $codigo);
    }
    
    // Después de cambiar estado, redirige al controlador listado usuarios
    header("Location: ../control/ListarUsuarios.php");

}
?>