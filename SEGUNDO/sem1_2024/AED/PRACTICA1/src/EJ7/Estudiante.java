package EJ7;

public class Estudiante {
	private String nombre;
	private int numero;
	
	public Estudiante(String nombre, int numero) {
		this.nombre = nombre;
		this.numero = numero;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public int getNumero() {
		return numero;
	}

	public void setNumero(int numero) {
		this.numero = numero;
	}

	@Override
	public String toString() {
		return "Estudiante [nombre=" + nombre + ", numero=" + numero + "]";
	}
}
