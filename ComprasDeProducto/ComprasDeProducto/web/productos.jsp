<%-- 
    Document   : productos
    Created on : May 26, 2025
    Author     : user
    Description: Página para comprar productos
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Compra de Productos - Sistema de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e9ecef;
        }
        .header h1 {
            color: #333;
            margin: 0;
        }
        .user-info {
            background-color: #d1ecf1;
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #bee5eb;
        }
        .productos-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .producto-card {
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .producto-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .producto-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }
        .producto-nombre {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .producto-precio {
            font-size: 16px;
            color: #28a745;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 2px solid #e1e1e1;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group input:focus {
            outline: none;
            border-color: #007bff;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s;
            text-decoration: none;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
        }
        .form-actions {
            text-align: center;
            margin-top: 30px;
        }
        .mensaje {
            padding: 10px 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .mensaje-exito {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .mensaje-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .logout {
            float: right;
            margin-top: -10px;
        }
    </style>
    <script>
        function validarFormulario() {
            var cantidades = document.querySelectorAll('input[type="number"]');
            var errores = [];
            
            for (var i = 0; i < cantidades.length; i++) {
                var valor = parseInt(cantidades[i].value);
                if (valor < 0) {
                    errores.push("No se permiten cantidades negativas en " + cantidades[i].name.replace("Cantidad", ""));
                }
            }
            
            if (errores.length > 0) {
                // Crear URL con parámetros de error
                var url = "error.jsp?";
                for (var j = 0; j < errores.length; j++) {
                    url += "mensajes=" + encodeURIComponent(errores[j]);
                    if (j < errores.length - 1) url += "&";
                }
                window.location.href = url;
                return false;
            }
            
            return true;
        }
        
        function calcularTotal() {
            var total = 0;
            var cantPan = parseInt(document.getElementById('cantidadPan').value) || 0;
            var cantQueso = parseInt(document.getElementById('cantidadQueso').value) || 0;
            var cantPlatanos = parseInt(document.getElementById('cantidadPlatanos').value) || 0;
            var cantNaranjas = parseInt(document.getElementById('cantidadNaranjas').value) || 0;
            
            total += cantPan * 0.50;
            total += cantQueso * 2.50;
            total += cantPlatanos * 0.40;
            total += cantNaranjas * 0.60;
            
            document.getElementById('totalEstimado').innerHTML = 'Total estimado: S/. ' + total.toFixed(2);
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🛒 Sistema de Compras de Productos</h1>
            <%
                String usuario = (String) session.getAttribute("usuario");
                if (usuario != null) {
            %>
                <div class="logout">
                    <a href="login.jsp?mensaje=Sesión cerrada correctamente" class="btn btn-secondary">Cerrar Sesión</a>
                </div>
                <div class="user-info">
                    👤 Bienvenido: <strong><%= usuario %></strong> | 
                    🕐 Fecha: <%= new java.util.Date() %>
                </div>
            <%
                }
                
                String mensaje = request.getParameter("mensaje");
                if (mensaje != null) {
            %>
                <div class="mensaje mensaje-exito">
                    <%= mensaje %>
                </div>
            <%
                }
            %>
        </div>

        <form action="resultado.jsp" method="post" onsubmit="return validarFormulario()">
            <div class="productos-grid">
                <div class="producto-card">
                    <div class="producto-icon">🍞</div>
                    <div class="producto-nombre">Pan</div>
                    <div class="producto-precio">S/. 0.50 por unidad</div>
                    <div class="form-group">
                        <label for="cantidadPan">Cantidad:</label>
                        <input type="number" id="cantidadPan" name="CantidadPan" 
                               min="0" value="0" onchange="calcularTotal()">
                    </div>
                </div>

                <div class="producto-card">
                    <div class="producto-icon">🧀</div>
                    <div class="producto-nombre">Queso</div>
                    <div class="producto-precio">S/. 2.50 por unidad</div>
                    <div class="form-group">
                        <label for="cantidadQueso">Cantidad:</label>
                        <input type="number" id="cantidadQueso" name="CantidadQueso" 
                               min="0" value="0" onchange="calcularTotal()">
                    </div>
                </div>

                <div class="producto-card">
                    <div class="producto-icon">🍌</div>
                    <div class="producto-nombre">Plátanos</div>
                    <div class="producto-precio">S/. 0.40 por unidad</div>
                    <div class="form-group">
                        <label for="cantidadPlatanos">Cantidad:</label>
                        <input type="number" id="cantidadPlatanos" name="CantidadPlatanos" 
                               min="0" value="0" onchange="calcularTotal()">
                    </div>
                </div>

                <div class="producto-card">
                    <div class="producto-icon">🍊</div>
                    <div class="producto-nombre">Naranjas</div>
                    <div class="producto-precio">S/. 0.60 por unidad</div>
                    <div class="form-group">
                        <label for="cantidadNaranjas">Cantidad:</label>
                        <input type="number" id="cantidadNaranjas" name="CantidadNaranjas" 
                               value="0" onchange="calcularTotal()">
                    </div>
                </div>
            </div>

            <div style="text-align: center; margin: 20px 0; padding: 15px; background-color: #f8f9fa; border-radius: 5px;">
                <h3 id="totalEstimado" style="color: #28a745; margin: 0;">Total estimado: S/. 0.00</h3>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn">🛍️ Procesar Compra</button>
                <a href="login.jsp" class="btn btn-secondary">🏠 Volver al Login</a>
            </div>
        </form>
    </div>
</body>
</html>