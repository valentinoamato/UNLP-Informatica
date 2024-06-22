//Archivo maestro con registros que contienen un codigo
//Metodo para agregar un registro con un codigo determinado
//Metodo para eliminar un registro con un codigo determinado
program apuntes;
type  
    tregistro = record 
        codigo:integer;
    end;

    tarch = file of tregistro;

procedure agregar(var maestro:tarch;registro:tregistro);
begin 
    reset(maestro);
    seek(maestro,filesize(maestro));
    write(maestro,registro);
    close(maestro);
end;

procedure bajaFisica(var maestro:tarch;codigo:integer);
var 
    found:boolean;
    aux:integer; 
    reg:tregistro;
begin 
    reset(maestro);
    found:=false;
    while (not eof(maestro)) and (not found) do 
        begin 
            read(maestro,reg);
            if (reg.codigo=codigo) then 
                begin 
                    aux:=filepos(maestro)-1; //Posicion del registro a borrar
                    seek(maestro,filesize(maestro)-1);//Posicion del ultimo registro
                    read(maestro,reg);
                    seek(maestro,aux);
                    write(maestro,reg); //Sobreescribo el registro a borrar con el ultimo del archivo
                    seek(maestro,filesize(maestro)-1);
                    truncate(maestro);
                    found:=true;
                end;
        end;
    if (not found) then 
        writeln('No se ha encontrado el registro con codigo ',codigo,'.');
    close(maestro);
end;

procedure imprimirMaestro(var maestro:tarch);
var 
    reg:tregistro;
begin 
    reset(maestro);
    while (not eof(maestro)) do 
        begin 
            read(maestro,reg);
            writeln('-Codigo: ',reg.codigo,'.');
        end;
    close(maestro);
end;

var 
    maestro:tarch;
    reg:tregistro;
begin 
    assign(maestro,'maestro.dat');
    rewrite(maestro);
    reg.codigo:=1;
    agregar(maestro,reg); //+1
    reg.codigo:=2;
    agregar(maestro,reg); //+2
    reg.codigo:=3;
    agregar(maestro,reg); //+3
    reg.codigo:=4;
    agregar(maestro,reg); //+4
    reg.codigo:=5;
    agregar(maestro,reg); //+5
    reg.codigo:=6;
    agregar(maestro,reg); //+6
    writeln;
    writeln('Estado del maestro antes de borrar:');
    imprimirMaestro(maestro);
    bajaFisica(maestro,2);
    bajaFisica(maestro,4);
    bajaFisica(maestro,6);
    bajaFisica(maestro,8);
    writeln;
    writeln('Estado del maestro despues de borrar:');
    imprimirMaestro(maestro);
end.