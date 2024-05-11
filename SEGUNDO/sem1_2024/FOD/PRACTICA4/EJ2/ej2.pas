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

    tarch = file of talumno;

    tnodo = record 
        hijos: array [1..ORDEN] of integer;  
        claves: array [1..(ORDEN-1)] of longint;
        enlaces: array [1..(ORDEN-1)] of integer;
        nclaves: integer;
    end;

    tindices = file of tnodo;

//PUNTO B:
// Si los numeros enteros ocupan 4B y asumo que alli cabe un NRR, una clave o la cantidad de claves:
// La memoria utilizada segun el orden sera: B = M*4B+(M-1)*4B+(M-1)*4B+4B 
// Desarrollo:
//  B = M*4B + M*4B - 4B + M*4B - 4B + 4B 
//  B = 3M*4B - 4B
// Remplazo:
//  512B = 3M*4B - 4B 
//  512B - 4B = 3M*4B 
//  508B / 4B = 3M
//  M = 127 / 3
//  M = 42,3333333333
// Trunco:
//  M = 42

//PUNTO C:
// Implica que para cualquier operacion, en promedio, se requeriran accesos a menos nodos. 
// Ya que aumento la probabilidad de encontrar una clave aleatoria en un nodo aleatorio,
// y se redujo la profundidad del arbol.

//PUNTO D:
// El proceso de busqueda es el mismo descripto para el arbol del punto 1 con la unica diferencia de 
// que al encontrar la clave que busco, no puedo tomar la informacion del registro directamente del nodo.
// Sino que debo usar el NRR guardado en el enlace para buscar el registro en el archivo donde se guarda la informacion.

//PUNTO E:
// Si se deseara hacer una busqueda por legajo con la estructura actual lo mas sencillo seria recorrer de forma secuencial 
// el archivo que contiene los datos. Si se quisiera brindar acceso indizado al archivo por numero de legajo se deberia 
// construir un nuevo archivo de indices estructurado como arbol B que use los legajos como claves.

//PUNTO F: 
// El problema que tiene es que resulta muy probable que se tengan que recorrer los mismos nodos varias veces, resultando 
// en mas lecturas de las idealmente necesarias.
// Esto sucede porque al recorrer un nodo no terminal (con 3 hijos por ejemplo) de forma "secuencial" se da lo siguiente:
//     Se lee el nodo
//     Se lee el hijo 0
//     Se lee el nodo nuevamente (para tomar la clave 0)
//     Se lee el hijo 1
//     Se lee el nodo nuevamente (para tomar la clave 1)
//     Se lee el hijo 2

// De esta manera cada nodo no terminal que se encuentree en el rango de busqueda se leera tantas veces como hijos tenga.


begin
end.