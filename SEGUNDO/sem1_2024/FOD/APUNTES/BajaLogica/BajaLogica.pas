//Archivo maestro con codigo y nombre
//Se elimina logicamente el nombre agregandole una arroba al principio 
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
            if (pos('@',reg.nombre)=0) then 
                writeln('Codigo: ',reg.codigo,' Nombre: ',reg.nombre,'.');
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
            writeln('Codigo: ',reg.codigo,' Nombre: ',reg.nombre,'.');
        end;
    close(maestro);
end;



procedure agregar(var maestro:tarch;nombre:string;codigo:integer);
var 
    reg,nuevo:tregistro;
    terminado:boolean;
begin   
    terminado:=false;
    nuevo.codigo:=codigo;
    nuevo.nombre:=nombre;
    reset(maestro);
    while (not eof(maestro)) and (not terminado) do 
        begin 
            read(maestro,reg);
            if (pos('@',reg.nombre)<>0) then 
                begin
                    terminado:=true;
                    seek(maestro,filepos(maestro)-1);
                end;
        end;
    write(maestro,nuevo);
    close(maestro);
end;

procedure eliminar(var maestro:tarch;codigo:integer);
var 
    reg:tregistro;
    found:boolean;
begin 
    found:=false;
    reset(maestro);
    while (not eof(maestro)) and (not found) do 
        begin   
            read(maestro, reg);
            if (reg.codigo=codigo) then 
                begin
                    seek(maestro,filepos(maestro)-1);
                    reg.nombre:=('@'+reg.nombre);
                    write(maestro,reg); 
                    found:=true;
                end;
        end;
    if (not found) then 
        writeln('No se ha encontrado el registro con codigo ',codigo,'.');
    close(maestro);
end;

var 
    maestro:tarch;
begin 
    assign(maestro,'maestro.dat');
    rewrite(maestro);
    agregar(maestro,'nombre1',1);
    agregar(maestro,'nombre2',2);
    agregar(maestro,'nombre3',3);
    agregar(maestro,'nombre4',4);
    agregar(maestro,'nombre5',5);
    writeln;
    writeln('Maestro antes de eliminar:');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro antes de eliminar(con eliminados):');
    imprimirMaestroDebug(maestro);
    eliminar(maestro,2);
    eliminar(maestro,4);
    eliminar(maestro,6);
    writeln('Maestro despues de eliminar:');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro despues de eliminar(con eliminados):');
    imprimirMaestroDebug(maestro);
    agregar(maestro,'nombre2',2);
    agregar(maestro,'nombre4',4);
    agregar(maestro,'nombre6',6);
    writeln;
    writeln('Maestro despues de agregar:');
    imprimirMaestro(maestro);
    writeln;
    writeln('Maestro despues de agregar(con eliminados):');
    imprimirMaestro(maestro);
    eliminar(maestro,1);
    eliminar(maestro,3);
    eliminar(maestro,5);
end.