package ar.edu.unlp.info.oo1;

import ar.edu.unlp.info.oo1.Item;
import java.util.LinkedList;
import java.util.List;
import java.time.LocalDate;

public class Presupuesto {
    private LocalDate fecha;
    private String cliente;
    private List<Item> items;

    public Presupuesto(String cliente) {
        this.fecha = LocalDate.now();
        this.cliente = cliente;
        this.items = new LinkedList<Item>();
    }

    public LocalDate getFecha() {
        return this.fecha;
    }

    public String getCliente() {
        return this.cliente;
    }

    public void agregarItem(Item item) {
        items.add(item);
    }

    public double calcularTotal() {
        return items.stream().mapToDouble(item->item.costo()).sum();
    }
}
