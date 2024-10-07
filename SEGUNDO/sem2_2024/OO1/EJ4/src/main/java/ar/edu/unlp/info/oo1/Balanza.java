package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.*;
import java.util.LinkedList;
import java.util.List;

public class Balanza {
    private List<Producto> productos;

    public Balanza() {
        this.productos = new LinkedList<Producto>();
    }

    public int getCantidadDeProductos() {
        return this.productos.size();
    }

    public double getPrecioTotal() {
        return productos.stream().mapToDouble(producto->producto.getPrecio()).sum();
    }

    public double getPesoTotal() {
        return productos.stream().mapToDouble(producto->producto.getPeso()).sum();
    }

    public void ponerEnCero() {
        this.productos.clear();
    }

    public void agregarProducto(Producto producto) {
        this.productos.add(producto);
    }

    public Ticket emitirTicket() {
        return new Ticket(this.productos);
    }

    public List<Producto> getProductos() {
        return this.productos;
    }
}
