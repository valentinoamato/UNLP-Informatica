program test;

var
    nombre:string;
    nota:real;
    alu7,alu8:integer;

begin
    alu7:=0;
    alu8:=0;

    repeat
        writeln('ingrese nombre: ');
        readln(nombre);
        writeln('ingrese nota: ');
        readln(nota);
        if (nota=7) then
            alu7:=alu7+1
        else if (nota>=8) then
            alu8:=alu8+1;
    until (nombre='Carlos Pepe');
    write('Alumnos con nota 7:',alu7);
    write('Alumnos con nota 8 o mas:',alu8);
end.