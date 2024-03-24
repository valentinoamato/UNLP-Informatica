package EJ6;

public class Ej6 {
	/*
	6. Análisis de las estructuras de listas provistas por la API de Java.
		a. ¿En qué casos ArrayList ofrece un mejor rendimiento que LinkedList?
		b. ¿Cuándo LinkedList puede ser más eficiente que ArrayList?
		c. ¿Qué diferencia encuentra en el uso de la memoria en ArrayList y LinkedList?
		d. ¿En qué casos sería preferible usar un ArrayList o un LinkedList?
		
		
	Respuestas:
		a. Cuando se accede a la estructura de modo directo.
		b. Cuando el tama;o de la estuctura varia constantemente.
		c. Para la misma cantidad de elementos la LinkedList usa mas espacio ya que necesita almacenar punteros.
		   Sin embargo, en un ArrayList es mas comun que se desperdicie espacio reservado.
		   Cuando en un ArrayList se quiere agregar un elemento y no hay mas espacio, java aumenta la dimension del
		   ArrayList en mas de uno, lo cual puede aumentar el rendimiento a costa de mas uso de memoria.	
		d. Es preferible usar ArrayList cuando:
			-Se va a usar acceso directo.
			-No se necesita insertar o eliminar elementos de forma excesiva 
		   Es preferible usar LinkedList cuando:
		    -Se va a recorrer la estructura de forma secuencial
		    -Se necesita insertar o eliminar elementos de forma excesiva 
		
		
		
		
		
		
		
		
		
	 */
}
