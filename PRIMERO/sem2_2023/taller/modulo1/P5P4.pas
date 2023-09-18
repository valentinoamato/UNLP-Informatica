// 4. Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
// se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
// igual a -1. Se pide:
// a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
// se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
// b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
// reclamos efectuados por ese DNI.
// c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
// reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
// d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
// los reclamos realizados en el año recibido.


program test;

type
    reclamos = record
        // codigo:integer;
        dni:integer;
        anno:integer;
        // tipo:string;
    end;
    
    reclamoslista = record
        // codigo:integer;
        anno:integer;
        // tipo:string;
    end;

    lista = ^nodo;
    nodo = record
        sig:lista;
        dato:reclamoslista;
    end;

    datosarbol = record
        cant:integer;
        dni:integer;
        listareclamos:lista;
    end;

    arbol=^nodoarbol;
    nodoarbol=record
        HI:arbol;
        HD:arbol;
        dato:datosarbol;
    end;

procedure leerReclamo(var reg:reclamos);
begin
    write('dni(0):' );
    readln(reg.dni);
    write('anno:' );
    readln(reg.anno);
end;

procedure agregarAdelante(var pri:lista;dato:reclamoslista);
var
    aux:lista;
begin
    new(aux);
    aux^.sig:=pri;
    aux^.dato:=dato;
    pri:=aux;
end;

procedure agregarArbol(var a:arbol;dato:datosarbol);
begin
    if (a=nil) then
        begin
            new(a);
            a^.HI:=nil;
            a^.HD:=nil;
            a^.dato:=dato;
        end
    else if (dato.dni=a^.dato.dni) then
        begin
            agregarAdelante(a^.dato.listareclamos,dato.listareclamos^.dato);
            a^.dato.cant:=a^.dato.cant+1;
        end
    else if (dato.dni>a^.dato.dni) then
        agregarArbol(a^.HD,dato)
    else 
        agregarArbol(a^.HI,dato);
end;

procedure   imprimirLista(pri:lista);
begin
    writeln;
    while (pri<>nil) do
        begin
            write('|| ',pri^.dato.anno);
            pri:=pri^.sig;
        end;
    writeln;
end;

procedure imprimirArbol(a:arbol);
begin
    if (a<>nil) then
        begin
            imprimirArbol(a^.HI);
            writeln;
            write(' || dni:',a^.dato.dni);
            write(' || cant:',a^.dato.cant);
            writeln;
            imprimirLista(a^.dato.listareclamos);
            imprimirArbol(a^.HD);
        end;
end;

procedure moduloA (var a:arbol);
var
    datoarbol:datosarbol;
    reclamo:reclamos;
    reclamolista:reclamoslista;
begin
    leerReclamo(reclamo);
    while (reclamo.dni<>0)do
        begin
            datoarbol.cant:=1;
            datoarbol.dni:=reclamo.dni;
            reclamolista.anno:=reclamo.anno;
            datoarbol.listareclamos:=nil;
            agregarAdelante(datoarbol.listareclamos,reclamolista);
            agregarArbol(a,datoarbol);
            leerReclamo(reclamo);
        end;
end;

function moduloB(a:arbol;n:integer):integer;
begin
    if (a<>nil) then
        writeln('num: ',a^.dato.dni);
    if (a=nil) then
        moduloB:=-1
    else if (a^.dato.dni=n) then
        moduloB:=a^.dato.cant
    else if (n>a^.dato.dni) then
        moduloB:=moduloB(a^.HD,n)
    else
        moduloB:=moduloB(a^.HI,n);
end;

function moduloC(a:arbol;n,m:integer):integer;
begin
    if (a=nil) then
        moduloC:=0
    else if (a^.dato.dni>n) and (a^.dato.dni<m) then
        moduloC:=moduloC(a^.HI,n,m) +moduloC(a^.HD,n,m)+a^.dato.cant
    else if (a^.dato.dni>=m) then
        moduloC:=moduloC(a^.HI,n,m)
    else
        moduloC:=moduloC(a^.HD,n,m);
end;

function moduloD(a:arbol;anno:integer):integer;
begin
    if (a=nil) then
        moduloD:=0
    else if (a^.dato.listareclamos^.dato.anno=anno) then
        moduloD:=1+moduloD(a^.HI,anno)+moduloD(a^.HD,anno)
    else
        moduloD:=moduloD(a^.HI,anno)+moduloD(a^.HD,anno)
end;
    
var
    a:arbol;
    n,m:integer;
begin
    a:=nil;
    moduloA(a);
    imprimirArbol(a);
    write('Ingrese dni:');
    readln(n);
    writeln('El dni ',n,' tiene ',moduloB(a,n), 'reclamos');
    write('Ingrese dni 1:');
    readln(n);
    write('Ingrese dni 2:');
    readln(m);
    writeln('cantidad total: ',moduloC(a,n,m));
    writeln('moduloD: ',moduloD(a,n));
end.