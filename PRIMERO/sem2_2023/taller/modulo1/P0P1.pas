// TALLER DE PROGRAMACIÓN – Módulo Imperativo 2023
// 1
// Módulo Imperativo
// Práctica Inicial
// 1.- Implementar un programa que procese la información de los alumnos de la Facultad de
// Informática.
// a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
// todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
// cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
// una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
// -1, el cual debe procesarse.
// b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
// de alumno y promedio de cada alumno.
// c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
// materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
// puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?
program test;
const
    dimf=3; //36-->5
type
    vectormaterias = array[1..dimF] of integer;
    regdato = record
        nombre:string;
        numero:integer;
        anno:integer;
        materias:vectormaterias;
    end;

    lista=^nodo;
    nodo = record
        sig:lista;
        dato:regdato;
    end;

procedure leervector(var v:vectormaterias);
var
    i,n:integer;
begin
    for i:=1 to dimf do
        begin
            writeln('Ingrese nota para materia ',i,': ');
            readln(n);
            v[i]:=n;
        end;
end;

procedure leeralumno (var alumno:regdato);
begin
    writeln('Ingrese nombre de alumno: ');
    readln(alumno.nombre);
    writeln('Ingrese numero de alumno: ');
    readln(alumno.numero);
    writeln('Ingrese anno de alumno: ');
    readln(alumno.anno);
    leervector(alumno.materias);
end;

procedure agregar(var pri:lista;datos:regdato);
var
    aux:lista;
begin
    new(aux);
    aux^.dato:=datos;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure cargar(var pri:lista);
var
    alumno:regdato;
begin
    repeat
        leeralumno(alumno);
        agregar(pri,alumno);
    until (alumno.numero=-1);
end;

procedure imprimir(pri:lista);
begin
    while (pri<>nil) do
        begin
            writeln('Nombre: ',pri^.dato.nombre);
            writeln('Nombre: ',pri^.dato.numero);
            writeln('Nombre: ',pri^.dato.anno);
            pri:=pri^.sig;
        end;
end;

function promedio(v:vectormaterias):real;
var
    sum,i:integer;
begin
    sum:=0;
    for i:=1 to dimf do
        sum:=sum+v[i];
    promedio:=sum/dimf;
end;

procedure modulob(pri:lista);
begin
    while (pri<>nil) do
        begin
            writeln('El alumno ',pri^.dato.numero,' tiene un promedio de ',promedio(pri^.dato.materias));
            pri:=pri^.sig;
        end;
end;

var
    pri:lista;
begin
    pri:=nil;
    cargar(pri);
    imprimir(pri);
    modulob(pri);
end.