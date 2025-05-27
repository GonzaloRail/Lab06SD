/*
 * Servlet para manejar la autenticación de usuarios
 * Versión simplificada para evitar errores HTTP 500
 */
package compra.productos;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet para manejar la autenticación de usuarios
 * @author user
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    /**
     * Handles the HTTP GET method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    /**
     * Handles the HTTP POST method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Configurar encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");
        
        try {
            // Validar que los campos no estén vacíos
            if (usuario == null || usuario.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=" + 
                    java.net.URLEncoder.encode("El campo usuario es obligatorio", "UTF-8"));
                return;
            }
            
            if (password == null || password.trim().isEmpty()) {
                response.sendRedirect("login.jsp?error=" + 
                    java.net.URLEncoder.encode("El campo contraseña es obligatorio", "UTF-8"));
                return;
            }
            
            // Verificar credenciales
            boolean credencialesValidas = false;
            
            // Usuarios válidos
            if (("admin".equals(usuario.trim()) && "admin123".equals(password)) ||
                ("usuario".equals(usuario.trim()) && "user123".equals(password)) ||
                ("test".equals(usuario.trim()) && "test123".equals(password))) {
                credencialesValidas = true;
            }
            
            if (credencialesValidas) {
                // Login exitoso
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario.trim());
                session.setAttribute("fechaLogin", new java.util.Date().toString());
                
                // Redirigir a la página de productos
                response.sendRedirect("productos.jsp?mensaje=" + 
                    java.net.URLEncoder.encode("Bienvenido " + usuario.trim(), "UTF-8"));
                
            } else {
                // Credenciales incorrectas
                response.sendRedirect("login.jsp?error=" + 
                    java.net.URLEncoder.encode("Usuario o contraseña incorrectos", "UTF-8"));
            }
            
        } catch (Exception e) {
            // Error inesperado - log y redirección simple
            System.err.println("Error en LoginServlet: " + e.getMessage());
            e.printStackTrace();
            
            response.sendRedirect("login.jsp?error=" + 
                java.net.URLEncoder.encode("Error interno del sistema", "UTF-8"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet para autenticación de usuarios";
    }
}