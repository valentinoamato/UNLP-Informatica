// 2. Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la
// información de los autos en venta. Implementar un programa que:
// a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y
// modelo) y los almacene en dos estructuras de datos:
// i. Una estructura eficiente para la búsqueda por patente.
// ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
// almacenar todos juntos los autos pertenecientes a ella.
// b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
// cantidad de autos de dicha marca que posee la agencia.
// c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
// la cantidad de autos de dicha marca que posee la agencia.
// d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
// la información de los autos agrupados por año de fabricación.
// e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
// modelo del auto con dicha patente.
// f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
// modelo del auto con dicha patente.

program test;
const 
    dimf=8; //2010-2018
type
    autos = record
        patente:string;
        anno:integer; //subrango 2010..2018
        marca:string;
    end;
    // moduloD
    vector = array [1..dimf] of autos; 
    // moduloA i)
    arbolA = ^nodoA;
    nodoA = record
        HI:arbolA;
        HD:arbolB;
        dato:auto;
    end;
    //moduloA ii)
    lista=^nodo;
    nodo = record;
        dato:autos;
        sig:lista;
    end;
    arbolB = ^nodoB;
    nodoB = record
        HI:arbolB;
        HD:arbolB;
        dato:lista;
    end;

procedure leerauto(var auto:autos);
begin
    Randomize;
    write('patente (no): ');
    readln(auto.patente);
    if (auto.patente<>'no') then
        begin
            write('marca: ');
            readln(auto.marca);
            auto.anno:=random(7)+1;
            writeln('anno: ',auto.anno);
end;

procedure imprimirauto(auto:autos);
begin
    writeln('patente: ',auto.patente);
    writeln('marca: ',auto.marca);
    writeln('anno: ',auto.anno);
end;

procedure agregarAdelante(var pri:lista;dato:nodo);
var
    aux:lista;
begin
    new(aux);
    aux^.dato:=dato;
    aux^.sig=pri;
    pri:=aux;
end;

procedure imprimirlista(pri:lista);
begin
    while (pri<>nil) do
        begin
            leerauto(pri^.dato);
            pri:=pri^.sig;
        end;
end;

procedure agregarArbolA(var a:arbolA;dato:autos);
begin
    if (a=nil) then 
        begin
            new(a);
            a^.HI:=nil;
            a^.HD:=nil;
            a^.dato:=dato;
        end
    else if (dato.patente>a^.dato.patente) then
        agregarArbolA(a^.HD,dato)
    else
        agregarArbolA(a^.HI,dato);
end;

procedure agregarArbolB(var a:arbolB;dato:autos);
var
    aux:lista;
begin
    if (a=nil) then 
        begin
            new(a);
            a^.HI:=nil;
            a^.HD:=nil;
            agregarAdelante(aux,dato);
            a^.dato:=aux;
        end
    else if (dato.marca=a^.dato.marca) then 
        agregarAdelante(a^.dato,dato)
    if (dato.marca>a^.dato.marca) then
        agregarArbolA(a^.HD,dato)
    else
        agregarArbolA(a^.HI,dato);
end;

procedure imprimirA(a:arbolA);
begin
    imprimirA(a^.HI);
    imprimirauto(a^.dato);
    imprimirA(a^.HD);
end;

procedure imprimirB(a:arbolB);
begin
    imprimirA(a^.HI);
    imprimirlista(a^.dato);
    imprimirA(a^.HD);
end;

procedure moduloA(var a:arbolA;var B:arbolB);
var
    auto:autos;
begin
    while


var
    A:arbolA;
    B:arbolB;
begin
    moduloA(A,B);
    writeln('ARBOL A:');
    imprimirA(A);    
    writeln('ARBOL B:');
    imprimirB(B);    






























//15:47 //16:18