<?php $pedidos = $_REQUEST['listado-pedidos'] ?? []; 
$filtros = $_REQUEST['filtros-pedidos'] ?? ['usuario' => '', 'producto' => '', 'fecha_op' => '=', 'fecha' => '']; 
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Zona Administración - Pedidos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">

</head>
<body>
<mi-menu-admin></mi-menu-admin>

 <div class="container admin-container mt-5 mb-5">
        <h2 class="mb-4">Gestión de Pedidos</h2>
    <form class="mb-4 mx-auto p-3 border rounded bg-light w-100"  method="GET" action="../control/BuscarPedido.php">
    <div class="row g-3 align-items-end">
        
        <div class="col-12 col-md-6 col-xl-3">
            <label class="form-label">Usuario / Cliente:</label>
            <input type="text" class="form-control" name="usuario" placeholder="Nombre..." value="<?= $filtros['usuario'] ?>">
        </div>

        <div class="col-12 col-md-6 col-xl-3">
            <label class="form-label">Producto:</label>
            <input type="text" class="form-control" name="producto" placeholder="Nombre del producto..." value="<?= $filtros['producto'] ?>">
        </div>

        <div class="col-12 col-md-4 col-xl-2">
            <label class="form-label">Condición Fecha:</label>
            <select name="fecha_op" class="form-select">
                <option value="=" <?= $filtros['fecha_op'] === '=' ? 'selected' : '' ?>>Igual a</option>
                <option value="<=" <?= $filtros['fecha_op'] === '<=' ? 'selected' : '' ?>>Menor o igual</option>
                <option value=">=" <?= $filtros['fecha_op'] === '>=' ? 'selected' : '' ?>>Mayor o igual</option>
            </select>
        </div>

        <div class="col-12 col-md-4 col-xl-2">
            <label class="form-label">Fecha:</label>
            <input type="date" class="form-control" name="fecha" value="<?= $filtros['fecha'] ?>">
        </div>

        <div class="col-12 col-md-4 col-xl-2 d-flex gap-2">
            <button type="submit" class="btn btn-primary w-100 text-center">
                <i class="fas fa-search"></i> Buscar
            </button>
            <a href="../control/ListarPedidos.php" class="btn btn-secondary w-100 text-center">
                Limpiar
            </a>
        </div>
        
    </div>
</form>
        <div class="table-responsive mx-auto">
            <table class="table table-bordered table-striped align-items-center">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Fecha</th>
                    <th>Total</th>
                    <th>Estado actual</th>
                    <th>Cambiar estado</th>
                </tr>
            </thead>
            <tbody>
                <?php if (empty($pedidos)): ?>
                    <tr><td colspan="6" class="text-center">No hay pedidos registrados.</td></tr>
                <?php else: ?>
                    <?php foreach ($pedidos as $pedido): ?>
                        <tr>
                            <td><?= $pedido['codigo'] ?></td>
                            <td><?= $pedido['cliente'] ?></td>
                            <td><?= $pedido['fecha'] ?></td>
                            <td><?= number_format($pedido['total'], 2) ?> €</td>
                            <td><?= $pedido['estado'] ?></td>
                            <td>
                                <form method="post" action="../control/EstadoPedido.php" class="d-flex gap-2">
                                    <input type="hidden" name="codigo" value="<?= $pedido['codigo'] ?>">
                                    <select name="nuevo_estado" class="form-select form-select-sm">
                                        <?php foreach (['Pendiente', 'Enviado', 'Entregado', 'Cancelado'] as $estado): ?>
                                            <option value="<?= $estado ?>" <?= $estado == $pedido['estado'] ? 'selected' : '' ?>>
                                                <?= $estado ?>
                                            </option>
                                        <?php endforeach; ?>
                                    </select>
                                    <button type="submit" class="btn btn-success btn-sm">Actualizar</button>
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
