//El maestro tiene registros con codigo y nombre.
//Se realizan bajas logicas agregando una arroba adelante del nombre.
//Comprimir el archivo usando rename.
program apunte;
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
            writeln('Codigo: ',reg.codigo,', Nombre: ',reg.nombre,'.');
        end;
    close(maestro);
end;

procedure comprimirConRename(var maestro:tarch;nombreArch:string);
var 
    nuevo:tarch;
    reg:tregistro;
begin 
    assign(nuevo,'nuevo.dat');
    rewrite(nuevo);
    reset(maestro);
    while (not eof(maestro)) do 
        begin 
            read(maestro,reg);
            if (pos('@',reg.nombre)=0) then 
                write(nuevo,reg);
        end;
    close(maestro);
    erase(maestro);
    close(nuevo);
    rename(nuevo,nombreArch); //Necesita que nuevo este cerrado pero asignado
    assign(maestro,nombreArch);
end;

var 
    nombreArch:string;
    maestro:tarch;
begin
    nombreArch:='maestro.dat';
    assign(maestro,nombreArch);
    writeln;
    writeln('Maestro antes de comprimir: ');
    imprimirMaestro(maestro);
    comprimirConRename(maestro,nombreArch);
    writeln;
    writeln('Maestro despues de comprimir: ');
    imprimirMaestro(maestro);
end.