<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login de Administración</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
    <body>
        <?php 
        if (isset($_REQUEST['msg'])) {
        ?>
        <div style="text-align: center; color: red">
        <?php echo $_REQUEST['msg']?>
        </div>
        <?php
        }
        if (isset($_REQUEST['a_usuario'])) {
            $a_usuario = $_REQUEST['a_usuario'];
        } else {
             $a_usuario = '';
        }   
        ?>
        
        <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow" style="width: 100%; max-width: 400px;">
            <h2 class="card-title text-center mb-4">Acceso de Administración</h2>
            <form name="" id="loginForm" method="POST" action="../control/Login.php" autocomplete="off">
               <div class="mb-3">
                    <label for="username" class="form-label">Usuario:</label>
                    <input type="text" class="form-control" id="username" name="p_usuario" value="<?php echo $a_usuario ?>"required autocomplete="off">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Contraseña:</label>
                    <input type="password" class="form-control" id="password" name="p_clave" required autocomplete="off">
                </div>
                <input type="submit" class="btn btn-primary w-100" value="Entrar">
            </form>
            </div>  
        </div>
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>