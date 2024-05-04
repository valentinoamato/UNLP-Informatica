program test;
type 
    tflor = record 
        codigo:integer;
        nombre:string[45];
    end;
    tarch = file of tflor;

var 
    arch:tarch;

procedure leerFlor(var flor:tflor);
begin 
    writeln;
    write('Ingrese codigo de flor (-1): ');
    readln(flor.codigo);
    if (flor.codigo<>-1) then 
        begin
            write('Ingrese nombre de flor: ');
            readln(flor.nombre);
        end;
end;

procedure escribirFlor(flor:tflor);
begin 
    writeln(' Codigo: ',flor.codigo,
            ' Nombre: ',flor.nombre
            );
end;

procedure cabecera();
var 
    flor:tflor;
begin 
    flor.codigo:= 0;
    rewrite(arch);
    write(arch,flor);
    close(arch);
end;

procedure cargar();
var 
    flor:tflor;
begin 
    writeln('Iniciando carga...');
    cabecera();
    reset(arch);
    seek(arch, 1);
    leerFlor(flor);
    while (flor.codigo<>-1) do 
        begin 
            write(arch,flor);
            leerFlor(flor);
        end;
    close(arch);
end;

procedure agregarAlFinal(flor:tflor);
begin 
    reset(arch);
    seek(arch,filesize(arch));
    write(arch,flor);
    close(arch);
end;


procedure agregar();
var 
    nuevo,aux:tflor;
    enlace:integer;
begin 
    reset(arch);
    leerFlor(nuevo);
    if (eof(arch)) then 
        begin
            cabecera();
            reset(arch);
            agregarAlFinal(nuevo);
        end
    else 
        begin 
            read(arch,aux);
            enlace:=aux.codigo;
            if (enlace=0) then 
                agregarAlFinal(nuevo)
            else 
                begin 
                    seek(arch,abs(enlace));
                    read(arch,aux);
                    seek(arch,abs(enlace));
                    write(arch,nuevo);
                    seek(arch,0);
                    write(arch,aux);
                end;
        end;
end;

procedure eliminar();
var 
    aux:tflor;
    i,j,codigo:integer;
    found:boolean;
begin 
    write('Ingrese el codigo de la flor a eliminar: ');
    readln(codigo);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.codigo=codigo) then 
                begin 
                    i:=filepos(arch)-1;
                    seek(arch,0);
                    read(arch,aux);
                    j:=aux.codigo;
                    aux.codigo:=i*-1;
                    seek(arch,0);
                    write(arch,aux);
                    seek(arch,i);
                    aux.codigo:=j;
                    write(arch,aux);
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('No se encontro la flor con codigo ',codigo,'.');
end;

procedure imprimir();
var 
    flor:tflor;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,flor);
            if (flor.codigo>0) then
                escribirFlor(flor);
        end;
    close(arch);
end;

procedure debug();
var 
    flor:tflor;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,flor);
            escribirFlor(flor);
        end;
    close(arch);
end;

procedure menu();
var 
    input:integer;
    ruta:string;
begin  
    write('Desea leer un archivo (1) o crear uno nuevo (2): ');
    readln(input);
    write('Ingrese la ruta del archivo: ');
    readln(ruta);
    assign(arch,ruta);
    if (input=2) then 
        cargar();

    while (true) do 
        begin 
            writeln;
            writeln;
            writeln('Ingrese la opcion deseada:');
            writeln('1 - Agregar Flor.');
            writeln('2 - Eliminar Flor.');
            writeln('3 - Imprimir Flores.');
            writeln('4 - Debug.');
            writeln('5 - Terminar Programa.');
            write('--> ');
            readln(input);
            case input of 
                1: agregar();
                2: eliminar();
                3: imprimir();
                4: debug;
                5: break;
                else writeln('Operacion Invalida.');
            end;
        end;
end;

begin
    menu();
end.