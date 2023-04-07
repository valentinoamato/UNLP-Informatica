program test;

var
    legajo,alumnos,alumnos2,alumnos3:integer;
    promedio,porcentaje,pct:real;

begin
    alumnos:=0;
    alumnos2:=0;
    alumnos3:=0;
    write('ingrese legajo: ');
    read(legajo);
    write('ingrese promedio: ');
    read(promedio);
    while (legajo<>-1) do
        begin
            alumnos:=alumnos+1;
            if (promedio>8.5) and (legajo<2500) then
                alumnos3:=alumnos3+1;
            if (promedio>6.5) then
                alumnos2:=alumnos2+1;
            write('ingrese legajo: ');
            read(legajo);
            write('ingrese promedio: ');
            read(promedio);
        end;
    writeln('Se ingresaron ',alumnos,' alumnos.');
    writeln('Hay ',alumnos2,' alumnos con promedio mayor a 6.5');
    writeln(alumnos3);
    writeln(alumnos3/2);
    writeln(alumnos3 DIV 2);
    writeln(alumnos3 * 2);
    writeln(alumnos);
    porcentaje:=(alumnos3 / alumnos)*100;
    write('Hay un ');
    write(porcentaje:0:2);
    write('% de alumnos con promedio mayor a 8.5 y legajo menor a 2500');
    writeln('Hay un ',pct,'% de alumnos con promedio mayor a 8.5 y legajo menor a 2500');


end.