package EJ5;

public class Dato {
	private int maximo;
	private int minimo;
	private float promedio;
	
	public Dato(int maximo, int minimo, float promedio) {
		this.maximo = maximo;
		this.minimo = minimo;
		this.promedio = promedio;
	}

	public int getMaximo() {
		return maximo;
	}

	public void setMaximo(int maximo) {
		this.maximo = maximo;
	}

	public int getMinimo() {
		return minimo;
	}

	public void setMinimo(int minimo) {
		this.minimo = minimo;
	}

	public float getPromedio() {
		return promedio;
	}

	public void setPromedio(float promedio) {
		this.promedio = promedio;
	}

	@Override
	public String toString() {
		return "Dato [maximo=" + maximo + ", minimo=" + minimo + ", promedio=" + promedio + "]";
	}
	
	
}
