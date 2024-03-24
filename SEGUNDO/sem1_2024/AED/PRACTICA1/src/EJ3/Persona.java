package EJ3;

public class Persona {
	private String nombre;
	private String apellido;
	private String email;
	
	
	public Persona(String nombre, String apellido, String email) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.email = email;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getApellido() {
		return apellido;
	}


	public void setApellido(String apellido) {
		this.apellido = apellido;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	@Override
	public String toString() {
		return "nombre=" + this.getNombre() + ", apellido=" + this.getApellido() + ", email=" + this.getEmail();
	}	
	
	
}
