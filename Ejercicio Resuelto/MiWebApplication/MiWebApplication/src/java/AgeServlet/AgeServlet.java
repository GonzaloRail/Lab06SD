/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AgeServlet;
import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class AgeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String birthDateStr = req.getParameter("birthDate");

        if (birthDateStr == null || birthDateStr.isEmpty()) {
            req.setAttribute("message", "Por favor ingrese una fecha válida.");
        } else {
            LocalDate birthDate = LocalDate.parse(birthDateStr);
            LocalDate today = LocalDate.now();
            int age = Period.between(birthDate, today).getYears();

            String category;
            if (age < 12) category = "Eres un niño 🧒";
            else if (age < 18) category = "Eres un adolescente 👦";
            else if (age < 60) category = "Eres un adulto 👨";
            else category = "Eres una persona mayor 👴";

            req.setAttribute("age", age);
            req.setAttribute("category", category);
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("index.jsp");
        dispatcher.forward(req, resp);
    }
}
