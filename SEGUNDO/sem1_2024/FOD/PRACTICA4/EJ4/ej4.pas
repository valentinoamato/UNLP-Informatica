program test;


//QUE ES ESTOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOoooooo 
procedure buscar(NRR:integer;clave:integer; NRR_encontrado:integer; pos_encontrada:integer; resultado);//faltaba ; | falta especificar tipos
var 
    clave_encontrada: boolean;
    nodo:?? //??
begin
    reset(A); //agregado
    read(A,nodo); //agregado
    if (nodo = null) then //faltaba then | nodo??
        resultado := false; {clave no encontrada}
    else
        begin //faltaba
            posicionarYLeerNodo(A, nodo, NRR); //A??
            claveEncontrada(A, nodo, clave, pos, clave_encontrada);//pos??
            if (clave_encontrada) then 
                begin
                    NRR_encontrado := NRR; { NRR actual }
                    pos_encontrada := pos; { posicion dentro del array } //pos??
                    resultado := true;
                end
            else
                buscar(nodo.hijos[pos], clave, NRR_encontrado, pos_encontrada,resultado);//faltaba ; | argumentos erroneos, el primer argumento es un NRR?!
        end; //faltaba
end;

//PUNTO A:
//Lee el un nodo en la posicion NRR del archivo A
//var A:x;var nodo:Y;NRR:z

//PUNTO B:
//Busca 'clave' en los elementos de 'nodo' si la encuentra retorna
//la posicion de la clave en el array de elementos, y True en 'clave encontrada'
//var A:a ; nodo:b ; clave:c ; var pos:d ; var clave_encontrada:e

//PUNTO C:
//Si, varios errores de sintaxis, variables no declaradas, y tipos de datos no especificados, entre otros.
//Se recomienda evaporar el modulo inmediatamente.

//PUNTO D:
//Se requiere que la busqueda termine al llegar a una hoja.


begin 
end.