//Archivo maestro con codigo y nombre
//Altas y bajas usando lista invertida con enlaces mediante codigo
program apuntes;
type 
    tregistro = record 
        codigo:integer;
        nombre:string;
    end;

    tarch = file of tregistro;

procedure imprimirMaestro(var maestro:tarch);
var 
    reg:tregistro;
begin 
    reset(maestro);
    while (not eof(maestro)) do     
        begin 
            read(maestro,reg);
            if (reg.codigo>0) then 
                writeln('Codigo: ',reg.codigo,', Nombre: ',reg.nombre,'.');
        end;
    close(maestro);
end;

procedure imprimirMaestroDebug(var maestro:tarch);
var 
    reg:tregistro;
begin 
    reset(maestro);
    while (not eof(maestro)) do     
        begin 
            read(maestro,reg);
            writeln('Codigo: ',reg.codigo,', Nombre: ',reg.nombre,'.');
        end;
    close(maestro);
end;

procedure crearMaestro(var maestro:tarch;ruta:string);
var 
    reg:tregistro;
begin 
    assign(maestro,ruta);
    rewrite(maestro);
    reg.codigo:=0;
    write(maestro,reg);
    close(maestro);
end;

procedure agregar(var maestro:tarch;nombre:string;codigo:integer);
var 
    reg,cabecera,nuevo:tregistro;
begin 
    nuevo.codigo:=codigo;
    nuevo.nombre:=nombre;
    reset(maestro);
    read(maestro,cabecera);
    if (cabecera.codigo=0) then 
        begin 
            seek(maestro,filesize(maestro));
            write(maestro,nuevo);
        end
    else 
        begin 
            seek(maestro,abs(cabecera.codigo));
            read(maestro,reg);
            seek(maestro,abs(cabecera.codigo));
            write(maestro,nuevo);
            seek(maestro,0);
            write(maestro,reg);
        end;
    close(maestro);
end;

procedure eliminar(var maestro:tarch;codigo:integer);
var 
    cabecera,reg:tregistro;
    borrado:integer;
    found:boolean;
begin 
    found:=false;
    reset(maestro);
    read(maestro,cabecera);
    while (not eof(maestro)) and (not found) do 
        begin 
            read(maestro,reg);
            if (reg.codigo=codigo) then 
                found:=true;
        end;
    if (not found) then 
        writeln('El registro con codigo ',codigo,' no existe.')
    else 
        begin 
            borrado:=filepos(maestro)-1;
            seek(maestro,borrado);
            write(maestro,cabecera);
            reg.codigo:=borrado*-1;
            seek(maestro,0);
            write(maestro,reg);
        end;
    close(maestro);
end;

var 
    maestro:tarch;
begin 
    crearMaestro(maestro,'maestro.dat');
    agregar(maestro,'nombre1',1);
    agregar(maestro,'nombre2',2);
    agregar(maestro,'nombre3',3);
    agregar(maestro,'nombre4',4);
    agregar(maestro,'nombre5',5);
    agregar(maestro,'nombre6',6);
    writeln;
    writeln('Maestro antes de eliminar: ');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro antes de eliminar (con ocultos): ');
    imprimirMaestroDebug(maestro);
    eliminar(maestro,2);
    eliminar(maestro,3);
    eliminar(maestro,6);
    eliminar(maestro,8);
    writeln;
    writeln('Maestro despues de eliminar: ');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro despues de eliminar (con ocultos): ');
    imprimirMaestroDebug(maestro);
    agregar(maestro,'nombre10',10);
    agregar(maestro,'nombre20',20);
    agregar(maestro,'nombre30',30);
    agregar(maestro,'nombre40',40);
    writeln;
    writeln('Maestro despues de agregar: ');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro despues de agregar (con ocultos): ');
    imprimirMaestroDebug(maestro);
end.
