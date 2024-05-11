// OVERFLOW:
// Ocurre cuando, durante una insercion, un elemento excede la capacidad maxima del nodo correspondiente.

// UNDERFLOW:
// Ocurre cuando, durante una baja, un nodo queda con una cantidad de elementos menor a la minima.

// REDISTRIBUCION:
// Es una forma de solucionar un caso de underflow en un nodo. Para esto se trasladan llaves desde un nodo 
// adyacente al nodo en falla, siempre y cuanto el primero tenga elementos suficientes para la operacion.

// CONCATENACION:
// Es una forma de solucionar un caso de underflow en un nodo cuando resulta imposible redistribuir.
// Para esto se concatena el nodo en falla con un nodo adyacente, reduciendo la cantidad de nodos y en 
// algunos casos la altura del arbol.


