program ejercicio1;
const 
    cantMaterias=36;
type
    vectormaterias = array [1..cantMaterias] of integer;
    regalumno = record
        apellido:string;
        numero:integer;
        anno:integer;
        materias:vectormaterias;
    end;

    lista =^ nodo;
    nodo = record
        sig:lista;
        dato:regalumno;
    end;

procedure leerMaterias (var v:vectormaterias);
var 
    i:integer;
begin 
    for i:=1 to cantMaterias do
        begin
            writeln('Ingrese nota de materia numero ',i,':');
            readln(v[i]);
        end;
end;

procedure leerAlumno (var alumno:regalumno);
begin
    writeln('Ingrese numero del alumno:');
    readln(alumno.numero);
    writeln('Ingrese apellido del alumno:');
    readln(alumno.apellido);
    writeln('Ingrese anno de ingreso del alumno:');
    readln(alumno.anno);
    leerMaterias(alumno.materias)
end;

procedure agregar(var pri:lista;dato:regalumno);
var 
    aux:lista;
begin 
    new(aux);
    aux^.dato:=dato;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure cargar(var pri:lista);
var
    alumno:regalumno;
begin
    repeat
        leerAlumno(alumno);
        agregar(pri,alumno);
    until (alumno.numero=11111);
end;

function promedioAlumno(alumno:regalumno):real;
var 
    i:integer;
    notaTotal:integer;
begin
    notaTotal:=0;
    for i:=1 to cantMaterias do
        notaTotal:=notaTotal+alumno.materias[i];
    promedioAlumno:=notaTotal/cantMaterias;
end;

procedure promediosAlumnos(pri:lista);
begin 
    while (pri<>nil) do
        begin 
            writeln('El alumno numero ',pri^.dato.numero,' tiene un promedio de ',promedioAlumno(pri^.dato),'.');
            pri:=pri^.sig;
        end;
end;

var 
    pri:lista;
begin
    pri:=nil;
    cargar(pri);
    promediosAlumnos(pri);
end.