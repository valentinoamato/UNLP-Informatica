package org.example;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Comparator;

public class Facultad {
    private List<Alumno> alumnos;

    public Facultad(List<Alumno> alumnos) {
        this.alumnos = alumnos;
    }

    public Alumno getAlumnoConMayorNota() {
        return alumnos.stream().max((a1, a2) -> Double.compare(a1.getNota(), a2.getNota())).orElse(null);
    }

    public void imprimirDosAlumnos() {
        alumnos.stream().limit(2).forEach(a -> System.out.println(a.toString()));
    }

    public Alumno getAlumnoDeLaboratorioDeSoftware() {
        return alumnos.stream().filter(a -> a.getMateriaAprobada().equals("Laboratorio de Software")).findAny().orElse(null);
    }

    public List<Alumno> getAlumnosConNombreCortoIniciandoConP() {
        return alumnos.stream().filter(a -> (a.getNombre().startsWith("P") && (a.getNombre().length() <= 6))).collect(Collectors.toList());
    }

    public void ordenarPorNota() {
        Collections.sort(alumnos, Comparator.comparingInt(Alumno::getNota).reversed());
    }

    public List<Alumno> getAlumnos() {
        return this.alumnos;
    }
}
