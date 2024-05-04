program test;
uses sysutils;
type 
    tprenda = record 
        codigo:integer;
        descripcion:string[50];
        colores:string[40];
        tipo:string[20];
        stock:integer;
        precio:real;
    end;

    tarch = file of tprenda;
    tbajas = file of integer;
var 
    arch:tarch;
    bajas:tbajas;
    nombreArch:string;

procedure leerPrenda(var prenda:tprenda);
begin   
    write('Ingrese codigo (-1): ');
    readln(prenda.codigo);
    if (prenda.codigo<>-1) then 
        begin 
            write('Ingrese descripcion: ');
            readln(prenda.descripcion);
            write('Ingrese colores: ');
            readln(prenda.colores);
            write('Ingrese tipo: ');
            readln(prenda.tipo);
            write('Ingrese stock: ');
            readln(prenda.stock);
            write('Ingrese precio: ');
            readln(prenda.precio);
        end;
end;

procedure escribirPrenda(prenda:tprenda);
begin 
    writeln('Codigo: ',
            prenda.codigo,
            ' Descripcion: ',
            prenda.descripcion,
            ' Colores: ',
            prenda.colores,
            ' Tipo: ',
            prenda.tipo,
            ' Stock: ',
            prenda.stock,
            ' Precio: ',
            prenda.precio:0:2);
end;

procedure cargar();
var 
    prenda:tprenda;
begin 
    writeln('Iniciando carga...');
    leerPrenda(prenda);
    rewrite(arch);
    while (prenda.codigo<>-1) do 
        begin
            writeln;
            write(arch, prenda);
            leerPrenda(prenda);
        end;
    close(arch);
end;

procedure cargarBajas();
var 
    codigo:integer;
begin 
    writeln;
    writeln('Iniciando carga...');
    write('Ingrese un codigo (-1): ');
    readln(codigo);
    rewrite(bajas);
    while (codigo<>-1) do 
        begin
            write(bajas,codigo);
            write('Ingrese un codigo: ');
            readln(codigo);
        end;
    close(bajas);
end;

procedure imprimir(debug:boolean);
var 
    prenda:tprenda;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin
            read(arch, prenda);
            if (debug) or (prenda.stock>=0) then 
                escribirPrenda(prenda);
        end;
    close(arch);
end;

procedure imprimirBajas();
var
    codigo:integer;
begin 
    writeln('Los codigos de las prendas obsoletas son: ');
    reset(bajas);
    while (not eof(bajas)) do 
        begin 
            read(bajas,codigo);
            writeln('  - ',codigo);
        end;
    close(bajas);
end;

procedure bajaLogica(codigo:integer);
var 
    prenda:tprenda;
    found:boolean;
begin 
    found:=false;
    reset(arch);
    while (not eof(arch)) and (not found) do 
        begin
            read(arch, prenda);
            if (prenda.codigo=codigo) then 
                begin 
                    prenda.stock:=-1;
                    seek(arch,filepos(arch)-1);
                    write(arch,prenda);
                end; 
        end;
    close(arch);
end;

procedure aplicarBajas();
var 
    codigo:integer;
begin 
    reset(bajas);
    while (not eof(bajas)) do 
        begin 
            read(bajas,codigo);
            bajaLogica(codigo);
        end;
    close(bajas);
end;

procedure bajaFisica();
var 
    nuevo:tarch;
    prenda:tprenda;
begin 
    assign(nuevo,'nuevo.dat');
    rewrite(nuevo);
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch,prenda);
            if (prenda.stock>=0) then 
                write(nuevo,prenda);
        end;
    close(arch);
    erase(arch);
    renameFile('nuevo.dat',nombreArch);
    assign(arch, nombreArch);
    close(nuevo);
end;

procedure menu();
var 
    opcion:integer;
begin 
    write('Desea abrir un archivo(1) o crear uno nuevo(2): ');
    readln(opcion);
    write('Ingrese la ruta del archivo: ');
    readln(nombreArch);
    assign(arch, nombreArch);
    assign(bajas,'bajas.dat');
    if (opcion=2) then 
        cargar();
    
    writeln;
    writeln;
    while (True) do 
        begin 
            writeln;
            writeln('Ingrese la opcion deseada: ');
            writeln(' 1 - Cargar Prendas Obsoletas. ');
            writeln(' 2 - Imprimir Prendas Obsoletas. ');
            writeln(' 3 - Baja Logica. ');
            writeln(' 4 - Baja Fisica. ');
            writeln(' 5 - Imprimir Prendas. ');
            writeln(' 6 - Debug. ');
            writeln(' 7 - Terminar Programa. ');
            write(' --> ');
            read(opcion);
            case opcion of 
                1: cargarBajas();
                2: imprimirBajas();
                3: aplicarBajas();
                4: bajaFisica();
                5: imprimir(false);
                6: imprimir(true);
                7: break;
                else writeln('Operacion Invalida.');
            end;
        end;
end;

begin 
    menu();
end.