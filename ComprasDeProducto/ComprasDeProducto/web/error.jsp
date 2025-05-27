<%-- 
    Document   : error
    Created on : May 26, 2025
    Author     : user
    Description: Página de gestión de errores del sistema
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Error - Sistema de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .error-container {
            max-width: 600px;
            margin: 0 auto;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .error-header {
            color: #dc3545;
            text-align: center;
            margin-bottom: 20px;
        }
        .error-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }
        .error-title {
            font-size: 24px;
            margin: 0;
        }
        .error-subtitle {
            color: #6c757d;
            margin: 5px 0 0 0;
        }
        .error-messages {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            padding: 15px;
            margin: 20px 0;
        }
        .error-message {
            margin: 5px 0;
            color: #721c24;
        }
        .error-details {
            background-color: #e2e3e5;
            border: 1px solid #d6d8db;
            border-radius: 4px;
            padding: 15px;
            margin: 20px 0;
            font-family: monospace;
            font-size: 12px;
            color: #495057;
        }
        .actions {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-header">
            <div class="error-icon">⚠️</div>
            <h1 class="error-title">¡Oops! Ha ocurrido un error</h1>
            <p class="error-subtitle">Lo sentimos, algo salió mal con tu solicitud</p>
        </div>

        <%
            // Obtener mensajes de error personalizados desde los parámetros
            List<String> mensajesError = new ArrayList<>();
            
            // Verificar si hay mensajes en los parámetros de la request
            String[] mensajesParam = request.getParameterValues("mensajes");
            if (mensajesParam != null) {
                for (String mensaje : mensajesParam) {
                    mensajesError.add(mensaje);
                }
            }
            
            // Verificar si hay mensajes en los atributos de la request
            @SuppressWarnings("unchecked")
            List<String> mensajesAttr = (List<String>) request.getAttribute("mensajesError");
            if (mensajesAttr != null) {
                mensajesError.addAll(mensajesAttr);
            }
            
            // Si no hay mensajes específicos, crear uno por defecto
            if (mensajesError.isEmpty()) {
                if (exception != null) {
                    mensajesError.add("Se ha producido un error inesperado en el sistema.");
                } else {
                    mensajesError.add("Ha ocurrido un error en el procesamiento de su solicitud.");
                }
            }
        %>

        <div class="error-messages">
            <strong>Mensajes de error:</strong>
            <% for (String mensaje : mensajesError) { %>
                <div class="error-message">• <%= mensaje %></div>
            <% } %>
        </div>

        <% if (exception != null) { %>
            <div class="error-details">
                <strong>Detalles técnicos:</strong><br>
                <strong>Tipo de excepción:</strong> <%= exception.getClass().getSimpleName() %><br>
                <strong>Mensaje:</strong> <%= exception.getMessage() != null ? exception.getMessage() : "No disponible" %><br>
                <strong>Timestamp:</strong> <%= new java.util.Date() %>
                
                <% if (request.getParameter("debug") != null) { %>
                    <br><br><strong>Stack Trace:</strong><br>
                    <%
                        java.io.StringWriter sw = new java.io.StringWriter();
                        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
                        exception.printStackTrace(pw);
                        String stackTrace = sw.toString();
                    %>
                    <pre style="white-space: pre-wrap; word-wrap: break-word;"><%= stackTrace %></pre>
                <% } %>
            </div>
        <% } %>

        <div class="actions">
            <a href="javascript:history.back()" class="btn btn-secondary">⬅️ Volver Atrás</a>
            <a href="login.jsp" class="btn btn-primary">🏠 Ir al Inicio</a>
            <a href="productos.jsp" class="btn btn-primary">🛒 Ir a Productos</a>
        </div>

        <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #dee2e6; color: #6c757d; font-size: 12px;">
            <p>Si el problema persiste, contacte al administrador del sistema.</p>
            <p>Sistema de Compras de Productos - Universidad Nacional de San Agustín</p>
        </div>
    </div>
</body>
</html>