package ejercicio6;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        Estudiante[] estudiantes = {
            new Estudiante("Gomez", "Juan", 20, 1000, 30),
            new Estudiante("Garcia", "Marta", 30, 2000, 10),
            new Estudiante("Martinez", "Carlos", 10, 3000, 50),
            new Estudiante("Suller", "Frederic", 50, 500, 40),
            new Estudiante("Stuart", "James", 15, 1200, 25),
        };

        System.out.println("Estudiantes:");
        for (Estudiante e: estudiantes) {
            System.out.println("  - "+e.toString());
        }

        Arrays.sort(estudiantes, Estudiante.getComparatorMateriasAprobadas());
        System.out.println("\nMaterias Aprobadas:");
        for (Estudiante e: estudiantes) {
            System.out.println("  - "+e.toString());
        }

        Arrays.sort(estudiantes, Estudiante.getComparatorEdad());
        System.out.println("\nEdad:");
        for (Estudiante e: estudiantes) {
            System.out.println("  - "+e.toString());
        }

        Arrays.sort(estudiantes, Estudiante.getComparatorLegajo());
        System.out.println("\nLegajo:");
        for (Estudiante e: estudiantes) {
            System.out.println("  - "+e.toString());
        }

        Arrays.sort(estudiantes, Estudiante.getComparatorNombreApellido());
        System.out.println("\nNombre y Apellido:");
        for (Estudiante e: estudiantes) {
            System.out.println("  - "+e.toString());
        }

    }
}
