program test;
uses sysutils;
type 
    tave = record 
        codigo:integer;
        nombre:string[20];
        familia:string[40];
        descripcion:string[50];
        zona:string[15];
    end;

    tarch = file of tave;
var 
    arch:tarch;

procedure leerAve(var ave:tave);
begin   
    write('Ingrese codigo (-1): ');
    readln(ave.codigo);
    if (ave.codigo<>-1) then 
        begin 
            write('Ingrese nombre: ');
            readln(ave.nombre);
            write('Ingrese familia: ');
            readln(ave.familia);
            write('Ingrese descripcion: ');
            readln(ave.descripcion);
            write('Ingrese zona: ');
            readln(ave.zona);
        end;
end;

procedure escribirAve(ave:tave);
begin 
    writeln('Codigo: ',
            ave.codigo,
            ' Nombre: ',
            ave.nombre,
            ' Familia: ',
            ave.familia,
            ' Descripcion: ',
            ave.descripcion,
            ' Zona: ',
            ave.zona);
end;

procedure cargar();
var 
    ave:tave;
begin 
    writeln('Iniciando carga...');
    leerAve(ave);
    rewrite(arch);
    while (ave.codigo<>-1) do 
        begin
            writeln;
            write(arch, ave);
            leerAve(ave);
        end;
    close(arch);
end;

procedure imprimir(debug:boolean);
var 
    ave:tave;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin
            read(arch, ave);
            if (debug) or (ave.codigo>=0) then 
                escribirAve(ave);
        end;
    close(arch);
end;

procedure eliminar(codigo:integer);
var 
    ave:tave;
    found:boolean;
begin 
    found:=false;
    reset(arch);
    while (not eof(arch)) and (not found) do 
        begin
            read(arch, ave);
            if (ave.codigo=codigo) then 
                begin 
                    ave.codigo:=-1;
                    seek(arch,filepos(arch)-1);
                    write(arch,ave);
                    found:=True;
                end; 
        end;
    if (not found) then 
        writeln('No se encontro el ave con codigo ',codigo,'.');
    close(arch);
end;

procedure eliminar();
var 
    codigo:integer;
begin 
    write('Ingrese el codigo del ave a eliminar: ');
    readln(codigo);
    eliminar(codigo);
end;

procedure agregar();
var 
    ave:tave;
begin 
    reset(arch);
    writeln;
    leerAve(ave);
    seek(arch,filesize(arch));
    write(arch,ave);
    close(arch);
end;

procedure compactar();
var 
    aveA,aveB:tave;
    a,b:integer;
    found:boolean;
begin 
    reset(arch);
    if (eof(arch)) then 
        exit;    
    a:=0;
    b:=filesize(arch)-1;
    found:=True;
    while (a<b) and (found) do 
        begin 
            seek(arch,a);
            read(arch,aveA);
            a:=a+1;
            if (aveA.codigo=-1) then 
                begin 
                    found:=False;
                    seek(arch,b);
                    read(arch,aveB);
                    b:=b-1;
                    while (aveB.codigo=-1) do 
                        begin 
                            seek(arch,b);
                            read(arch,aveB);
                            b:=b-1;
                        end;
                    if (aveB.codigo<>-1) and (a-1<=b) then 
                        begin 
                            seek(arch,a-1);
                            write(arch,aveB);
                            seek(arch,b+1);
                            write(arch,aveA);
                            found:=True;
                        end 
                    else 
                        a:=a-1;
                end;
        end;
    seek(arch,a);
    read(arch,aveA);
    if (aveA.codigo<>-1) then 
        a:=a+1;
    seek(arch,a);
    truncate(arch);
    close(arch);
end;

procedure menu();
var 
    opcion:integer;
    ruta:string;
begin 
    write('Desea abrir un archivo(1) o crear uno nuevo(2): ');
    readln(opcion);
    write('Ingrese la ruta del archivo: ');
    readln(ruta);
    assign(arch, ruta);
    if (opcion=2) then 
        cargar();
    
    writeln;
    writeln;
    while (True) do 
        begin 
            writeln;
            writeln('Ingrese la opcion deseada: ');
            writeln(' 1 - Imprimir Aves. ');
            writeln(' 2 - Agregar Ave. ');
            writeln(' 3 - Eliminar Ave. ');
            writeln(' 4 - Compactar Archivo. ');
            writeln(' 5 - Debug. ');
            writeln(' 6 - Terminar Programa. ');
            write(' --> ');
            read(opcion);
            case opcion of 
                1: imprimir(False);
                2: agregar();
                3: eliminar();
                4: compactar();
                5: imprimir(True);
                6: break;
                else writeln('Operacion Invalida.');
            end;
        end;
end;

begin 
    menu();
end.