// 3.- Escribir un programa que:
// a. Implemente un módulo recursivo que genere una lista de números enteros “random”
// mayores a 0 y menores a 100. Finalizar con el número 0.
// b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista.
// c. Implemente un módulo recursivo que devuelva el máximo valor de la lista.
// d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se
// encuentra en la lista o falso en caso contrario.
program test;
type
    lista=^nodo;
    nodo=record
        sig:lista;
        numero:integer;
    end;

procedure AgregarAdelante(var pri:lista;n:integer);
var
    aux:lista;

begin
    new(aux);
    aux^.sig:=pri;
    aux^.numero:=n;
    pri:=aux;
end;

procedure CargarLista(var pri:lista);
var
    i:integer;
begin
    Randomize;
    AgregarAdelante(pri,0);
    for i:=1 to 9 do
        AgregarAdelante(pri,(random(99)+1));
end;

procedure ImprimirLista(pri:lista);
begin
    while (pri<>nil)do
        begin
            write(' ',pri^.numero);
            pri:=pri^.sig;
        end;
end;
            

var
    pri:lista;
begin
    pri:=nil;
    CargarLista(pri);
    ImprimirLista(pri);
end.