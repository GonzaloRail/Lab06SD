<%-- 
    Document   : index
    Created on : 26 may. 2025, 11:40:34 p. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Calculadora de Edad</title>
    <style>
        body {
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            font-family: 'Segoe UI', sans-serif;
            text-align: center;
            padding-top: 100px;
        }
        .card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            width: 300px;
            margin: auto;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            transition: transform 0.3s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        input[type="date"], button {
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin: 10px 0;
            width: 100%;
        }
        button {
            background-color: #667eea;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        h1 {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>¿Cuántos años tienes?</h1>
        <form action="AgeServlet" method="post">
            <input type="date" name="birthDate" required />
            <button type="submit">Calcular Edad</button>
        </form>
        <%
            Integer age = (Integer) request.getAttribute("age");
            String category = (String) request.getAttribute("category");
            String message = (String) request.getAttribute("message");

            if (age != null) {
        %>
            <p>Tienes <strong><%= age %></strong> años.</p>
            <p><%= category %></p>
        <% } else if (message != null) { %>
            <p><%= message %></p>
        <% } %>
    </div>
</body>
</html>
