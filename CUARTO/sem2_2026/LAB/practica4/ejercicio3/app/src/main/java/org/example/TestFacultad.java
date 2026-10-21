package org.example;

import java.util.ArrayList;
import java.util.List;

public class TestFacultad {
    public static void main(String[] args) {
        Alumno a1 = new Alumno(1, "Pedro", "Uno", 18, "Fisica", 4);
        Alumno a2 = new Alumno(2, "Juan", "Dos", 18, "Fisica", 5);
        Alumno a3 = new Alumno(3, "Patricio", "Tres", 18, "Matematica", 4);
        Alumno a4 = new Alumno(4, "Pepe", "Cuatro", 18, "Fisica", 6);
        Alumno a5 = new Alumno(5, "Martin", "Cinco", 18, "Laboratorio de Software", 4);
        Alumno a6 = new Alumno(6, "Juana", "Seis", 18, "CADP", 10);
        Alumno a7 = new Alumno(7, "Carlos", "Siete", 18, "OC", 9);
        Alumno a8 = new Alumno(8, "Simon", "Ocho", 18, "Mate 4", 7);
        Alumno a9 = new Alumno(9, "Marta", "Nueve", 18, "Fisica", 5);

        List<Alumno> alumnos = new ArrayList<>(
            List.of(a1, a2, a3, a4, a5, a6, a7, a8, a9));

        Facultad facultad = new Facultad(alumnos);


        System.out.println("Alumno con mayor nota: " + facultad.getAlumnoConMayorNota().toString() + "\n");

        System.out.println("Imprimiendo dos alumnos.");
        facultad.imprimirDosAlumnos();
        System.out.println("\n");

        System.out.println("Alumno de Laboratorio de Software: " + facultad.getAlumnoDeLaboratorioDeSoftware().toString() + "\n");

        System.out.println("Alumno con nombre que inicia con P y mide 6 o menos caracteres: ");
        facultad.getAlumnosConNombreCortoIniciandoConP().stream().forEach(a -> System.out.println(a.toString()));
        System.out.println("\n");

        System.out.println("Alumnos sin ordenar.");
        facultad.getAlumnos().stream().forEach(a -> System.out.println(a.toString()));
        System.out.println("\n");

        System.out.println("Alumnos ordenados por nota.");
        facultad.ordenarPorNota();
        facultad.getAlumnos().stream().forEach(a -> System.out.println(a.toString()));
        System.out.println("\n");
    }
}
