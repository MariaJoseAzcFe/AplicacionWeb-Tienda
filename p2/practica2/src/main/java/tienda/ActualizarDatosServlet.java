package tienda;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class ActualizarDatosServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        // Obtener datos del formulario
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String clave = request.getParameter("clave");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String codigoPostal = request.getParameter("codigoPostal");
        String provincia = request.getParameter("provincia");
        String poblacion = request.getParameter("poblacion");
        String formaPago = request.getParameter("formaPago");

        // Obtener el ID del usuario desde sesión
        Integer codigoUsuario = (Integer) sesion.getAttribute("codigo");

        if (codigoUsuario != null) {
            // Actualizar los datos en la base de datos
            AccesoBD acceso = AccesoBD.getInstance();
            boolean actualizado = acceso.actualizarUsuario(
                codigoUsuario, nombre, apellidos, clave, telefono, direccion, codigoPostal, provincia, poblacion);

            if (actualizado) {
                // Actualizar el objeto UsuarioJson en la sesión
                UsuarioBD usuarioJson = new UsuarioBD(
                    nombre, clave, direccion, codigoPostal, telefono, apellidos, provincia, poblacion);
                sesion.setAttribute("usuarioBD", usuarioJson);
                sesion.setAttribute("formatopago", formaPago);
            } else {
                sesion.setAttribute("mensaje", "No se pudieron actualizar los datos.");
            }

            // Redirigir a la página del perfil
            response.sendRedirect("usuario.jsp");
        } else {
            response.sendRedirect("loginUsuario.jsp");
        }
    }
}