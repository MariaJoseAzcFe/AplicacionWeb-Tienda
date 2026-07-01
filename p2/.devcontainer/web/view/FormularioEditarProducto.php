<?php 
    $producto = $_REQUEST['producto'] ?? [
        'codigo' => '', 
        'descripcion' => '', 
        'precio' => '', 
        'existencias' => '', 
        'imagen' => ''
    ]; 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <title>Editar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/style.css" />
</head>
<body>

    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card p-4 shadow w-100" style="max-width: 500px;">
            <h2 class="card-title text-center mb-4">Editar Producto</h2>

            <form method="post" action="../control/EditarProductos.php" autocomplete="off">
                <input type="hidden" name="codigo" value="<?= $producto['codigo'] ?>">

                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <input type="text" class="form-control" id="descripcion" name="descripcion"
                        value="<?= $producto['descripcion'] ?>" required />
                </div>
                <div class="mb-3">
                    <label for="precio" class="form-label">Precio:</label>
                    <input type="number" step="0.01" class="form-control" id="precio" name="precio"
                        value="<?= $producto['precio'] ?>" required />
                </div>
                <div class="mb-3">
                    <label for="existencias" class="form-label">Existencias:</label>
                    <input type="number" class="form-control" id="existencias" name="existencias"
                        value="<?= $producto['existencias'] ?>" required />
                </div>
                <div class="mb-3">
                    <label for="imagen" class="form-label">URL Imagen:</label>
                    <input type="text" class="form-control" id="imagen" name="imagen"
                        value="<?= $producto['imagen'] ?>" />
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <a href="../control/ListarProductos.php" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/mis-etiquetas.js"></script>
</body>
</html>
