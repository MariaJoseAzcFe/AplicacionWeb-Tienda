<?php 
    require_once('../model/AccesoBD.php');
    
    session_start();

    if (isset($_SESSION['usuario'])) {
        header("Location: ListarUsuarios.php");
    } elseif (isset($_POST['p_usuario']) && isset($_POST['p_clave'])) {
        
        if (AccesoBD::comprobarUsuarioAdmin($_POST['p_usuario'],$_POST['p_clave'])) {
       
            $_SESSION['usuario']=$_POST['p_usuario'];
            header("Location: ListarUsuarios.php");
            
        } else {
            $_REQUEST['msg']='Error en usario y/o clave';
            $_REQUEST['a_usuario']=$_POST['p_usuario'];
            include_once '../view/LoginForm.php';
        }
    
    } else {
        include_once '../view/LoginForm.php';
    }
         
?>