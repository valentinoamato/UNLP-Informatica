program test;
const 
    ORDEN = 5;
//PUNTO A
type 
    talumno = record
        nombre:string[15];
        apellido:string[15];
        dni:longint;
        legajo:integer;
        anno:integer;
    end;

    //arbol = integer;  
    tnodo = record 
        hijos: array [1..ORDEN] of integer;  //NRRs
        elementos: array [1..(ORDEN-1)] of talumno;
        NHijos: integer;
    end;

    tarch = file of tnodo;

//PUNTO B:
// Si se que cada registro ocupa 64B y tengo 512B por nodo a priori puedo decir
// que entran 8 registros por nodo.
// Si ahora tengo en cuenta los enlaces a los hijos y el campo de la cantidad de nodos
// se que necesito (M+1)*4B, es decir, 4B por cada enlace mas 4B para almacenar la cantidad
// de claves.
// A esta altura podria maximizar usando derivadas pero en cambio voy a probar con 7,6,5,4, etc registros.
// 7 registros = 7*64B+(8+1)*4B=484B
// RTA: En un nodo entrarian 7 registros de persona y sobrarian 28B.

//PUNTO C:
//QUE?? NINGUNO?!

//PUNTO D: 
// El DNI ya que es unico, tambien podria ser el legajo.

//PUNTO E:
// El proceso de busqueda consiste en recorrer las claves del primer nodo hasta que la clave leida sea
// mayor o igual a la que se busca. Si se encuentra una igual (mejor caso) se retorna ese elemento, 
// si se encuentra una mayor se repite el proceso con el hijo anterior al ultimo elemento recorrido ,es decir,
// si el elemento N4 tiene tiene una clave mayor a la que busco, entonces continuo el recorrido con el hijo N4 del nodo.
// Suponiendo que llego a una hoja y no encuentro en esta la clave que busco, entonces la clave no existe.
// Ademas si en un nodo no terminal la clave que busco es menor a la primer clave, entonces debo continuar
// la busqueda con el primer hijo de ese nodo, si por el contrario en ese mismo nodo la clave que busco 
// es mayor a la ultima clave, entonces debo continuar la busqueda con el ultimo hijo del nodo.
// El peor caso es en el que encuentro o no mi clave en una hoja del arbol, en este caso tengo que leer
// tantos nodos como niveles tenga el arbol.

//PUNTO F:
// Si se buscara un alumno por un criterio diferente en el peor caso se requeriria hacer tantas lecturas como 
// nodos tenga el arbol.

begin
end.