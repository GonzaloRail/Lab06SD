/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/WebServices/WebService.java to edit this template
 */
package compra.productos;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;

/**
 * Web Service para el manejo de compras de productos
 * Incluye validaciones y manejo mejorado de errores
 * @author user
 */
@WebService(serviceName = "compraproductos")
public class compraproductos {

    // Precios de los productos
    private static final double PRECIO_PAN = 0.50;
    private static final double PRECIO_QUESO = 2.50;
    private static final double PRECIO_PLATANOS = 0.40;
    private static final double PRECIO_NARANJAS = 0.60;

    /**
     * Web service operation para procesar compras de productos
     * Incluye validaciones mejoradas y manejo de errores
     */
    @WebMethod(operationName = "comprasProductos")
    public String comprasProductos(
        @WebParam(name = "CantidadPan") int CantidadPan,
        @WebParam(name = "CantidadQueso") int CantidadQueso,
        @WebParam(name = "CantidadPlatanos") int CantidadPlatanos,
        @WebParam(name = "CantidadNaranjas") int CantidadNaranjas) {
        
        StringBuilder mensaje = new StringBuilder();
        double total = 0;
        boolean hayError = false;

        try {
            // Validaciones de entrada
            if (CantidadPan < 0 || CantidadQueso < 0 || CantidadPlatanos < 0 || CantidadNaranjas < 0) {
                mensaje.append("ERROR: Las cantidades no pueden ser negativas.\n");
                mensaje.append("Lo siento, ingrese una cantidad positiva.\n");
                return mensaje.toString();
            }
            
            // Verificar que al menos se haya pedido un producto
            if (CantidadPan == 0 && CantidadQueso == 0 && CantidadPlatanos == 0 && CantidadNaranjas == 0) {
                mensaje.append("ERROR: Debe seleccionar al menos un producto.\n");
                mensaje.append("Por favor, ingrese cantidades mayores a 0 para al menos un producto.\n");
                return mensaje.toString();
            }
            
            // Validar límites máximos (para evitar pedidos excesivos)
            if (CantidadPan > 1000 || CantidadQueso > 1000 || CantidadPlatanos > 1000 || CantidadNaranjas > 1000) {
                mensaje.append("ERROR: Las cantidades no pueden exceder 1000 unidades por producto.\n");
                mensaje.append("Por favor, ajuste sus cantidades.\n");
                return mensaje.toString();
            }

            // Procesar la compra
            mensaje.append("=== FACTURA DE COMPRA ===\n");
            mensaje.append("Fecha: ").append(new java.util.Date()).append("\n");
            mensaje.append("=====================================\n\n");

            // Calcular y mostrar cada producto si la cantidad es mayor a 0
            if (CantidadPan > 0) {
                double subtotalPan = CantidadPan * PRECIO_PAN;
                total += subtotalPan;
                mensaje.append("🍞 Pan: ").append(CantidadPan).append(" unidades x S/. ")
                       .append(String.format("%.2f", PRECIO_PAN))
                       .append(" = S/. ").append(String.format("%.2f", subtotalPan)).append("\n");
            }

            if (CantidadQueso > 0) {
                double subtotalQueso = CantidadQueso * PRECIO_QUESO;
                total += subtotalQueso;
                mensaje.append("🧀 Queso: ").append(CantidadQueso).append(" unidades x S/. ")
                       .append(String.format("%.2f", PRECIO_QUESO))
                       .append(" = S/. ").append(String.format("%.2f", subtotalQueso)).append("\n");
            }

            if (CantidadPlatanos > 0) {
                double subtotalPlatanos = CantidadPlatanos * PRECIO_PLATANOS;
                total += subtotalPlatanos;
                mensaje.append("🍌 Plátanos: ").append(CantidadPlatanos).append(" unidades x S/. ")
                       .append(String.format("%.2f", PRECIO_PLATANOS))
                       .append(" = S/. ").append(String.format("%.2f", subtotalPlatanos)).append("\n");
            }

            if (CantidadNaranjas > 0) {
                double subtotalNaranjas = CantidadNaranjas * PRECIO_NARANJAS;
                total += subtotalNaranjas;
                mensaje.append("🍊 Naranjas: ").append(CantidadNaranjas).append(" unidades x S/. ")
                       .append(String.format("%.2f", PRECIO_NARANJAS))
                       .append(" = S/. ").append(String.format("%.2f", subtotalNaranjas)).append("\n");
            }

            mensaje.append("\n=====================================\n");
            mensaje.append("💰 TOTAL A PAGAR: S/. ").append(String.format("%.2f", total)).append("\n");
            mensaje.append("=====================================\n");
            mensaje.append("¡Gracias por su compra!\n");
            
            // Agregar descuentos o promociones si aplica
            if (total > 20.0) {
                mensaje.append("\n🎉 ¡Felicitaciones! Su compra califica para descuentos futuros.\n");
            }

        } catch (Exception e) {
            // Manejo de errores inesperados
            mensaje = new StringBuilder();
            mensaje.append("ERROR INTERNO: Se ha producido un error inesperado.\n");
            mensaje.append("Detalles técnicos: ").append(e.getMessage()).append("\n");
            mensaje.append("Por favor, contacte al administrador del sistema.\n");
            
            // Log del error (en un sistema real se usaría un logger)
            System.err.println("Error en comprasProductos: " + e.getMessage());
            e.printStackTrace();
        }

        return mensaje.toString();
    }
    
    /**
     * Método adicional para obtener información de precios
     */
    @WebMethod(operationName = "obtenerPrecios")
    public String obtenerPrecios() {
        StringBuilder precios = new StringBuilder();
        precios.append("=== LISTA DE PRECIOS ===\n");
        precios.append("🍞 Pan: S/. ").append(String.format("%.2f", PRECIO_PAN)).append(" por unidad\n");
        precios.append("🧀 Queso: S/. ").append(String.format("%.2f", PRECIO_QUESO)).append(" por unidad\n");
        precios.append("🍌 Plátanos: S/. ").append(String.format("%.2f", PRECIO_PLATANOS)).append(" por unidad\n");
        precios.append("🍊 Naranjas: S/. ").append(String.format("%.2f", PRECIO_NARANJAS)).append(" por unidad\n");
        precios.append("=======================\n");
        precios.append("Precios válidos al: ").append(new java.util.Date()).append("\n");
        return precios.toString();
    }
    
    /**
     * Método para validar cantidades sin procesar la compra
     */
    @WebMethod(operationName = "validarCantidades")
    public String validarCantidades(
        @WebParam(name = "CantidadPan") int CantidadPan,
        @WebParam(name = "CantidadQueso") int CantidadQueso,
        @WebParam(name = "CantidadPlatanos") int CantidadPlatanos,
        @WebParam(name = "CantidadNaranjas") int CantidadNaranjas) {
        
        if (CantidadPan < 0 || CantidadQueso < 0 || CantidadPlatanos < 0 || CantidadNaranjas < 0) {
            return "ERROR: Las cantidades no pueden ser negativas.";
        }
        
        if (CantidadPan == 0 && CantidadQueso == 0 && CantidadPlatanos == 0 && CantidadNaranjas == 0) {
            return "ERROR: Debe seleccionar al menos un producto.";
        }
        
        if (CantidadPan > 1000 || CantidadQueso > 1000 || CantidadPlatanos > 1000 || CantidadNaranjas > 1000) {
            return "ERROR: Las cantidades no pueden exceder 1000 unidades por producto.";
        }
        
        return "OK: Las cantidades son válidas.";
    }
}