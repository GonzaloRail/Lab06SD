<%-- 
    Document   : login
    Created on : May 26, 2025
    Author     : user
    Description: Página de login del sistema - SIN VALIDACIONES
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login - Sistema de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            color: #333;
            margin: 0;
            font-size: 28px;
        }
        .login-header p {
            color: #666;
            margin: 10px 0 0 0;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e1e1;
            border-radius: 5px;
            font-size: 16px;
            transition: border-color 0.3s;
            box-sizing: border-box;
        }
        .form-group input:focus {
            outline: none;
            border-color: #667eea;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        .info-message {
            background-color: #d1ecf1;
            color: #0c5460;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #bee5eb;
        }
        .links {
            text-align: center;
            margin-top: 20px;
        }
        .links a {
            color: #667eea;
            text-decoration: none;
            margin: 0 10px;
        }
        .links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>🛒 Sistema de Compras</h1>
            <p>Ingrese sus credenciales para continuar</p>
        </div>

        <%
            String mensaje = request.getParameter("mensaje");
            String error = request.getParameter("error");
            
            if (error != null) {
        %>
            <div class="error-message">
                <%= error %>
            </div>
        <%
            }
            
            if (mensaje != null) {
        %>
            <div class="info-message">
                <%= mensaje %>
            </div>
        <%
            }
        %>

        <!-- FORMULARIO SIN VALIDACIONES - Permite enviar campos vacíos -->
        <form action="validar_login.jsp" method="post">
            <div class="form-group">
                <label for="usuario">Usuario:</label>
                <!-- SIN required - permite enviar vacío -->
                <input type="text" id="usuario" name="usuario" 
                       placeholder="Ingrese su usuario" 
                       value="<%= request.getParameter("usuario") != null ? request.getParameter("usuario") : "" %>">
            </div>
            
            <div class="form-group">
                <label for="password">Contraseña:</label>
                <!-- SIN required - permite enviar vacío -->
                <input type="password" id="password" name="password" 
                       placeholder="Ingrese su contraseña">
            </div>
            
            <!-- Botón envía SIEMPRE sin validaciones -->
            <button type="submit" class="btn">Iniciar Sesión</button>
        </form>

        <div class="links">
            <a href="productos.jsp">Ir directamente a productos</a>
        </div>

        <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; color: #666; font-size: 12px;">
            <p><strong>Usuarios de prueba:</strong></p>
            <p>admin / admin123</p>
            <p>usuario / user123</p>
            <p><em>Puede enviar campos vacíos para probar errores</em></p>
        </div>
    </div>
</body>
</html>