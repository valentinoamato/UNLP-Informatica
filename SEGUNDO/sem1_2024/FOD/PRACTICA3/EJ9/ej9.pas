program test;
uses sysutils;
type 
    tproducto =  record 
        codigo:integer;
        nombre:string;
        precio:real;
        actual:integer;
        minimo:integer;
    end;
    tarch = file of tproducto;
var 
    arch:tarch;

procedure imprimirArch();
var 
    p:tproducto;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch, p);
            writeln('Codigo: ',p.codigo,
                    ' Nombre: ',p.nombre,
                    ' Precio: ',p.precio:0:2,
                    ' Actual: ',p.actual,
                    ' Minimo: ',p.minimo);
        end;
    close(arch);
end;

procedure cargar();
var 
    p:tproducto;
    txt:Text;
begin 
    assign(txt,'maestro.txt');
    assign(arch,'maestro.dat');
    rewrite(arch);
    reset(txt);
    while (not eof(txt)) do 
        begin 
            readln(txt,p.codigo,p.precio,p.actual,p.minimo,p.nombre);
            p.nombre:=trim(p.nombre);
            write(arch,p);
        end;
    close(arch);
    close(txt);
end;

procedure actualizarMaestro();
var 
    p:tproducto;
    txt:Text;
    cod,sum,cant:integer;
begin 
    assign(txt,'detalle.txt');
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch,p);
            reset(txt);
            cod:=p.codigo;
            sum:=0;
            while (not eof(txt)) do 
                begin
                    readln(txt,cod,cant);
                    if (cod=p.codigo) then 
                        sum:=sum+cant;
                end;
            if (sum>0) then 
                begin 
                    p.actual:=p.actual-sum;
                    seek(arch,filepos(arch)-1);
                    write(arch,p);
                end;
        end;
    close(arch);
    close(txt);
end;

begin 
    cargar();
    imprimirArch();
    actualizarMaestro();
    writeln;
    writeln('El maestro ha sido actualizado.');
    writeln;
    imprimirArch();
end.
