package tp5.ejercicio5;

import tp5.ejercicio1.Graph;
import tp5.ejercicio1.Vertex;
import tp5.ejercicio1.adjList.AdjListGraph;

public class Main {
    public static void main(String[] args) {
        Graph<Persona> grafin = new AdjListGraph<Persona>();
        Vertex<Persona> abuelo1 = grafin.createVertex(new Jubilado("Abuelo1", false));
        Vertex<Persona> abuelo2 = grafin.createVertex(new Jubilado("Abuelo2", false));
        Vertex<Persona> abuelo3 = grafin.createVertex(new Jubilado("Abuelo3", true));
        Vertex<Persona> abuelo4 = grafin.createVertex(new Jubilado("Abuelo4", false));
        Vertex<Persona> abuelo5 = grafin.createVertex(new Jubilado("Abuelo5", false));
        Vertex<Persona> abuelo6 = grafin.createVertex(new Jubilado("Abuelo6", false));
        Vertex<Persona> abuelo7 = grafin.createVertex(new Jubilado("Abuelo7", false));
        Vertex<Persona> abuelo8 = grafin.createVertex(new Jubilado("Abuelo8", true));
        Vertex<Persona> empleado1 = grafin.createVertex(new Empleado("Empleado1"));
        Vertex<Persona> empleado2 = grafin.createVertex(new Empleado("Empleado2"));

        grafin.connect(empleado1, abuelo1);
        grafin.connect(abuelo1, empleado1);

        grafin.connect(empleado1, abuelo7);
        grafin.connect(abuelo7, empleado1);

        grafin.connect(abuelo1, abuelo4);
        grafin.connect(abuelo4, abuelo1);

        grafin.connect(abuelo4, abuelo2);
        grafin.connect(abuelo2, abuelo4);

        grafin.connect(abuelo2, empleado2);
        grafin.connect(empleado2, abuelo2);

        grafin.connect(empleado2, abuelo6);
        grafin.connect(abuelo6, empleado2);

        grafin.connect(empleado2, abuelo8);
        grafin.connect(abuelo8, empleado2);

        grafin.connect(abuelo8, abuelo7);
        grafin.connect(abuelo7, abuelo8);

        grafin.connect(abuelo8, abuelo5);
        grafin.connect(abuelo5, abuelo8);

        grafin.connect(abuelo5, abuelo3);
        grafin.connect(abuelo3, abuelo5);

        grafin.connect(abuelo3, abuelo6);
        grafin.connect(abuelo6, abuelo3);

        System.out.println("\nDistancia 1:");
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado1.getData(), 1));
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado2.getData(), 1));

        System.out.println("\nDistancia 2:");
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado1.getData(), 2));
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado2.getData(), 2));

        System.out.println("\nDistancia 4:");
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado1.getData(), 4));
        Banco.imprimirJubilados(Banco.algoritmo(grafin, (Empleado) empleado2.getData(), 4));
    }
}
