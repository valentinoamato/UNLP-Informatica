{REDICTADO DE CADP 2022-PARCIAL (1RA FECHA) 8/11
TEMA 2
Una empresa de la ciudad de La Plata necesita un programa para administrar la información de
sus empleados. De cada empleado se lee: DNI, apellido y nombre, condición (permanente o
temporal), área de desempeño (1: directiva, 2: administrativa, 3: productiva, 4: contable) y
años de antigüedad. La lectura finaliza cuando se ingresa el empleado con DNI 33444555, que
debe procesarse. Se pide:
A) Informar la cantidad de empleados permanentes de cada área.
B) Informar los DNI de los dos empleados de menor antigüedad del área administrativa.
c) Generar una estructura adecuada, ordenada por apellido y nombre de manera
ascendente, con aquellos empleados temporales que poseen su DNI compuesto por la
misma cantidad de dígitos pares que impares.}
program test;
type
    subarea=1..4;
    regempleado = record
        dni:integer;
        nombre:string;
        condicion:string;
        area:subarea;
        antiguedad:integer;
    end;
    lista=^nodo;
    nodo=record
        dato:regempleado;
        sig:lista;
    end;
    vector=array[subarea] of integer;

procedure escribir (pri:lista);
begin
    while (pri<>nil)do
        begin
            writeln('||||||');
            writeln('dni: ',pri^.dato.dni);
            writeln('nombre: ',pri^.dato.nombre);
            writeln('condicion: ',pri^.dato.condicion);
            writeln('area: ',pri^.dato.area);
            writeln('antiguedad: ',pri^.dato.antiguedad);
            writeln('||||||');
            pri:=pri^.sig;
        end;
end;

procedure insertar (var pri:lista;reg:regempleado);
var
    actual,anterior,nuevo:lista;
begin
    actual:=pri;
    anterior:=nil;
    new(nuevo);
    nuevo^.dato:=reg;
    while (actual<>nil) and (actual^.dato.nombre<reg.nombre) do
        begin
            anterior:=actual;
            actual:=actual^.sig;
        end;

    if (anterior<>nil) then
        begin
            anterior^.sig:=nuevo;
            nuevo^.sig:=actual;
        end
    else
        begin
            nuevo^.sig:=pri;
            pri:=nuevo;
        end;
end;


procedure leer(var reg:regempleado);
begin
    writeln('Ingrese dni: ');
    readln(reg.dni);
    writeln('Ingrese nombre: ');
    readln(reg.nombre);
    writeln('Ingrese condicion (permanente o temporal): ');
    readln(reg.condicion);
    writeln('Ingrese area (1-4): ');
    readln(reg.area);
    writeln('Ingrese antiguedad: ');
    readln(reg.antiguedad);
end;

function dni(num:integer):boolean;
var
    p:integer;
begin
    p:=0;
    while (num<>0) do
        begin
            if (num mod 10 mod 2=0) then
                p:=p+1
            else
                p:=p-1;
            num:=(num div 10);
        end;
    dni:=(p=0);
end;


procedure main(var pri:lista);
var
    reg:regempleado;
    permanentes:vector;
    min1,min2:regempleado;
    i:integer;
begin
    min1.antiguedad:=100;
    min2.antiguedad:=100;
    for i:=1 to 4 do
        permanentes[i]:=0;
    repeat
        leer(reg);
        if (reg.condicion='permanente') then {a}
            permanentes[reg.area]:=permanentes[reg.area]+1;

        if (reg.area=2) then {b}
            begin
                if (reg.antiguedad<min1.antiguedad) then
                    begin
                        min2:=min1;
                        min1:=reg;
                    end
                else
                    begin
                        if (reg.antiguedad<min2.antiguedad) then
                            min2:=reg;
                    end;
            end;
        if (reg.condicion='temporal') and (dni(reg.dni)) then {c}
            insertar(pri,reg);

    until (reg.dni=0);
    
    for i:=1 to 4 do {a}
        writeln('Hay ',permanentes[i],' empleados permanentes en el area',i);
        
    writeln('Los DNIs de los empleados con menor antiguedad de el area administrativa son: ',min1.dni,', ',min2.dni); {b}
end;

var
    pri:lista;

begin
    pri:=nil;
    main(pri);
    escribir(pri);
end.
