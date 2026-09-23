package ejercicio6;

import java.util.Comparator;

public class Estudiante {
    private String apellido, nombre;
    private int edad, legajo, materiasAprobadas;

    public Estudiante(String apellido, String nombre, int edad, int legajo, int materiasAprobadas) {
        this.apellido = apellido;
        this.nombre = nombre;
        this.edad = edad;
        this.legajo = legajo;
        this.materiasAprobadas = materiasAprobadas;
    }

    public int getMateriasAprobadas() {
        return this.materiasAprobadas;
    }

    public int getEdad() {
        return this.edad;
    }

    public int getLegajo() {
        return this.legajo;
    }

    public String getNombre() {
        return this.nombre;
    }

    public String getApellido() {
        return this.apellido;
    }

    public String toString() {
        return nombre + " " + apellido + " Edad=" + edad+ ", Legajo=" + legajo + ", Materias=" + materiasAprobadas;
    }

    public static Comparator<Estudiante> getComparatorMateriasAprobadas() {
        return new Comparator<Estudiante>() {
            public int compare(Estudiante e1, Estudiante e2) {
                var v1 = e1.getMateriasAprobadas();
                var v2 = e2.getMateriasAprobadas();
                if (v1 < v2) {
                    return -1;
                } else if (v1 == v2) {
                    return 0;
                } else {
                    return 1;
                }
            }
        };
    }

    public static Comparator<Estudiante> getComparatorEdad() {
        return new Comparator<Estudiante>() {
            public int compare(Estudiante e1, Estudiante e2) {
                var v1 = e1.getEdad();
                var v2 = e2.getEdad();
                if (v1 > v2) {
                    return -1;
                } else if (v1 == v2) {
                    return 0;
                } else {
                    return 1;
                }
            }
        };
    }

    public static Comparator<Estudiante> getComparatorLegajo() {
        return new Comparator<Estudiante>() {
            public int compare(Estudiante e1, Estudiante e2) {
                var v1 = e1.getLegajo();
                var v2 = e2.getLegajo();
                if (v1 < v2) {
                    return -1;
                } else if (v1 == v2) {
                    return 0;
                } else {
                    return 1;
                }
            }
        };
    }

    public static Comparator<Estudiante> getComparatorNombreApellido() {
        return new Comparator<Estudiante>() {
            public int compare(Estudiante e1, Estudiante e2) {
                var v1 = e1.getNombre() + " " + e1.getApellido();
                var v2 = e2.getNombre() + " " + e2.getApellido();
                return v1.compareTo(v2) * -1;
            }
        };
    }
}
