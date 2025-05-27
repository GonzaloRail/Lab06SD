<%-- 
    Document   : validar_login
    Created on : May 26, 2025
    Author     : user
    Description: Validación de login (equivalente a resultado.jsp)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Resultado de Login - Sistema de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid #c3e6cb;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
            background: #007bff;
            color: white;
        }
        .btn:hover {
            background: #0056b3;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
        .login-info {
            background-color: #e2e3e5;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            border: 1px solid #d6d8db;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔐 Resultado del Login</h1>
        </div>

        <%
            try {
                // Obtener parámetros del formulario de manera segura
                String usuario = request.getParameter("usuario");
                String password = request.getParameter("password");
                
                boolean hayError = false;
                String mensajeError = "";
                
                // Validaciones en JSP (como en resultado.jsp)
                
                // Validación 1: Campo usuario vacío
                if (usuario == null || usuario.trim().isEmpty()) {
                    hayError = true;
                    mensajeError = "El campo usuario es obligatorio. Por favor, ingrese su nombre de usuario.";
                }
                // Validación 2: Campo contraseña vacío
                else if (password == null || password.trim().isEmpty()) {
                    hayError = true;
                    mensajeError = "El campo contraseña es obligatorio. Por favor, ingrese su contraseña.";
                }
                // Validación 3: Verificar credenciales
                else {
                    boolean credencialesValidas = false;
                    
                    // Usuarios válidos (mismo que LoginServlet)
                    if (("admin".equals(usuario.trim()) && "admin123".equals(password)) ||
                        ("usuario".equals(usuario.trim()) && "user123".equals(password)) ||
                        ("test".equals(usuario.trim()) && "test123".equals(password))) {
                        credencialesValidas = true;
                    }
                    
                    if (!credencialesValidas) {
                        hayError = true;
                        mensajeError = "Usuario o contraseña incorrectos. Verifique sus datos e intente nuevamente.";
                    }
                }
                
                if (hayError) {
        %>
                    <div class="error-message">
                        <strong>❌ Error de autenticación:</strong><br>
                        <%= mensajeError %>
                    </div>
                    
                    <div class="login-info">
                        <strong>Datos recibidos:</strong><br>
                        Usuario: "<%= usuario != null ? usuario : "(vacío)" %>"<br>
                        Contraseña: <%= password != null && !password.isEmpty() ? "****** (ingresada)" : "(vacía)" %>
                    </div>
                    
                    <div class="actions">
                        <a href="login.jsp" class="btn">🔙 Volver al Login</a>
                    </div>
        <%
                } else {
                    // Login exitoso - crear sesión y redirigir
                    HttpSession sesion = request.getSession();
                    sesion.setAttribute("usuario", usuario.trim());
                    sesion.setAttribute("fechaLogin", new java.util.Date().toString());
        %>
                    <div class="success-message">
                        <strong>✅ Login exitoso</strong><br>
                        Bienvenido al sistema, <%= usuario.trim() %>
                    </div>
                    
                    <div class="login-info">
                        <strong>Información de la sesión:</strong><br>
                        Usuario: <%= usuario.trim() %><br>
                        Fecha de acceso: <%= new java.util.Date() %><br>
                        ID de sesión: <%= session.getId() %>
                    </div>
                    
                    <div class="actions">
                        <a href="productos.jsp" class="btn">🛒 Ir a Productos</a>
                        <a href="login.jsp" class="btn">🏠 Volver al Login</a>
                    </div>
                    
                    <script>
                        // Redirigir automáticamente después de 3 segundos
                        setTimeout(function() {
                            window.location.href = 'productos.jsp?mensaje=Bienvenido ' + encodeURIComponent('<%= usuario.trim() %>');
                        }, 3000);
                    </script>
        <%
                }
                
            } catch (Exception e) {
                // Manejar cualquier excepción inesperada
        %>
                <div class="error-message">
                    <strong>❌ Error interno del sistema:</strong><br>
                    Se ha producido un error inesperado durante el proceso de autenticación.<br>
                    <small>Detalles técnicos: <%= e.getMessage() %></small>
                </div>
                
                <div class="actions">
                    <a href="login.jsp" class="btn">🔙 Volver al Login</a>
                </div>
        <%
                // Log del error para debugging
                System.err.println("Error en validar_login.jsp: " + e.getMessage());
                e.printStackTrace();
            }
        %>
        
        <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #dee2e6; color: #6c757d; font-size: 12px;">
            <p><strong>Usuarios válidos para pruebas:</strong></p>
            <p>admin / admin123 | usuario / user123 | test / test123</p>
        </div>
    </div>
</body>
</html>