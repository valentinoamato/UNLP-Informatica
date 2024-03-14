program test;
type 
    tarchivo = file of integer;

procedure asignar(var archivo:tarchivo);
var
    ruta:string;
begin
    write('Ingrese la ruta del archivo a crear:');
    readln(ruta);
    Assign(archivo, ruta);
end;

procedure cargar(var archivo:tarchivo);
var
    numero: integer;
begin   
    Rewrite(archivo);
    write('Ingrese un numero entero (3000 para finalizar):');
    readln(numero);
    while (numero<>3000) do 
        begin   
            write(archivo,numero);
            write('Ingrese un numero entero:');
            readln(numero);
        end;
    close(archivo);
end;

procedure leer(var archivo:tarchivo);
var 
    numero:integer;
begin
    reset(archivo);
    writeln('Los numeros guardados son:');
    while (not eof(archivo)) do 
        begin 
            read(archivo,numero);
            writeln(numero);
        end;
end;

var 
    arch: tarchivo;
begin 
    asignar(arch);
    cargar(arch);
    leer(arch);
end.