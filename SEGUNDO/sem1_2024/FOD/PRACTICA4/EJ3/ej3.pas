program test;
const 
    ORDEN = 5;
//PUNTO C
type 
    talumno = record
        nombre:string[15];
        apellido:string[15];
        dni:longint;
        legajo:integer;
        anno:integer;
    end;

    tarch = file of talumno;

    tlista = ^ tnodo;
    tnodo = record 
        hijos: array [1..ORDEN] of integer;  
        claves: array [1..(ORDEN-1)] of longint;
        enlaces: array [1..(ORDEN-1)] of integer;
        nclaves: integer;
        sig:tlista;
    end;

    tindices = file of tnodo;

//PUNTO A:
// En un arbol B+ las hojas contienen todos los datos del arbol mientras que los nodos no terminales
// solo contienen separadores.

//PUNTO B:
// Los nodos hoja de un arbol B+ tienen un puntero a el nodo adyacente derecho (o a ambos nodos adyacentes) 
// que permite recorrer todos los nodos hoja de forma secuencial, lo que implica recorrer todo el arbol.

//PUNTO D:
// El proceso de busqueda es el mismo descripto para el arbol del punto 2 con la unica diferencia de 
// que la busqueda siempre termina en un nodo hoja, es decir, que al buscar siempre debo llegar a un nodo
// hoja, y recien al hacerlo puedo tomar la clave que busco (si existe) o determinar que no existe.

//PUNTO E:
// El proceso consiste primero en buscar la clave con valor 40000000 o mayor, para lo cual se debe llegar 
// a una hoja. Una vez identificada dicha clave se continua de la siguiente manera:
//     1-Quedan claves por leer en el nodo? Si->2 No-> 4
//     2-Leo la proxima clave. Es menor o igual a 50000000? Si->3 No->6
//     3-Tomo la clave. -> 1
//     4-Quedan nodos hoja? Si->5 No->6
//     5-Leo el proximo nodo. -> 1
//     6-Termine el recorrido.
// La ventaja frente al arbol B es que se evita repetir lecturas a un mismo nodo

begin
end.