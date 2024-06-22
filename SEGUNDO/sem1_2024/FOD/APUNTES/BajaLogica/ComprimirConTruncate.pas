//El maestro contiene registros con codigo y nombre 
//Las bajas logicas se realizan agregando una arroba al inicio del nombre
//Compactar el archivo usando truncate
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
            writeln('Codigo: ',reg.codigo,', Nombre: ',reg.nombre,'.');
        end;
    close(maestro);
end;

procedure comprimirConTruncate(var maestro:tarch);
var 
    reg,aux:tregistro;
    i:integer;
begin 
    reset(maestro);
    while (not eof(maestro)) do 
        begin 
            read(maestro,reg);
            if (pos('@',reg.nombre)<>0) then 
                begin 
                    i:=filepos(maestro)-1;
                    seek(maestro,filesize(maestro)-1);
                    read(maestro,aux);
                    while (pos('@',aux.nombre)<>0) and (reg.codigo<>aux.codigo) do 
                        begin 
                            seek(maestro,filesize(maestro)-1);
                            truncate(maestro);
                            seek(maestro,filesize(maestro)-1);
                            read(maestro,aux);
                        end;
                    seek(maestro,filesize(maestro)-1);
                    truncate(maestro);
                    seek(maestro,i);
                    write(maestro,aux);
                end;
        end;
    close(maestro);
end;

var 
    maestro:tarch;
begin 
    assign(maestro,'maestro.dat');
    writeln;
    writeln('Maestro antes de comprimir: ');
    imprimirMaestro(maestro);
    comprimirConTruncate(maestro);
    writeln;
    writeln('Maestro despues de comprimir: ');
    imprimirMaestro(maestro);
end.