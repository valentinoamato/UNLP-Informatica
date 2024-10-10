package ar.edu.unlp.info.oo1;

import java.time.LocalDate;
import ar.edu.unlp.info.oo1.Producto;
import java.util.LinkedList;
import java.util.List;

public class Ticket {
    private LocalDate fecha;
    private List<Producto> productos;
    private double precioTotal;

    public Ticket(List<Producto> productos) {
        this.fecha = LocalDate.now();
        this.productos = productos;
        this.precioTotal =  this.productos.stream().mapToDouble(producto->producto.getPrecio()).sum();
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public int getCantidadDeProductos() {
        return this.productos.size();
    }

    public double getPrecioTotal() {
        return this.precioTotal;
    }

    public double getPesoTotal() {
        return productos.stream().mapToDouble(producto->producto.getPeso()).sum();
    }

    public double impuesto() {
        return this.getPrecioTotal() * 0.21;
    }

    public List<Producto> getProductos() {
        return this.productos;
    }
}
