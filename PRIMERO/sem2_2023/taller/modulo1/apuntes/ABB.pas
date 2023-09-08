program test;

type

    arbol=^nodo;
    nodo = record
        dato : integer;
        HI:arbol;
        HD:arbol;
    end;


procedure agregar(var a:arbol;dato:integer);
var
    aux:arbol;
begin
    new(aux);
    aux^.HI:=nil;
    aux^.HD:=nil;
    aux^.dato:=dato;
    if (a=nil) then
        a:=aux
    else if (dato<=a^.dato) then
        agregar(a^.HI,dato)
    else
        agregar(a^.HD,dato);
end;


procedure cargar(var a:arbol);
var
    dato:integer;
begin
    writeln('Ingrese un numero(corte en -1): ');
    readln(dato);
    while (dato<>-1) do
        begin
            agregar(a,dato);
            writeln('Ingrese un numero(corte en -1): ');
            readln(dato);
        end;
end;

procedure imprimir(a:arbol);
begin
    if (a<>nil) then
        begin
            imprimir(a^.HI);
            writeln('\',a^.dato,'\');
            imprimir(a^.HD);
        end;
end;

function minimoNodo(a:arbol):arbol;
begin
    if (a=nil) or (a^.HI=nil) then
        minimoNodo:=a
    else 
        minimoNodo:=minimoNodo(a^.HI);
end;
    
function Busqueda(a:arbol;x:integer):arbol;
begin
    if (a<>nil) then
        write(a^.dato);
    if (a=nil) then
        Busqueda:=nil
    else if (a^.dato=x) then
        Busqueda:=a
    else if (x<a^.dato) then
        Busqueda:=Busqueda(a^.HI,x)
    else
        Busqueda:=Busqueda(a^.HD,x);
end;

var
    a,arbolmin,arbolbusqueda:arbol;
    x:integer;

begin
    a:=nil;
    cargar(a);
    imprimir(a);
    arbolmin:=minimoNodo(a);
    if (arbolmin<>nil)then
        writeln('El minimo es: ',arbolmin^.dato);
    writeln('ingrese el numero a buscar: ');
    readln(x);
    arbolbusqueda:=Busqueda(a,x);
    if (arbolbusqueda<>nil)then
        writeln('El nodo buscado existe: ',arbolbusqueda^.dato);
end.