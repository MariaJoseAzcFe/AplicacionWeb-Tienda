package tienda;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class PedidosServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("codigo") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int codigoUsuario = (Integer) session.getAttribute("codigo");
        String accion = request.getParameter("accion");

        AccesoBD accesoBD = AccesoBD.getInstance();

        // Obtener pedidos
        List<PedidoBD> pedidos = accesoBD.obtenerPedidosPorUsuario(codigoUsuario);
        request.setAttribute("pedidos", pedidos);

        // Si viene de "Ver Detalles"
        if ("verDetalles".equals(accion)) {
            int idPedido = Integer.parseInt(request.getParameter("idPedido"));
            List<DetallesBD> detalles = accesoBD.obtenerDetallesPedido(idPedido);
            request.setAttribute("detalles", detalles);
        }

        // Cargar estados (necesarios para mostrar texto en JSP)
        List<EstadoBD> estados = accesoBD.obtenerEstados();
        request.setAttribute("estados", estados);

        // Enviar a la vista
        request.getRequestDispatcher("usuario.jsp").forward(request, response);
    }
   
}
