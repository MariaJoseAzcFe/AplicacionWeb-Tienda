package tienda;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public final class AccesoBD {
    private static AccesoBD instanciaUnica = null;
    private Connection conexionBD = null;

    public static synchronized AccesoBD getInstance() {
        if (instanciaUnica == null) {
            instanciaUnica = new AccesoBD();
        }
        return instanciaUnica;
    }

    private AccesoBD() {
        abrirConexionBD();
    }

    public Connection obtenerConexion() {
        abrirConexionBD();
        return conexionBD;
    }

    public synchronized void abrirConexionBD() {
        if (conexionBD == null) {
            final String JDBC_DRIVER = "org.mariadb.jdbc.Driver";
            final String DB_URL = "jdbc:mariadb://mariadb:3306/tienda";
            final String USER = "root";
            final String PASS = "l1b3rt4d";
            try {
                Class.forName(JDBC_DRIVER);
                conexionBD = DriverManager.getConnection(DB_URL, USER, PASS);
            } catch (ClassNotFoundException | SQLException e) {
                System.err.println("No se ha podido conectar a la base de datos");
                e.printStackTrace();
            }
        }
    }

    public boolean comprobarAcceso() {
        abrirConexionBD();
        return conexionBD != null;
    }

    public List<ProductoBD> obtenerProductosBD() {
        abrirConexionBD();
        List<ProductoBD> productos = new ArrayList<>();

        final String query = "SELECT codigo, nombre, descripcion, precio, existencias, imagen FROM productos";

        try (PreparedStatement s = conexionBD.prepareStatement(query);
             ResultSet resultado = s.executeQuery()) {

            while (resultado.next()) {
                ProductoBD producto = new ProductoBD();
                producto.setCodigo(resultado.getInt("codigo"));
                producto.setNombre(resultado.getString("nombre"));
                producto.setDescripcion(resultado.getString("descripcion"));
                producto.setPrecio(resultado.getFloat("precio"));
                producto.setStock(resultado.getInt("existencias"));
                producto.setImagen(resultado.getString("imagen"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            System.err.println("Error ejecutando la consulta a la base de datos");
            e.printStackTrace();
        }

        return productos;
    }

    public int comprobarUsuarioBD(String usuario, String clave) {
        abrirConexionBD();

        int codigo = -1;
        final String con = "SELECT codigo FROM usuarios WHERE usuario=? AND clave=?";

        try (PreparedStatement s = conexionBD.prepareStatement(con)) {
            s.setString(1, usuario);
            s.setString(2, clave);

            try (ResultSet resultado = s.executeQuery()) {
                if (resultado.next()) {
                    codigo = resultado.getInt("codigo");
                }
            }

        } catch (SQLException e) {
            System.err.println("Error verificando usuario/clave");
            e.printStackTrace();
        }

        return codigo;
    }

    public boolean insertarUsuario(String usuario, String clave, String nombre, String apellidos, 
                               String domicilio, String poblacion, String provincia, String cp, String telefono) {
    boolean insertado = false;
    abrirConexionBD(); // Asegúrate de que esté abierta

    try {
        // Verificamos si ya existe el usuario
        int existe = comprobarUsuarioBD(usuario, clave);
        if (existe != -1) {
            return false; // Ya existe un usuario con ese nombre y clave
        }

        // Insertamos el usuario y los nuevos datos
        String sql = "INSERT INTO usuarios (usuario, clave, nombre, apellidos, domicilio, poblacion, provincia, cp, telefono) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conexionBD.prepareStatement(sql);
        stmt.setString(1, usuario);
        stmt.setString(2, clave);
        stmt.setString(3, nombre);
        stmt.setString(4, apellidos);
        stmt.setString(5, domicilio);
        stmt.setString(6, poblacion);
        stmt.setString(7, provincia);
        stmt.setString(8, cp);
        stmt.setString(9, telefono);

        int filas = stmt.executeUpdate();
        insertado = filas > 0;

        stmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return insertado;
}

    
    public boolean actualizarUsuario(int codigo, String nombre, String apellidos, String clave,
                                 String telefono, String domicilio, String cp,
                                 String provincia, String poblacion) {
    abrirConexionBD();
    boolean actualizado = false;

    if (conexionBD != null) {
        String sql = "UPDATE usuarios SET nombre=?, apellidos=?, clave=?, telefono=?, domicilio=?, "
                   + "cp=?, provincia=?, poblacion=? WHERE codigo=?";
        try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
            ps.setString(1, nombre);
            ps.setString(2, apellidos);
            ps.setString(3, clave);
            ps.setString(4, telefono);
            ps.setString(5, domicilio);
            ps.setString(6, cp);
            ps.setString(7, provincia);
            ps.setString(8, poblacion);
            ps.setInt(9, codigo);

            int filas = ps.executeUpdate();
            actualizado = filas > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar el usuario");
            e.printStackTrace();
        }
    }

    return actualizado;
}


public int obtenerExistencias(int codigoProducto) {
    int existencias = 0;

    try {
        abrirConexionBD(); 
        String sql = "SELECT existencias FROM productos WHERE codigo = ?";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ps.setInt(1, codigoProducto);

        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            existencias = rs.getInt("existencias");
        }

        rs.close();
        ps.close();


    } catch (SQLException e) {
        e.printStackTrace(); // Manejo de errores
    }

    return existencias;
}

    public UsuarioBD obtenerUsuarioJsonPorCodigo(int codigo) {
    UsuarioBD usuBD = null;
    abrirConexionBD();
    String sql = "SELECT nombre, apellidos, clave, domicilio, cp, telefono, provincia, poblacion FROM usuarios WHERE codigo = ?";
    try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
        ps.setInt(1, codigo);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                 usuBD = new UsuarioBD(
                    rs.getString("nombre"),
                    rs.getString("clave"),
                    rs.getString("domicilio"),
                    rs.getString("cp"),
                    rs.getString("telefono"),
                    rs.getString("apellidos"),
                    rs.getString("provincia"),
                    rs.getString("poblacion")
                );
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return usuBD;
}
public int insertarPedido(int codigoUsuario, float importe, int estado) {
    int codigoPedido = -1;
    abrirConexionBD();
    String sql = "INSERT INTO pedidos (persona, importe, estado) VALUES (?, ?, ?)";
    System.out.println("llegas? ");
    try (PreparedStatement ps = conexionBD.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
) {
        System.out.println("Hola? ");
        ps.setInt(1, codigoUsuario);
        ps.setFloat(2, importe);
        ps.setInt(3, estado);
        System.out.println("llegas aqui? ");
        int filas = ps.executeUpdate();
        if (filas > 0) {
            // Obtener el último id insertado en esta conexión
            System.out.println("Aqui llega, ha ejecutado ");
             try (ResultSet rs = ps.getGeneratedKeys()) {
                 System.out.println("Aqui llega, generando la key ");
                if (rs.next()) {
                    System.out.println("Aqui llega? ");
                    codigoPedido = rs.getInt(1);

                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return codigoPedido; // Devuelve el ID generado o -1 si fallo
}

    public void insertarDetallesPedido(int idPedido, ArrayList<Producto> productos) throws Exception {
        abrirConexionBD();
        String sql = "INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, unidades, precio_unitario) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
            for (Producto producto : productos) {
                int stock = obtenerExistencias(producto.getCodigo());
                int cantidadFinal = Math.min(producto.getCantidad(), stock);

                ps.setInt(1, idPedido);
                ps.setInt(2, producto.getCodigo());
                ps.setInt(3, cantidadFinal);
                ps.setFloat(4, producto.getPrecio());

                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
    public void actualizarStock(int codigoProducto, int cantidadVendida) throws SQLException {
        abrirConexionBD();

        String sql = "UPDATE productos SET existencias = existencias - ? WHERE codigo = ? AND existencias >= ?";
        try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
            ps.setInt(1, cantidadVendida);
            ps.setInt(2, codigoProducto);
            ps.setInt(3, cantidadVendida); // Asegura que haya suficiente stock

            int filas = ps.executeUpdate();
            if (filas == 0) {
                throw new SQLException("Stock insuficiente para el producto con código: " + codigoProducto);
            }
        }
    }

    public List<PedidoBD> obtenerPedidosPorUsuario(int codigoUsuario) {
    abrirConexionBD();
    List<PedidoBD> pedidos = new ArrayList<>();

    String sql = "SELECT codigo, importe, estado FROM pedidos WHERE persona = ? ORDER BY codigo DESC";
    try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
        ps.setInt(1, codigoUsuario);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                pedidos.add(new PedidoBD(
                    rs.getInt("codigo"),
                    rs.getFloat("importe"),
                    rs.getInt("estado")
                ));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return pedidos;
}
    public List<DetallesBD> obtenerDetallesPedido(int idPedido) {
    abrirConexionBD();
    List<DetallesBD> detalles = new ArrayList<>();

    String sql = "SELECT p.descripcion, dp.unidades, dp.precio_unitario FROM detalle_pedido dp " +
                 "JOIN productos p ON dp.codigo_producto = p.codigo WHERE dp.codigo_pedido = ?";
    try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
        ps.setInt(1, idPedido);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                detalles.add(new DetallesBD(
                    rs.getString("descripcion"),
                    rs.getInt("unidades"),
                    rs.getFloat("precio_unitario")
                ));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    return detalles;
}
    public void cancelarPedido(int codigoPedido) throws SQLException {
    abrirConexionBD();
    String sql = "UPDATE pedidos SET estado = 4 WHERE codigo = ? AND estado = 1";
    try (PreparedStatement ps = conexionBD.prepareStatement(sql)) {
        ps.setInt(1, codigoPedido);
        ps.executeUpdate();
    }
}
public List<EstadoBD> obtenerEstados() {
    List<EstadoBD> lista = new ArrayList<>();
    try {
        String sql = "SELECT * FROM estados";
        PreparedStatement ps = conexionBD.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int codigo = rs.getInt("codigo");
            String descripcion = rs.getString("descripcion");
            lista.add(new EstadoBD(codigo, descripcion));
        }
        rs.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return lista;
}

}
