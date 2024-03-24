package EJ5;

public class Calcular {
	private static Dato varc;
	
	public static Dato moduloa(int[] enteros) {
		int min = 999999;
		int max = -999999;
		int total = 0;
		for (int e: enteros) {
			if (e < min) {
				min=e;
			} else if (e>max) {
				max=e;
			}
			total+=e;
		}
		return new Dato(max, min, (float) total/enteros.length);
	}

	public static void modulob(int[] enteros, Dato dato) {
		int min = 999999;
		int max = -999999;
		int total = 0;
		for (int e: enteros) {
			if (e < min) {
				min=e;
			} else if (e>max) {
				max=e;
			}
			total+=e;
		}
		dato.setMaximo(max);
		dato.setMinimo(min);
		dato.setPromedio( (float) total/enteros.length);
	}

	public static void moduloc(int[] enteros) {
		int min = 999999;
		int max = -999999;
		int total = 0;
		for (int e: enteros) {
			if (e < min) {
				min=e;
			} else if (e>max) {
				max=e;
			}
			total+=e;
		}
		varc = new Dato(max, min, (float) total/enteros.length);
	}

	public static Dato getVarc() {
		return varc;
	}
	
}

