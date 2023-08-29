program Registros;
type
    str20 = string[20];
    alumno = record
        codigo : integer;
        nombre : str20;
        promedio : real;
    end;
procedure leer(var alu : alumno);
begin
    writeln('Ingrese el código del alumno');
    readln(alu.codigo);
    if (alu.codigo <> 0) then begin
        writeln('Ingrese el nombre del alumno'); readln(alu.nombre);
        writeln('Ingrese el promedio del alumno'); readln(alu.promedio);
end;
end;
{ declaración de variables del programa principal }
var
    a : alumno;
    n:integer;
    mejorpromedio:real;
    nombre:string;
{ cuerpo del programa principal }
begin
    mejorpromedio:=-999;
    nombre:='';
    n:=0;
    leer(a);
    while (a.codigo <> 0) do 
        begin
            n:=n+1;
            if (a.promedio > mejorpromedio) then
            begin               //meter en proceso
                    mejorpromedio:=a.promedio;
                    nombre:=a.nombre;
            end;
            leer(a);
        end;
    write(n);
    write('el mejor promedio es:',nombre);

end.