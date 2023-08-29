{1.- Implementar un programa que invoque a los siguientes m�dulos.
a. Un m�dulo recursivo que permita leer una secuencia de caracteres terminada en punto, los almacene en un vector con dimensi�n f�sica igual a 10 y 
retorne el vector.
b. Un m�dulo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un m�dulo recursivo que reciba el vector generado en a) e imprima el contenido del vector..
d. Un m�dulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres le�dos. El programa debe informar 
el valor retornado.
e. Un m�dulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres le�dos.
f. Un m�dulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en el mismo orden que est�n almacenados.
g. Implemente un m�dulo recursivo que reciba la lista generada en e) e imprima los valores de la lista en orden inverso al que est�n almacenados.

}

Program Clase2MI;
const dimF = 5;
type vector = array [1..dimF] of char;
	lista = ^nodo;
	nodo = record
			dato: char;
			sig: lista;
			end;


procedure CargarVector (var v: vector; var dimL: integer);

procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
var caracter: char;
begin
	write ('Ingrese un caracter: ');
	readln(caracter);  
	if (caracter <> '.' ) and (dimL < dimF) 
	then begin
		dimL:= dimL + 1;
		v[dimL]:= caracter;
		CargarVectorRecursivo (v, dimL);
		end;
end;

begin
dimL:= 0;
CargarVectorRecursivo (v, dimL);
end;

procedure ImprimirVector (v: vector; dimL: integer);
var
i: integer;
begin
	writeln('Imprimir Vector Iterativo');
{   for i:= 1 to dimL do
		write ('----');
	writeln;
	write (' ');
}
	for i:= 1 to dimL do begin
		write(v[i], ' | ');
	end;
	writeln;
{    for i:= 1 to dimL do
		write ('----');
}
	writeln;
	writeln;
End;         

procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
procedure RecorrerVectorRecursivo(v:vector; i, dimL:integer);
begin
	if(i<=dimL) then begin
		write(v[i], ' | ');
		RecorrerVectorRecursivo(v,i+1,dimL);
	end;
end;

begin
writeln('Imprimir Vector Recursivo');
RecorrerVectorRecursivo(v,1,dimL);
writeln;
writeln;
end;

function ContarCaracteres(): integer;
var caracter: char;
Begin
write ('Ingrese un caracter: ');
readln(caracter);  
if (caracter <> '.' )  
then ContarCaracteres:= ContarCaracteres() + 1  
else ContarCaracteres:=0  
End;


procedure CargarLista (var l: lista);
var caracter: char;
	nuevo: lista;
Begin
write ('Ingrese un caracter: ');
readln(caracter);  
if (caracter <> '.' )  
then begin
		CargarLista (l);
		{AgregaAdelante}
		new (nuevo);
		nuevo^.dato:= caracter;
		nuevo^.sig:= l;
		l:= nuevo;
		{--------------}
	end
else l:= nil
End;

procedure ImprimirListaMismoOrden (l: lista);
begin
if (l<> nil) then begin
					write (' ', l^.dato);
					ImprimirListaMismoOrden (l^.sig);
					end;
end;


procedure ImprimirListaOrdenInverso (l:lista);
begin
	if (l<>nil) then
		begin
			ImprimirListaOrdenInverso(l^.sig);
			writeln(l^.dato);
		end;
end;
var 
	cont, dimL: integer; l: lista; v: vector;
Begin 
CargarVector (v, dimL);
writeln;
if (dimL = 0) then writeln ('--- Vector sin elementos ---')
				else begin
					ImprimirVector (v, dimL);
					ImprimirVectorRecursivo (v, dimL);
					end;
writeln;
writeln;                   
cont:= ContarCaracteres();
writeln;
writeln;
writeln('Se ingresaron ',cont,' caracteres'); 
writeln;
writeln;
CargarLista (l);
writeln;
writeln;
if (l = nil) then writeln ('--- Lista sin elementos ---')
			else Begin
					writeln ('--- Lista con elementos ---');
					writeln ('--- Orden ingresado ---');
					writeln;
					ImprimirListaMismoOrden (l);
					writeln;
					writeln;
					writeln ('--- Orden inverso ---');
					writeln;
					ImprimirListaOrdenInverso (l); 
					end;
end.
