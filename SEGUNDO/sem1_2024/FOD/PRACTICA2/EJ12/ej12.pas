program test;

Uses sysutils;
const 
    valoralto = 9999;
type 
    tmaestro =  record 
        codigo:integer;
        enviados:integer;
        nombre:string;
    end;

    tdetalle = record 
        remitente:integer;
        destinatario:integer;
        mensage:string;
    end;

    tbin = file of tmaestro;

procedure leer(var det:Text;var reg:tdetalle);
begin
    if (eof (det)) then 
        reg.remitente:=valoralto
    else 
        readln(det,reg.remitente,reg.destinatario,reg.mensage);
end;

procedure imprimirProducto(p:tmaestro);
begin 
    writeln('Codigo: ',p.codigo,' Mensajes enviados: ',p.enviados,' Nombre: ',p.nombre);
end;

procedure imprimirBin(var bin:tbin);
var 
    producto:tmaestro;
begin 
    reset(bin);
    writeln;
    writeln('Las entradas en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,producto);
            imprimirProducto(producto);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tmaestro;
begin 
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,reg.codigo,reg.enviados,reg.nombre);
            reg.nombre:=trim(reg.nombre);
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure actualizar(var maestro:tbin;var detalle:Text);
var 
    regm:tmaestro;
    regd:tdetalle;
    cant,codigo:integer;
    listado:Text;
begin 
    assign(listado,'listado.txt');
    rewrite(listado);

    reset(detalle);
    reset(maestro);

    leer(detalle,regd);
    read(maestro,regm);
    while (regd.remitente<>valoralto) do 
        begin
            codigo:=regd.remitente;
            cant:=0;

            while (codigo=regd.remitente) do 
                begin 
                    cant:=cant+1;
                    leer(detalle,regd);
                end;
            while (regm.codigo<>codigo) do 
                begin 
                    writeln(listado,'Numero de usuario: ',regm.codigo,', Cantidad de mensajes enviados: ',0,'.');            
                    read(maestro,regm);
                end;
            writeln(listado,'Numero de usuario: ',regm.codigo,', Cantidad de mensajes enviados: ',cant,'.');
            regm.enviados:=regm.enviados+cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    while (not eof(maestro)) do 
        begin
            writeln(listado,'Numero de usuario: ',regm.codigo,', Cantidad de mensajes enviados: ',0,'.');     
            read(maestro,regm);
        end;       
    writeln(listado,'Numero de usuario: ',regm.codigo,', Cantidad de mensajes enviados: ',0,'.');     
        
    close(detalle);
    close(maestro);
    close(listado);
    writeln;
    writeln('Actualizacion realizada con exito.');
    writeln('Listado creado con exito en "listado.txt"');
end;

var 
    detalle,maestro:Text;
    bin:tbin;
begin 
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    imprimirBin(bin);
    assign(detalle,'detalle.txt');
    actualizar(bin,detalle);
    imprimirBin(bin);
end.