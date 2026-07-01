package tienda;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Nombre del usuario
        String usuario = request.getParameter("usuario");
    
        // Clave
        String clave = request.getParameter("clave");
    
        // URL a la que debemos volver
    
        String url = request.getParameter("url");
    
        // Accedemos al entorno de sesión y si no está creado lo creamos
    
        HttpSession session = request.getSession(true);
    
        AccesoBD con = AccesoBD.getInstance();
    
        if ((usuario != null) && (clave != null)) {
            int codigo = con.comprobarUsuarioBD(usuario,clave);
            if (codigo>0) {
                session.setAttribute("codigo",codigo);
                session.setAttribute("usuario",usuario);
                UsuarioBD usuarioJson = con.obtenerUsuarioJsonPorCodigo(codigo);
                session.setAttribute("usuarioBD", usuarioJson);
            }
            else {
                session.setAttribute("mensaje","Usuario y/o clave incorrectos");
            }
        }
    
        request.getRequestDispatcher(url).forward(request, response);
    
    }
   
}