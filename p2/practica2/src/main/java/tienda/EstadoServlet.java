package tienda;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class EstadoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("codigo") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
       
        String accion = request.getParameter("accion");

        if ("cancelar".equals(accion)) {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            AccesoBD accesoBD = AccesoBD.getInstance();
            try {
                accesoBD.cancelarPedido(idPedido);
                 int codigoUsuario = (Integer) session.getAttribute("codigo");
                List<PedidoBD> pedidos = accesoBD.obtenerPedidosPorUsuario(codigoUsuario);// Volver a cargar pedidos y estados
                List<EstadoBD> estados = accesoBD.obtenerEstados();
                request.setAttribute("pedidos", pedidos);
                request.setAttribute("estados", estados);
            } catch (SQLException e) {
                e.printStackTrace(); 
            }
        }
       
         request.getRequestDispatcher("usuario.jsp").forward(request, response);
        
    }
}
