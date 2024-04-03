program test;
//ADVERTENCIA: ESTA RESOLUCION ES UN ASCO, SE RECOMIENDA DISCRECION 

Uses sysutils;
const 
    valoralto = 9999;
type 
    talumno =  record 
        codigo:integer;
        nombre:string[25];
        cursadas:integer;
        finales:integer;
    end;

    tdetalle = record 
        codigo:integer;
        dato:string;
    end;

    tarch = file of talumno;

procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.codigo:=valoralto
    else 
        readln(det,regd.codigo,regd.dato);
end;

procedure imprimirAlumno(a:talumno);
begin 
    writeln('Codigo: ',a.codigo,' Nombre: ',a.nombre,' Cursadas: ',a.cursadas,' Finales: ',a.finales);
end;

procedure imprimirBin(var arch:tarch);
var 
    alumno:talumno;
begin 
    assign(arch,'maestro.dat');
    reset(arch);
    writeln;
    writeln('Los alumnos en el archivo maestro son:');
    while (not eof(arch)) do
        begin
            read(arch,alumno);
            imprimirAlumno(alumno);
        end;
    close(arch);
end;


procedure textToBin(var txt:Text;var bin:tarch);
var 
    reg:talumno;
begin 
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,reg.codigo,reg.cursadas,reg.finales,reg.nombre);
            reg.nombre:=trim(reg.nombre);
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure actualizar(regd:tdetalle;var cursadas,finales:integer);
begin 
    if (Trim(regd.dato)='cursada') then 
        cursadas:=cursadas+1
    else if (Trim(regd.dato)='final') then 
        begin 
            finales:=finales+1;
        end;
end;

procedure actualizar(var bin:tarch;var detalle:Text);
var 
    regm:talumno;
    regd:tdetalle;
    cursadas,finales,codigo:integer;
begin 
    reset(detalle);
    reset(bin);

    leer(detalle,regd);
    read(bin,regm);
    while (regd.codigo<>valoralto) do 
        begin
            codigo:=regd.codigo;
            cursadas:=0;
            finales:=0;

            while (codigo=regd.codigo) do 
                begin 
                    actualizar(regd,cursadas,finales);
                    leer(detalle,regd);
                end;
            while (regm.codigo<>codigo) do 
                read(bin,regm);
            regm.cursadas:=regm.cursadas+cursadas-finales;
            regm.finales:=regm.finales+finales;
            seek(bin,filepos(bin)-1);
            write(bin,regm); 
            if (not eof(bin)) then 
                read(bin, regm);
        end;
    close(detalle);
    close(bin);
    writeln;
    writeln('Actualizacion realizada con exito.');
end;

procedure listar(var bin:tarch);
var 
    txt:Text;
    a:talumno;
begin 
    assign(txt,'listado.txt');
    rewrite(txt);
    reset(bin);
    while (not eof(bin)) do 
        begin 
            read(bin,a);
            if (a.finales>a.cursadas) then 
                writeln(txt,a.codigo,' ',a.cursadas,' ',a.finales,' ',trim(a.nombre));
        end;
    writeln('Los alumnos con mas finales que cursadas aprobadas han sido listados en listado.txt');
    close(txt);
    close(bin);
end;

procedure runMenu();
var 
    detalle,maestro:Text;
    bin:tarch;
    opcion:string;
begin 
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    assign(detalle,'detalle.txt');
    assign(bin,'maestro.dat');

    while (True) do     
        begin 
            writeln;
            writeln;
            writeln('Ingrese la operacion deseada:');
            writeln('1 - Imprimir alumnos.');
            writeln('2 - Actualizar datos.');
            writeln('3 - Listar alumnos con mas finales que cursadas aprobadas.');
            writeln('4 - Finalizar programa.');
            write('--> ');
            readln(opcion);
            case opcion of 
                '1': imprimirBin(bin);
                '2': actualizar(bin,detalle);
                '3': listar(bin);
                '4': break;
            else 
                writeln('La operacion ingresada es invalida.');
            end;
        end;
end;

begin 
    runMenu();
end.