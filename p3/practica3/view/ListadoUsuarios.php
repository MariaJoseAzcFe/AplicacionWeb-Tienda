<?php
$usuarios = $_REQUEST['listado-usuarios'] ?? [];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Zona Administración - Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/style.css" />
</head>
<body>
    <mi-menu-admin></mi-menu-admin>

    <div class="container admin-container mt-5 mb-5">
        <h2 class="mb-4">Gestión de Usuarios</h2>
        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Código</th>
                        <th>Login</th>
                        <th>Es administrador</th>
                        <th>Activo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (empty($usuarios)): ?>
                        <tr><td colspan="5" class="text-center">No hay usuarios para mostrar.</td></tr>
                    <?php else: ?>
                        <?php foreach ($usuarios as $usuario): ?>
                            <tr>
                                <td><?= $usuario['codigo'] ?></td>
                                <td><?= $usuario['usuario'] ?></td>
                                <td>
                                    <?= ($usuario['admin'] == 1) ? 'Administrador' : 'Cliente' ?>
                                </td>
                                <td>
                                    <?= ($usuario['activo'] == 1) ? 'Activo' : 'Inactivo' ?>
                                </td>
                                <td>
                                    <form method="post" action="CambiarEstadoUsuario.php" class ="d-inline">
                                        <input type="hidden" name="id" value="<?= $usuario['codigo'] ?>">
                                        <input type="hidden" name="nuevo_estado" value="<?= ($usuario['activo'] == 1) ? 0 : 1 ?>">
                                        <button 
                                            type="submit" 
                                            class="btn <?= ($usuario['activo'] == 1) ? 'btn-danger' : 'btn-success' ?> btn-sm"
                                        >
                                            <?= ($usuario['activo'] == 1) ? 'Desactivar' : 'Activar' ?>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

    <mi-pie></mi-pie>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/mis-etiquetas.js"></script>
</body>
</html>
