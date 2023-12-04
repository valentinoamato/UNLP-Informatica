program ejercicio2;
const 
    cantZonas=5;
type 
    numerozona = 1..cantZonas;
    regpropiedad = record
        codigo:integer;
        tipo:string;
        precioTotal:real;
    end;
    regpropiedadlectura = record
        zona:numerozona;
        codigo:integer;
        tipo:string;
        cantidad:real;
        precio:real;
    end;
    lista =^ nodo;
    nodo = record 
        sig:lista;
        dato:regpropiedad;
    end;
    vectorzonas = array [1..cantZonas] of lista;

procedure inicializarVector(var vector:vectorzonas);
var 
    i:integer;
begin 
    for i:=1 to cantZonas do 
        vector[i]:=nil;
end;

procedure insertar(var pri:lista;propiedad:regpropiedad);
var 
    anterior,actual,aux:lista;
begin 
    actual:=pri;
    anterior:=nil;
    while (actual<>nil) and (propiedad.tipo>actual^.dato.tipo) do 
        begin 
            anterior:=actual;
            actual:=actual^.sig;
        end;
    new(aux);
    aux^.dato:=propiedad;
    aux^.sig:=actual;
    if (anterior=nil) then
        pri:=aux
    else
        anterior^.sig:=aux;
end;


procedure leerPropiedad (var propiedad:regpropiedadlectura);
begin 
    writeln('Ingrese precio por metro cuadrado:');
    readln(propiedad.precio);
    if (propiedad.precio<>-1) then 
        begin
            writeln('Ingrese numero de zona:');
            readln(propiedad.zona);
            writeln('Ingrese codigo de propiedad:');
            readln(propiedad.codigo);
            writeln('Ingrese tipo de propiedad:');
            readln(propiedad.tipo);
            writeln('Ingrese cantidad de metros cuadrados:');
            readln(propiedad.cantidad);
        end;
end;

procedure cargar(var zonas:vectorzonas);
var 
    propiedad:regpropiedad;
    propiedadlectura:regpropiedadlectura;
begin 
    leerPropiedad(propiedadlectura);
    while (propiedadlectura.precio<>-1) do
        begin 
            propiedad.codigo:=propiedadlectura.codigo;
            propiedad.tipo:=propiedadlectura.tipo;
            propiedad.precioTotal:=propiedadlectura.precio*propiedadlectura.cantidad;
            insertar(zonas[propiedadlectura.zona],propiedad);
            leerPropiedad(propiedadlectura);
        end;
end;

//Imprime los codigos de las propiedades cuyo numero de zona y tipo coincide con los recibidos
procedure propiedades(zonas:vectorzonas;zona:integer;tipo:string);
var 
    i:integer;
begin 
    i:=1;
    writeln('Los codigos de las propiedades de tipo ',tipo,' en la zona ',zona,' son: ');
    while (zonas[zona]<>nil) do 
        begin 
            if (zonas[zona]^.dato.tipo=tipo) then 
                writeln('  ',i,'-',zonas[zona]^.dato.codigo);
            zonas[zona]:=zonas[zona]^.sig;
            i:=i+1;
        end;
end;

var 
    zonas:vectorzonas;
    zona:integer;
    tipo:string;
begin
    inicializarVector(zonas);
    cargar(zonas);
    writeln('Ingrese numero de zona:');
    readln(zona);
    writeln('Ingrese tipo de propiedad:');
    readln(tipo);
    propiedades(zonas,zona,tipo);
end.