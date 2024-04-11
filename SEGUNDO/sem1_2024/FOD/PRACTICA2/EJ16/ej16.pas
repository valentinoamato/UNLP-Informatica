program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    VALORBAJO = -9999;
    DIMF = 10;
type 
    tmaestro =  record 
        codigo:integer;
        stock:integer;
        nombre:string;
        descripcion:string;
        modelo:string;
        marca:string; 
    end;

    tdetalle =  record 
        codigo:integer;
        precio:real;
        anno:integer;
        mes:integer; 
        dia:integer;
    end;

    tbin = file of tmaestro;

var 
    detalles: array [1..DIMF] of text;
    registros: array [1..DIMF] of tdetalle;


procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.codigo:=VALORALTO
    else 
        begin
            readln(det,
                   regd.codigo,
                   regd.precio,
                   regd.anno,
                   regd.mes,
                   regd.dia);
        end;
end;

procedure imprimirRegm(p:tmaestro);
begin 
    writeln(' ',p.codigo,
            '-',p.nombre,
            ', Stock: ',p.stock,
            ' - ',p.descripcion,
            ' - ',p.marca,
            ' - ',p.modelo);
end;

procedure imprimirBin(var bin:tbin);
var 
    producto:tmaestro;
begin 
    reset(bin);
    writeln;
    writeln('Los datos en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,producto);
            imprimirRegm(producto);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tmaestro;
    texto:string;
    indice:integer;
begin 
    assign(txt,'maestro.txt');
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,
                   reg.codigo,
                   reg.stock,
                   texto);
            texto:=trim(texto);
            indice:=pos('@',texto);
            reg.nombre:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            indice:=pos('@',texto);
            reg.descripcion:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            indice:=pos('@',texto);
            reg.modelo:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            reg.marca:=texto;

            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure inicializarDetalles();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            assign(detalles[i],'detalles/detalle'+i.tostring()+'.txt');
            reset(detalles[i]);
        end;
end;

procedure cerrarDetalles();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        close(detalles[i]);
end;

procedure cargarRegistros();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            leer(detalles[i],registros[i]);
        end;
end;

procedure minimo(var min:tdetalle);
type 
    tminimo =  record 
        indice:integer;
        codigo:integer;
    end;
var 
    minimo:tminimo;
    i:integer;
begin
    minimo.codigo:=VALORALTO;
    minimo.indice:=1;
    for i:=1 to DIMF do 
        begin 
            if (registros[i].codigo<minimo.codigo) then 
                begin 
                    minimo.codigo:=registros[i].codigo;
                    minimo.indice:=i;
                end;
        end;
    min:=registros[minimo.indice];
    leer(detalles[minimo.indice],registros[minimo.indice]);
end;

procedure actualizar(var maestro:tbin);
type 
    tmaximo =  record 
        ventas:integer;
        moto:tmaestro;
    end;
var 
    regm:tmaestro;
    maximo:tmaximo;
    actual,cant:integer;
    min:tdetalle;    
begin 
    maximo.ventas:=VALORBAJO;

    reset(maestro);
    read(maestro,regm);

    cargarRegistros();
    minimo(min);
    while (min.codigo<>VALORALTO) do 
        begin
            actual:=min.codigo;
            cant:=0;

            while (actual=min.codigo) do 
                begin 
                    cant:=cant+1;
                    minimo(min);
                end;

            while (regm.codigo<>actual) do 
                begin
                    read(maestro,regm);
                end;

            if (cant>maximo.ventas) then 
                begin 
                    maximo.ventas:=cant;
                    maximo.moto:=regm;
                end;

            regm.stock:=regm.stock-cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
    writeln('La moto mas vendida fue: ');
    imprimirRegm(maximo.moto);
end;

var 
    maestro:Text;
    bin:tbin;
begin 
    textToBin(maestro,bin);
    imprimirBin(bin);
    inicializarDetalles();
    actualizar(bin);
    imprimirBin(bin);
    cerrarDetalles();
end.