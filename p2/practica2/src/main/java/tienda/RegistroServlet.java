package tienda;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegistroServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recuperamos los parámetros del formulario
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String domicilio = request.getParameter("domicilio");
        String poblacion = request.getParameter("poblacion");
        String provincia = request.getParameter("provincia");
        String cp = request.getParameter("cp");
        String telefono = request.getParameter("telefono");

        // Accedemos a la base de datos
        AccesoBD con = AccesoBD.getInstance();
        HttpSession session = request.getSession();

        // Comprobamos si el usuario ya existe
        int resultado = con.comprobarUsuarioBD(usuario, clave);

        if (resultado == -1) {
            // El usuario no existe, lo insertamos en la base de datos
            boolean exito = con.insertarUsuario(usuario, clave, nombre, apellidos, domicilio, poblacion, provincia, cp, telefono);

            if (exito) {
                // Si el registro fue exitoso, redirigimos a la página de inicio de sesión
                request.setAttribute("mensaje", "Registro exitoso. Inicie sesión.");
                request.getRequestDispatcher("loginUsuario.jsp").forward(request, response);
            } else {
                // Si hubo un error en el registro, mostramos un mensaje de error
                session.setAttribute("mensajeRegistro", "Error al registrar el usuario. Inténtelo de nuevo.");
                response.sendRedirect("registro.jsp");
            }
        } else if (resultado == -2) {
            // El usuario existe con otra clave
            session.setAttribute("mensajeRegistro", "El nombre de usuario ya existe con otra contraseña.");
            response.sendRedirect("registro.jsp");
        } else {
            // El usuario ya existe con la misma clave
            session.setAttribute("mensajeRegistro", "El usuario ya está registrado. Inicie sesión.");
            response.sendRedirect("registro.jsp");
        }
    }
}
