program test;
type 
    tasistente = record 
        numero:integer;
        apellido:string[15];
        nombre:string[15];
        email:string[25];
        telefono:integer;
        dni:longint;
    end;

    tarchivo = file of tasistente;

procedure leerAsistente(var asistente:tasistente);
begin 
    writeln;
    write('Ingrese numero de asistente (-1 para terminar): ');
    readln(asistente.numero);
    if (asistente.numero<>-1) then 
        begin
            write('Ingrese apellido de asistente: ');
            readln(asistente.apellido);
            write('Ingrese nombre de asistente: ');
            readln(asistente.nombre);
            write('Ingrese email de asistente: ');
            readln(asistente.email);
            write('Ingrese telefono de asistente: ');
            readln(asistente.telefono);
            write('Ingrese dni de asistente: ');
            readln(asistente.dni);
        end;
end;

procedure escribirAsistente(asistente:tasistente);
begin 
    writeln(' Numero: ',asistente.numero,
            ' Apellido: ',asistente.apellido,
            ' Nombre: ',asistente.nombre,
            ' Email: ',asistente.email,
            ' Telefono: ',asistente.telefono,
            ' DNI: ',asistente.dni
            );
end;

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
    asistente: tasistente;
begin   
    Rewrite(archivo);
    writeln('Iniciando carga de asistentes...');
    leerAsistente(asistente);
    while (asistente.numero<>-1) do 
        begin   
            write(archivo,asistente);
            leerAsistente(asistente);
        end;
    close(archivo);
end;

function eliminado(asistente:tasistente):boolean;
begin 
    eliminado:=(pos('^',asistente.nombre)=1);
end;

procedure escribir(var archivo:tarchivo);
var 
    asistente:tasistente;
begin
    reset(archivo);
    writeln('Los asistentes guardados son:');
    while (not eof(archivo)) do 
        begin 
            read(archivo,asistente);
            if (not eliminado(asistente)) then
                escribirAsistente(asistente);
        end;
    close(archivo);
end;

procedure eliminar(var arch:tarchivo);
var 
    asistente:tasistente;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch,asistente);
            if (not eliminado(asistente)) and (asistente.numero<1000) then 
                asistente.nombre:=Concat('^',asistente.nombre);
            seek(arch,filepos(arch)-1);
            write(arch,asistente);
        end;
    close(arch);
end;


procedure runMenu(var arch:tarchivo);
var 
    opcion:integer;
begin 
    while (true) do 
        begin 
            writeln;
            writeln;
            writeln('Ingrese la operacion deseada: ');
            writeln('1 - Mostrar asistentes registrados. ');
            writeln('2 - Eliminar asistentes con numero menor a 1000.');
            writeln('3 - Finalizar el programa. ');
            write('--> ');
            readln(opcion);
            case opcion of
                1: escribir(arch);
                2: eliminar(arch);
                3: break;
            else 
                writeln('Operacion invalida.')
            end;
        end;
end;

var 
    arch: tarchivo;
begin 
    asignar(arch);
    cargar(arch);
    runMenu(arch);
end.