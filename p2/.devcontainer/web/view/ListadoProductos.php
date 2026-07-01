<?php
$productos = $_REQUEST['listado-productos'] ?? [];
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Zona Administración - Productos</title>
    <link rel="icon" type="image/ico" href="img/icono.ico" sizes="64x64">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <mi-menu-admin></mi-menu-admin>
            <div class="container mt-3">
            <?php if (isset($_SESSION['mensaje_exito'])): ?>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <?= $_SESSION['mensaje_exito'] ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <?php unset($_SESSION['mensaje_exito']); ?>
            <?php endif; ?>

            <?php if (isset($_SESSION['mensaje_error'])): ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <?= $_SESSION['mensaje_error'] ?>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <?php unset($_SESSION['mensaje_error']); ?>
            <?php endif; ?>
        </div>
        <div class="container admin-container mt-5 mb-5">
        <h2 class="mb-4">Gestión de Productos</h2>
        <div class="justify-content-between align-items-center mb-4">
            <a href="../view/FormularioInsertarProducto.php" class="btn btn-success">Añadir Producto</a>
        </div>
        <form class="mb-3" method="GET" action="../control/BuscarProducto.php">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Buscar producto..." name="buscar" value="<?= $_REQUEST['termino-buscado'] ?? '' ?>">
                
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Buscar
                </button>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Código</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Existencias</th>
                        <th>Imagen</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (!empty($productos)) : ?>
                        <?php foreach ($productos as $producto) : ?>
                            <tr>
                                <td><?= $producto['codigo'] ?></td>
                                <td><?= $producto['descripcion'] ?></td>
                                <td><?= $producto['precio'] ?> €</td>
                                <td><?= (int) $producto['existencias'] ?></td>
                                <td>
                                    <?php if (!empty($producto['imagen'])): ?>
                                        <img src="<?= $producto['imagen'] ?>" alt="Imagen" class="img-thumbnail" style="width: 100px;">
                                    <?php else: ?>
                                        <span class="text-muted">Sin imagen</span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    
                                    <a href="../control/EditarProductos.php?codigo=<?= urlencode($producto['codigo']) ?>" class="btn btn-warning btn-sm">Editar</a> <!-- El urlencode se supone que es para cifrar el codigo en la url, más seguro, lo he puesto por si -->

                                    <form method="post" action="../control/EliminarProducto.php" style="display:inline;">
                                        <input type="hidden" name="codigo" value="<?= $producto['codigo'] ?>">
                                        <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                                    </form>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php else: ?>
                        <tr><td colspan="6" class="text-center text-muted">No hay productos registrados.</td></tr>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>

    <mi-pie></mi-pie>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/mis-etiquetas.js"></script>
</body>
</html>
