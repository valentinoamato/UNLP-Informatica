//Esta resolucion corresponde a una simplificacion del ejercicio 18
//Tanto los detalles de nacimiento como los de fallecimientos solo contienen un numero para identificar a cada persona
//El archivo maestro resultante es de tipo texto y solo contiene el numero de identificacion de cada persona
// y si fallecio o no
program test;

uses sysutils;

const 
    VALORALTO=9999;
    DIMF=50;
type 
    tdetalles = array [1..DIMF] of Text;
    tregistros = array [1..DIMF] of integer;
var 
    nacimientos: tdetalles;
    fallecimientos: tdetalles;
    regsN: tregistros;
    regsF: tregistros;

procedure leer(var det:Text;var id:integer);
begin
    if (eof (det)) then 
        id:=VALORALTO
    else 
        begin
            readln(det,id);
        end;
end;

procedure inicializarNacimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            assign(nacimientos[i],'detalles/nacimiento'+i.tostring()+'.txt');
            reset(nacimientos[i]);
        end;
end;

procedure inicializarFallecimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            assign(fallecimientos[i],'detalles/fallecimiento'+i.tostring()+'.txt');
            reset(fallecimientos[i]);
        end;
end;

procedure cerrarFallecimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        close(fallecimientos[i]);
end;
procedure cerrarNacimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        close(nacimientos[i]);
end;

procedure cargarNacimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            leer(nacimientos[i],regsN[i]);
        end;
end;

procedure cargarFallecimientos();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            leer(fallecimientos[i],regsF[i]);
        end;
end;

procedure minimo(var detalles:tdetalles;var registros:tregistros;var min:integer);
type 
    tminimo =  record 
        indice:integer;
        codigo:integer;
    end;
var 
    minimo:tminimo;
    i:integer;
begin
    minimo.codigo:=VALORALTO;
    minimo.indice:=1;
    for i:=1 to DIMF do 
        begin 
            if (registros[i]<minimo.codigo) then 
                begin 
                    minimo.codigo:=registros[i];
                    minimo.indice:=i;
                end;
        end;
    min:=registros[minimo.indice];
    leer(detalles[minimo.indice],registros[minimo.indice]);
end;

procedure crearMaestro();
var 
    actual,minN,minF:integer;    
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    rewrite(maestro);

    cargarFallecimientos();
    cargarNacimientos();
    minimo(fallecimientos,regsF,minF);
    minimo(nacimientos,regsN,minN);
    while (minN<>VALORALTO) do 
        begin

            while (minF<>minN) and (minF<minN) do 
                begin
                    minimo(fallecimientos,regsF,minF);
                end;

            if (minN=minF) then 
                begin 
                    writeln(maestro,minN,' fallecido');
                end 
            else
                writeln(maestro,minN);
                
            minimo(nacimientos,regsN,minN);
        end;
    close(maestro);
    writeln;
    writeln('Maestro creado con exito.');
end;

begin 
    inicializarFallecimientos();
    inicializarNacimientos();
    crearMaestro();
    cerrarFallecimientos();
    cerrarNacimientos();
end.
