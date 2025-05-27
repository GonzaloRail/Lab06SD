<%-- 
    Document   : resultado (versión simplificada)
    Created on : May 26, 2025
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Resultado de Compra - Sistema de Compras</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
            color: #28a745;
        }
        .factura {
            background-color: #f8f9fa;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        .item-row {
            padding: 10px 0;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
        }
        .total-row {
            padding: 15px 0;
            margin-top: 15px;
            border-top: 2px solid #28a745;
            font-size: 18px;
            font-weight: bold;
            color: #28a745;
            display: flex;
            justify-content: space-between;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🧾 Resultado de su Compra</h1>
        </div>

        <%
            // Obtener parámetros del formulario de manera segura
            String cantidadPanStr = request.getParameter("CantidadPan");
            String cantidadQuesoStr = request.getParameter("CantidadQueso");
            String cantidadPlatanoStr = request.getParameter("CantidadPlatanos");
            String cantidadNaranjasStr = request.getParameter("CantidadNaranjas");
            
            boolean hayError = false;
            String mensajeError = "";
            
            // Variables para los cálculos
            int cantidadPan = 0, cantidadQueso = 0, cantidadPlatanos = 0, cantidadNaranjas = 0;
            double precioUnitarioPan = 0.50;
            double precioUnitarioQueso = 2.50;
            double precioUnitarioPlatanos = 0.40;
            double precioUnitarioNaranjas = 0.60;
            
            try {
                // Convertir las cantidades de manera segura
                if (cantidadPanStr != null && !cantidadPanStr.trim().isEmpty()) {
                    cantidadPan = Integer.parseInt(cantidadPanStr.trim());
                }
                if (cantidadQuesoStr != null && !cantidadQuesoStr.trim().isEmpty()) {
                    cantidadQueso = Integer.parseInt(cantidadQuesoStr.trim());
                }
                if (cantidadPlatanoStr != null && !cantidadPlatanoStr.trim().isEmpty()) {
                    cantidadPlatanos = Integer.parseInt(cantidadPlatanoStr.trim());
                }
                if (cantidadNaranjasStr != null && !cantidadNaranjasStr.trim().isEmpty()) {
                    cantidadNaranjas = Integer.parseInt(cantidadNaranjasStr.trim());
                }
                
                // Validaciones básicas
                if (cantidadPan < 0 || cantidadQueso < 0 || cantidadPlatanos < 0 || cantidadNaranjas < 0) {
                    hayError = true;
                    mensajeError = "Las cantidades no pueden ser negativas. Lo siento, ingrese una cantidad positiva.";
                } else if (cantidadPan == 0 && cantidadQueso == 0 && cantidadPlatanos == 0 && cantidadNaranjas == 0) {
                    hayError = true;
                    mensajeError = "Debe seleccionar al menos un producto para comprar.";
                }
                
            } catch (NumberFormatException e) {
                hayError = true;
                mensajeError = "Error en el formato de las cantidades. Por favor ingrese números válidos.";
            } catch (Exception e) {
                hayError = true;
                mensajeError = "Error inesperado: " + e.getMessage();
            }
            
            if (hayError) {
        %>
                <div class="error-message">
                    <strong>❌ Error:</strong><br>
                    <%= mensajeError %>
                </div>
                
                <div class="actions">
                    <a href="productos.jsp" class="btn">🔙 Volver a Productos</a>
                </div>
        <%
            } else {
                // Procesar la compra exitosamente
                double subtotalPan = cantidadPan * precioUnitarioPan;
                double subtotalQueso = cantidadQueso * precioUnitarioQueso;
                double subtotalPlatanos = cantidadPlatanos * precioUnitarioPlatanos;
                double subtotalNaranjas = cantidadNaranjas * precioUnitarioNaranjas;
                double total = subtotalPan + subtotalQueso + subtotalPlatanos + subtotalNaranjas;
        %>
                <div class="success-message">
                    <strong>✅ Compra procesada exitosamente</strong><br>
                    Su pedido ha sido registrado correctamente.
                </div>
                
                <div class="factura">
                    <h3 style="text-align: center; margin-bottom: 20px;">🧾 FACTURA DE COMPRA</h3>
                    
                    <% if (cantidadPan > 0) { %>
                        <div class="item-row">
                            <span>🍞 Pan: <%= cantidadPan %> unidades x S/. <%= String.format("%.2f", precioUnitarioPan) %></span>
                            <span>S/. <%= String.format("%.2f", subtotalPan) %></span>
                        </div>
                    <% } %>
                    
                    <% if (cantidadQueso > 0) { %>
                        <div class="item-row">
                            <span>🧀 Queso: <%= cantidadQueso %> unidades x S/. <%= String.format("%.2f", precioUnitarioQueso) %></span>
                            <span>S/. <%= String.format("%.2f", subtotalQueso) %></span>
                        </div>
                    <% } %>
                    
                    <% if (cantidadPlatanos > 0) { %>
                        <div class="item-row">
                            <span>🍌 Plátanos: <%= cantidadPlatanos %> unidades x S/. <%= String.format("%.2f", precioUnitarioPlatanos) %></span>
                            <span>S/. <%= String.format("%.2f", subtotalPlatanos) %></span>
                        </div>
                    <% } %>
                    
                    <% if (cantidadNaranjas > 0) { %>
                        <div class="item-row">
                            <span>🍊 Naranjas: <%= cantidadNaranjas %> unidades x S/. <%= String.format("%.2f", precioUnitarioNaranjas) %></span>
                            <span>S/. <%= String.format("%.2f", subtotalNaranjas) %></span>
                        </div>
                    <% } %>
                    
                    <div class="total-row">
                        <span>💰 TOTAL A PAGAR:</span>
                        <span>S/. <%= String.format("%.2f", total) %></span>
                    </div>
                </div>
                
                <div class="actions">
                    <a href="productos.jsp" class="btn">🛒 Nueva Compra</a>
                    <a href="login.jsp" class="btn">🏠 Volver al Inicio</a>
                </div>
        <%
            }
        %>
        
        <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #dee2e6; color: #6c757d; font-size: 12px;">
            <p><strong>Sistema de Compras de Productos</strong></p>
            <p>Universidad Nacional de San Agustín</p>
        </div>
    </div>
</body>
</html>