package EJ3;

public class Test {

	public static void main(String[] args) {
		Profesor[] profesores = new Profesor[2];
		Estudiante[] estudiantes = new Estudiante[3];
		
		profesores[0] = new Profesor("Carlos", "Cerwien", "CC@gmail.com", "Atletismo", "Facultad 1");
		profesores[1] = new Profesor("Mateo", "Polius", "MP@gmail.com", "Herreria", "Facultad 2");
		
		estudiantes[0] = new Estudiante("Joaquin", "Acevedo", "JA@gmail.com", "4B", "45 E 8 y 9");
		estudiantes[1] = new Estudiante("Gabriel", "Kiusa", "GK@gmail.com", "1A", "24 E 55 y 56");
		estudiantes[2] = new Estudiante("Pedro", "Tijuan", "PT@gmail.com", "3C", "489 E 14A y 14B");
		
		System.out.println("Los profesores son: ");
		for (Profesor profe: profesores) {
			System.out.println(profe.tusDatos());
		}

		System.out.println("\n\nLos estudiantes son: ");
		for (Estudiante est: estudiantes) {
			System.out.println(est.tusDatos());
		}


	}
}
