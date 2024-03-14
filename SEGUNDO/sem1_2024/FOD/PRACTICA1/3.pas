program test;
type 
    templeado = record 
        numero:integer;
        apellido:string[15];
        nombre:string[15];
        edad:integer;
        dni:longint;
    end;

    tarchivo = file of templeado;

procedure leerEmpleado(var empleado:templeado);
begin 
    writeln;
    write('Ingrese numero de empleado: ');
    readln(empleado.numero);
    write('Ingrese apellido de empleado: ');
    readln(empleado.apellido);
    if (empleado.apellido<>'fin') then 
        begin
            write('Ingrese nombre de empleado: ');
            readln(empleado.nombre);
            write('Ingrese edad de empleado: ');
            readln(empleado.edad);
            write('Ingrese dni de empleado: ');
            readln(empleado.dni);
        end;
end;

procedure escribirEmpleado(empleado:templeado);
begin 
    writeln(' Numero: ',empleado.numero,
            ' Apellido: ',empleado.apellido,
            ' Nombre: ',empleado.nombre,
            ' Edad: ',empleado.edad,
            ' DNI: ',empleado.dni
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
    empleado: templeado;
begin   
    Rewrite(archivo);
    writeln('Iniciando carga de empleados...');
    leerEmpleado(empleado);
    while (empleado.apellido<>'fin') do 
        begin   
            write(archivo,empleado);
            leerEmpleado(empleado);
        end;
    close(archivo);
end;

procedure buscar(var arch:tarchivo);
var 
    id:string[15];
    empleado:templeado;
begin 
    reset(arch);
    write('Ingrese el nombre/apellido a buscar: ');
    readln(id);
    writeln;
    writeln('Se encontraron las siguientes coincidencias: ');
    while (not eof(arch)) do 
        begin 
            read(arch,empleado);
            if (empleado.nombre = id) or (empleado.apellido = id) then 
                escribirEmpleado(empleado);
        end;
    close(arch);
end;

procedure escribir(var archivo:tarchivo);
var 
    empleado:templeado;
begin
    reset(archivo);
    writeln('Los empleados guardados son:');
    while (not eof(archivo)) do 
        begin 
            read(archivo,empleado);
            escribirEmpleado(empleado);
        end;
    close(archivo);
end;

procedure mostrarMayores(var arch:tarchivo);
var 
    empleado:templeado;
begin 
    reset(arch);
    writeln;
    writeln('Se encontraron empleados mayores a 70 annos: ');
    while (not eof(arch)) do 
        begin 
            read(arch,empleado);
            if (empleado.edad > 70) then 
                escribirEmpleado(empleado);
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
            writeln('1 - Buscar empleado. ');
            writeln('2 - Mostrar empleados registrados. ');
            writeln('3 - Mostrar empleados mayores a 70 annos.');
            writeln('4 - Finalizar el programa. ');
            write('--> ');
            readln(opcion);
            case opcion of
                1: buscar(arch);
                2: escribir(arch);
                3: mostrarMayores(arch);
                4: break
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