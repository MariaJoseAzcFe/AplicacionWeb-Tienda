<?php

class AccesoBD
{
    private static function conectar()
    {
       $bbdd = mysqli_connect("mariadb","root","l1b3rt4d","tienda");
       if (mysqli_connect_error()) {
          printf("Error conectando a la base de datos: %s\n",mysqli_connect_error());
          exit();
       }
       return $bbdd;
    }
    
    private static function desconectar($bbdd)
    {
       mysqli_close($bbdd);
    }
    
    public static function comprobarUsuarioAdmin($login,$clave) {
        $bbdd = AccesoBD::conectar();
        $result = FALSE;
        
        if ($st = mysqli_prepare($bbdd, "SELECT * FROM usuarios WHERE usuario=? and clave=? and admin=1")) {
            mysqli_stmt_bind_param($st,"ss",$login,$clave);
            if (mysqli_stmt_execute($st)) {
                $result = mysqli_stmt_fetch($st) ? true : false;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }
        
        AccesoBD::desconectar($bbdd);
        return $result;
    }
    
    public static function obtenerListadoUsuarios() {
        $bbdd = AccesoBD::conectar();
        $usuarios= [];
        
        if ($resultado = mysqli_query($bbdd,"SELECT codigo, usuario, activo, admin FROM usuarios")) {
            while ($fila = mysqli_fetch_array($resultado)) {
                array_push($usuarios, $fila);
            }
        }
        
        AccesoBD::desconectar($bbdd);
        return $usuarios;
    } 

    public static function cambiarEstadoUsuario($codigo, $nuevo_estado) {
        $bbdd = AccesoBD::conectar();
        $result = false;

        if ($st = mysqli_prepare($bbdd, "UPDATE usuarios SET activo = ? WHERE codigo = ?")) {
            mysqli_stmt_bind_param($st, "ii", $nuevo_estado, $codigo);
            if (mysqli_stmt_execute($st)) {
                $result = mysqli_stmt_affected_rows($st) > 0;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $result;
    }

    public static function obtenerProductoPorCodigo($codigo) {
        $bbdd = AccesoBD::conectar();
        $producto = null;

        if ($st = mysqli_prepare($bbdd, "SELECT codigo, descripcion, precio, existencias, imagen FROM productos WHERE codigo = ? LIMIT 1")) {
            mysqli_stmt_bind_param($st, "i", $codigo);
            
            if (mysqli_stmt_execute($st)) {
                mysqli_stmt_bind_result($st, $codigo, $descripcion, $precio, $existencias, $imagen);
                if (mysqli_stmt_fetch($st)) {
                    $producto = [
                        'codigo' => $codigo,
                        'descripcion' => $descripcion,
                        'precio' => $precio,
                        'existencias' => $existencias,
                        'imagen' => $imagen
                    ];
                }
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $producto;
    }

    public static function insertarProducto($descripcion,$precio,$existencias,$imagen) {
        $bbdd = AccesoBD::conectar();
        $result = FALSE;
        
        if ($st = mysqli_prepare($bbdd, "INSERT INTO productos (codigo,descripcion,precio,existencias,imagen) VALUES (NULL,?,?,?,?)")) {
            mysqli_stmt_bind_param($st,"sdis",$descripcion,$precio,$existencias,$imagen);
            
            if (mysqli_stmt_execute($st)) {
                $result = $st->affected_rows > 0;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        } 
        
        AccesoBD::desconectar($bbdd);
        return $result;
    }

   public static function editarProducto($codigo, $descripcion, $precio, $existencias, $imagen) {
        $bbdd = AccesoBD::conectar();
        $result = false;

        if ($st = mysqli_prepare($bbdd, "UPDATE productos SET descripcion = ?, precio = ?, existencias = ?, imagen = ? WHERE codigo = ?")) {
            mysqli_stmt_bind_param($st, "sdisi", $descripcion, $precio, $existencias, $imagen, $codigo);
            
            if (mysqli_stmt_execute($st)) {
                $result = $st->affected_rows > 0;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $result;
    }

    public static function eliminarProducto($codigo) {
        $bbdd = AccesoBD::conectar();
        $result = false;

        if ($st = mysqli_prepare($bbdd, "DELETE FROM productos WHERE codigo = ?")) {
            mysqli_stmt_bind_param($st, "i", $codigo);
            if (mysqli_stmt_execute($st)) {
                $result = $st->affected_rows > 0;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $result;
    }

    public static function obtenerListadoProductos() {
        $bbdd = AccesoBD::conectar();
        $productos= [];
        
        if ($resultado = mysqli_query($bbdd,"SELECT codigo, descripcion, precio, existencias,imagen FROM productos")) {
            while ($fila = mysqli_fetch_array($resultado)) {
                array_push($productos, $fila);
            }
        }
        
        AccesoBD::desconectar($bbdd);
        return $productos;
    } 

    public static function actualizarEstadoPedido($idPedido, $nuevoEstado) {
        $bbdd = AccesoBD::conectar();
        $result = false;

        if ($st = mysqli_prepare($bbdd, "UPDATE pedidos SET estado = ? WHERE codigo = ?")) {
            mysqli_stmt_bind_param($st, "si", $nuevoEstado, $idPedido);
            if (mysqli_stmt_execute($st)) {
                $result = $st->affected_rows > 0;
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $result;
    }

    public static function buscarProductosPorCriterio($termino) {
        $bbdd = AccesoBD::conectar();
        $productos = [];
        
        $queryTermino = "%" . $termino . "%";
        $sql = "SELECT codigo, descripcion, precio, existencias, imagen 
                FROM productos 
                WHERE descripcion LIKE ? OR codigo LIKE ?";
                
        if ($st = mysqli_prepare($bbdd, $sql)) {
            mysqli_stmt_bind_param($st, "ss", $queryTermino, $queryTermino);
            if (mysqli_stmt_execute($st)) {
                $resultado = mysqli_stmt_get_result($st);
                while ($fila = mysqli_fetch_array($resultado)) {
                    array_push($productos, $fila);
                }
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }
        
        AccesoBD::desconectar($bbdd);
        return $productos;
    }

    public static function obtenerCodigoEstado($descripcion) {
        $bbdd = AccesoBD::conectar();
        $codigo = null;

        if ($st = mysqli_prepare($bbdd, "SELECT codigo FROM estados WHERE descripcion = ? LIMIT 1")) {
            mysqli_stmt_bind_param($st, "s", $descripcion);
            if (mysqli_stmt_execute($st)) {
                mysqli_stmt_bind_result($st, $codigo);
                if (!mysqli_stmt_fetch($st)) { $codigo = null; }
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }

        AccesoBD::desconectar($bbdd);
        return $codigo;
    }

    public static function obtenerListadoPedidos() {
        $bbdd = AccesoBD::conectar();
        $resultado = mysqli_query($bbdd, "
        SELECT p.codigo, u.nombre AS cliente, p.fecha, p.importe AS total, e.descripcion AS estado FROM pedidos p
        JOIN usuarios u ON p.persona = u.codigo JOIN estados e ON p.estado = e.codigo ORDER BY p.fecha DESC");
        
        $pedidos = [];
        while ($fila = mysqli_fetch_assoc($resultado)) {
            $pedidos[] = $fila;
        }

        AccesoBD::desconectar($bbdd);
        return $pedidos;
    }

    public static function buscarPedidosAvanzado($filtros) {
        $bbdd = AccesoBD::conectar();
        $pedidos = [];
        
        $sql = "SELECT DISTINCT p.codigo, u.nombre AS cliente, p.fecha, p.importe AS total, e.descripcion AS estado 
                FROM pedidos p
                JOIN usuarios u ON p.persona = u.codigo 
                JOIN estados e ON p.estado = e.codigo 
                LEFT JOIN detalle_pedido dp ON p.codigo = dp.codigo_pedido  
                LEFT JOIN productos prod ON dp.codigo_producto = prod.codigo 
                WHERE 1=1";
                
        $tipos = "";
        $parametros = [];

        if (!empty($filtros['usuario'])) {
            $sql .= " AND u.nombre LIKE ?";
            $tipos .= "s";
            $parametros[] = "%" . $filtros['usuario'] . "%";
        }

        if (!empty($filtros['producto'])) {
            $sql .= " AND prod.descripcion LIKE ?";
            $tipos .= "s";
            $parametros[] = "%" . $filtros['producto'] . "%";
        }

        if (!empty($filtros['fecha'])) {
            $op = in_array($filtros['fecha_op'], ['<=', '=', '>=']) ? $filtros['fecha_op'] : '=';
            $sql .= " AND DATE(p.fecha) $op ?";
            $tipos .= "s";
            $parametros[] = $filtros['fecha'];
        }

        $sql .= " ORDER BY p.fecha DESC";

        if ($st = mysqli_prepare($bbdd, $sql)) {
            if (!empty($parametros)) {
                mysqli_stmt_bind_param($st, $tipos, ...$parametros);
            }
            
            if (mysqli_stmt_execute($st)) {
                $resultado = mysqli_stmt_get_result($st);
                while ($fila = mysqli_fetch_assoc($resultado)) {
                    $pedidos[] = $fila;
                }
            }
            if (!mysqli_stmt_close($st)) { error_log("Error al cerrar stmt"); }
        }
        
        AccesoBD::desconectar($bbdd);
        return $pedidos;
    }
}
?>