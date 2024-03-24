package EJ1;

public class Clase {
	
	public static void metodoa(int a, int b) {
		System.out.println("Metodo A:");
		System.out.println("Los numeros entre "+a+" y "+b+" son:");
		for (int i=a;i<=b;i++) {
			System.out.println(i);
		}
	}
	
	public static void metodob(int a, int b) {
		System.out.println("Metodo B:");
		System.out.println("Los numeros entre "+a+" y "+b+" son:");
		while (a<=b) {
			System.out.println(a);		
			a++;
		}
	}
	public static void metodoc(int a, int b) {
		System.out.println(a);			
		if (a<b) {
			a++;
			metodoc(a, b);
		}
	}
	
	
	
}
