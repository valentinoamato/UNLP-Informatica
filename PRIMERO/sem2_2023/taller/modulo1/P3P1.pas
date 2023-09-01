{Escribir un programa que:
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
    retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    xi. Informe los numeros de socio en orden creciente.
    x. Informe los numeros de socio pares en orden decreciente.
}

Program ImperativoClase3;

type rangoEdad = 12..100;
    cadena15 = string [15];
    socio = record
            numero: integer;
            nombre: cadena15;
            edad: rangoEdad;
            end;
    arbol = ^nodoArbol;
    nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                end;

Procedure LeerSocio (var s: socio);
begin
    write ('Ingrese numero del socio: ');
    readln (s.numero);
    If (s.numero <> 0)
    then begin
        write ('Ingrese nombre del socio: ');
        readln (s.nombre);
        write ('Ingrese edad del socio: ');
        readln (s.edad);
        end;
end;  

Procedure InsertarElemento (var a: arbol; elem: socio);
Begin
    if (a = nil) 
    then begin
        new(a);
        a^.dato:= elem; 
        a^.HI:= nil; 
        a^.HD:= nil;
        end
    else if (elem.numero < a^.dato.numero) 
        then InsertarElemento(a^.HI, elem)
        else InsertarElemento(a^.HD, elem); 
End;
    
procedure GenerarArbol (var a: arbol);
{ Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda. De cada socio se lee numero de socio, 
nombre y edad. La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. }
var unSocio: socio;
Begin
writeln;
writeln ('----- Ingreso de socios y armado del arbol ----->');
writeln;
a:= nil;
LeerSocio (unSocio);
while (unSocio.numero <> 0)do
begin
InsertarElemento (a, unSocio);
writeln;
LeerSocio (unSocio);
end;
writeln;
writeln ('-----------------------------------------------');
writeln;
end;


function NumeroMasGrande (a: arbol): integer;
begin
    if (a = nil) then NumeroMasGrande:= -1
    else if (a^.HD = nil) then NumeroMasGrande:= a^.dato.numero
                        else NumeroMasGrande:= NumeroMasGrande (a^.HD);
end;

procedure InformarNumeroSocioMasGrande (a: arbol);
{Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor.}
var max: integer;
begin
writeln;
writeln ('----- Informar Numero Socio Mas Grande ----->');
writeln;
max:= NumeroMasGrande (a);
if (max = -1) 
then writeln ('Arbol sin elementos')
else begin
        writeln;
        writeln ('Numero de socio mas grande: ', max);
        writeln;
    end;
writeln;
writeln ('-----------------------------------------------');
writeln;
end;

function SocioMasChico (a: arbol): arbol;
begin
    if ((a = nil) or (a^.HI = nil))
    then SocioMasChico:= a
    else SocioMasChico:= SocioMasChico (a^.HI);
end;

procedure InformarDatosSocioNumeroMasChico (a: arbol);
{ Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. }
var minSocio: arbol;
begin
writeln;
writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
writeln;
minSocio:= SocioMasChico (a);
if (minSocio = nil) 
then writeln ('Arbol sin elementos')
else begin
        writeln;
        writeln ('Socio con numero mas chico: ', minSocio^.dato.numero, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
        writeln;
    end;
writeln;
writeln ('-----------------------------------------------');
writeln;
end;

procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
    begin
    if (nuevoValor >= maxValor) then
    begin
        maxValor := nuevoValor;
        maxElem := nuevoElem;
    end;
    end;

procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
    begin
    if (a <> nil) then
    begin
        actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
        numeroMasEdad(a^.hi, maxEdad,maxNum);
        numeroMasEdad(a^.hd, maxEdad,maxNum);
    end; 
    end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }
var maxEdad, maxNum: integer;
begin
writeln;
writeln ('----- Informar Numero Socio Con Mas Edad ----->');
writeln;
maxEdad := -1;
NumeroMasEdad (a, maxEdad, maxNum);
if (maxEdad = -1) 
then writeln ('Arbol sin elementos')
else begin
        writeln;
        writeln ('Numero de socio con mas edad: ', maxNum);
        writeln;
    end;
writeln;
writeln ('-----------------------------------------------');
writeln;
end;

procedure AumentarEdad (a: arbol);
begin
if (a <> nil)
then begin
        a^.dato.edad:= a^.dato.edad + 1;
        AumentarEdad (a^.HI);
        AumentarEdad (a^.HD);
    end;
end;

function Buscar (a: arbol; num: integer): boolean;
begin
    if (a = nil) 
    then Buscar:= false
    else If (a^.dato.numero = num) 
        then Buscar:= true
        else if (num < a^.dato.numero)
            then Buscar:= Buscar (a^.HI, num)
            else Buscar:= Buscar (a^.HD, num)
end;

procedure InformarExistenciaNumeroSocio (a: arbol);
{ Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
    retorne verdadero o falso. }
var numABuscar: integer;
begin
writeln;
writeln ('----- Informar Existencia Numero Socio ----->');
writeln;
write ('Ingrese numero de socio a buscar: ');
Readln (numABuscar);
writeln;
if (Buscar (a, numABuscar)) 
then writeln ('El numero ', numABuscar, ' existe')
else writeln ('El numero ', numABuscar, ' no existe');
writeln;
writeln ('-----------------------------------------------');
writeln;
end;

function BuscarNombre (a:arbol;nombre:string):boolean;
begin
    if (a<>nil)then
        begin
            if (a^.dato.nombre=nombre) then
                BuscarNombre:=True
            else
                begin
                    BuscarNombre:=BuscarNombre(a^.HI,nombre);
                    BuscarNombre:=BuscarNombre(a^.HD,nombre);
                end;
        end
    else
        BuscarNombre:=False;
end;

procedure InformarExistenciaNombreSocio (a: arbol);
{ Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
    retorne verdadero o falso. }
var Nombre: string;
begin
writeln;
writeln ('----- Informar Existencia Nombre Socio ----->');
writeln;
write ('Ingrese Nombre de socio a buscar: ');
Readln (Nombre);
writeln;
if (BuscarNombre (a, Nombre)) 
then writeln ('El Nombre ', Nombre, ' existe')
else writeln ('El Nombre ', Nombre, ' no existe');
writeln;
writeln ('-----------------------------------------------');
writeln;
end;

function ContarSocios (a: arbol;var contador:integer):integer;
begin
if (a <> nil) then 
    begin
        ContarSocios (a^.HI,contador);
        ContarSocios (a^.HD,contador);
        contador:=contador+1;
    end;
ContarSocios:=contador;
end;

procedure InformarCantidadSocios(a:arbol);
var
    contador:integer;
begin
    contador:=0;
    writeln;
    writeln('La cantidad de socios es: ',ContarSocios(a,contador));
    writeln;
end;

function promedio(a:arbol):real;
var
    edadtotal,cantsocios:integer;
begin
procedure ContarSociosYEdad (a: arbol;var cantsocios,edadtotal:integer);
begin
if (a <> nil) then 
    begin
        ContarSocios (a^.HI,contador);
        ContarSocios (a^.HD,contador);
        contador:=contador+1;
        edadtotal:=edadtotal+a^.dato.edad;
    end;
end;
edadtotal:=0;
cantsocios:=0;
ContarSociosYEdad(a,cantsocios,edadtotal);
promedio:=edadtotal/cantsocios;

end;

procedure InformarPromedioDeEdad(a:arbol);
var
    contador:integer;
begin
    contador:=0;
    writeln;
    writeln('La cantidad de socios es: ',ContarSocios(a,contador));
    writeln;
end;


var a: arbol; 
Begin
GenerarArbol (a);
InformarNumeroSocioMasGrande (a);
InformarDatosSocioNumeroMasChico (a);
InformarNumeroSocioConMasEdad (a);
AumentarEdad (a);
InformarExistenciaNumeroSocio (a);
InformarExistenciaNombreSocio (a);
InformarCantidadSocios (a);
InformarPromedioDeEdad (a);
// InformarNumerosSociosOrdenCreciente (a);
// InformarNumerosSociosOrdenDeCreciente (a);
    
readln();
End.
