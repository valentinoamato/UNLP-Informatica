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

function existe(var arch:tarchivo; numero:integer):boolean;
var 
    flag: boolean;
    empleado: templeado;
begin 
    reset(arch);
    flag:=False;
    while (not eof(arch)) do 
        begin 
            read(arch, empleado);
            if (empleado.numero = numero) then 
                begin
                    flag:=True;
                    break;
                end;
        end;
    existe:=flag;
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

procedure agregar(var arch:tarchivo);
var 
    empleado: templeado;
    opcion: string;
begin
    reset(arch);
    seek(arch, filesize(arch));
    leerEmpleado(empleado);
    while (empleado.apellido<>'fin') do 
        begin 
            if (existe(arch,empleado.numero)) then 
                writeln('El empleado ingresado ya existe.')
            else  
                write(arch, empleado);   
            writeln;
            write('Desea ingresar otro empleado [s/n]?');
            readln(opcion);
            if (opcion = 'n') then 
                break
            else 
                leerEmpleado(empleado);
        end;
    close(arch);
end;

procedure modificarEdad(var arch:tarchivo);
var
    edad, numero:integer;
    empleado: templeado;
    found: boolean;
begin   
    reset(arch);
    found:=False;
    write('Ingrese el numero de empleado: ');
    readln(numero);
    while (not eof(arch)) do 
        begin 
            read(arch, empleado);
            if (empleado.numero = numero) then 
                begin 
                    found:=True;
                    break;
                end;
        end;
    if (found) then
        begin
            write('Ingrese la nueva edad:');
            readln(edad);
            seek(arch, filepos(arch)-1);
            empleado.edad:=edad;
            write(arch, empleado);
        end
    else 
        begin
            writeln;
            writeln('No existe el empleado numero ',numero,'.');
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

procedure exportar(var arch:tarchivo);
var
    txt: Text;
    empleado: templeado;
begin 
    Assign(txt, 'todos_empleados.txt');
    reset(arch);
    Rewrite(txt);
    while (not eof(arch)) do 
        begin 
            read(arch, empleado);
            writeln(txt,
            ' ',empleado.numero,
            ' ',empleado.apellido,
            ' ',empleado.nombre,
            ' ',empleado.edad,
            ' ',empleado.dni
            );
        end;
    close(arch);
    close(txt);
end;

procedure exportarNoDNI(var arch:tarchivo);
var
    txt: Text;
    empleado: templeado;
begin 
    Assign(txt, 'faltaDNIEmpleado.txt');
    reset(arch);
    Rewrite(txt);
    while (not eof(arch)) do 
        begin 
            read(arch, empleado);
            if (empleado.dni = 0) then 
                writeln(txt,
                ' ',empleado.numero,
                ' ',empleado.apellido,
                ' ',empleado.nombre,
                ' ',empleado.edad,
                ' ',empleado.dni
                );
        end;
    close(arch);
    close(txt);
end;

procedure eliminar(var arch:tarchivo);
var 
    numero:integer;
    empleado:templeado;
    found:boolean;
    aux:integer;
begin 
    reset(arch);
    found:=False;
    write('Ingrese el numero del empleado a eliminar: ');
    readln(numero);
    while (not eof(arch)) and (not found) do 
        begin   
            read(arch, empleado);
            if (empleado.numero = numero) then 
                found:=True;
        end; 
    if (not found) then 
        writeln('No se pudo encontrar un empleado con numero ',numero,'.')
    else 
        begin 
            aux:=filepos(arch)-1;
            seek(arch,filesize(arch)-1);
            read(arch, empleado);
            seek(arch,aux);
            write(arch, empleado);
            seek(arch,filesize(arch)-1);
            truncate(arch);
        end;
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
            writeln('2 - Agregar empleados.');
            writeln('3 - Modificar edad de empleado.');
            writeln('4 - Mostrar empleados registrados. ');
            writeln('5 - Mostrar empleados mayores a 70 annos.');
            writeln('6 - Exportar informacion de empleados.');
            writeln('7 - Exportar informacion de empleados sin DNI.');
            writeln('8 - Eliminar empleado.');
            writeln('9 - Finalizar el programa. ');
            write('--> ');
            readln(opcion);
            case opcion of
                1: buscar(arch);
                2: agregar(arch);
                3: modificarEdad(arch);
                4: escribir(arch);
                5: mostrarMayores(arch);
                6: exportar(arch);
                7: exportarNoDNI(arch);
                8: eliminar(arch);
                9: break;
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