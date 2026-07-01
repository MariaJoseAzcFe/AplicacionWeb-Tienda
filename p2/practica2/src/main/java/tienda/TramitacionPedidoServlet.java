package tienda;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class TramitacionPedidoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        AccesoBD con = AccesoBD.getInstance();
        
        // Obtener los datos de la sesión
        
        Integer codigoObj = (Integer) session.getAttribute("codigo");
        if (codigoObj == null) {
            response.sendRedirect("loginCompra.jsp"); 
            return;
        }
        int codigo = codigoObj;
        ArrayList<Producto> carritoJSON = (ArrayList<Producto>) session.getAttribute("carritoJSON");

        if (carritoJSON == null || carritoJSON.isEmpty()) {
            
            response.sendRedirect("productos.jsp");
            return;
        }

        // Usar la conexión que ya tienes en AccesoBD
        Connection conexionBD = con.obtenerConexion();

        try {
            conexionBD.setAutoCommit(false);
            float importetotal = 0f;
            for(Producto producto : carritoJSON) //Para el importe total
            {
                importetotal += producto.getPrecio() * producto.getCantidad();
            }
           
            
            
        // Insertar pedido usando método de AccesoBD
        int idPedido = con.insertarPedido(codigo, importetotal, 1); // 1 = estado pendiente
        System.out.println("Pedido insertado con ID: " + idPedido);

        if (idPedido == -1) {
            conexionBD.rollback();
            response.sendRedirect("index.jsp");
            return;
        }

        // Insertar detalles usando método de AccesoBD
        con.insertarDetallesPedido(idPedido, carritoJSON);

        for (Producto producto : carritoJSON) {
            con.actualizarStock(producto.getCodigo(), producto.getCantidad());
        }


        conexionBD.commit();


        request.setAttribute("idPedido", idPedido);
        request.getRequestDispatcher("resumen.jsp").forward(request, response);


        } catch (Exception e) {
            System.out.println("Error en el bloque try del servlet: " + e.getMessage());
            e.printStackTrace(); 
            try {
                conexionBD.rollback();
            } catch (Exception rollbackException) {
                rollbackException.printStackTrace();
            }
            // Redirigir al usuario a una página de error
            response.sendRedirect("index.jsp");
        } finally {
            try {
                conexionBD.setAutoCommit(true); // Restaurar auto-commit
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
