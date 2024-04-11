program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    VALORBAJO = -9999;
    DIMF = 100;
type 
    tmaestro =  record 
        anno:integer;
        mes:integer;
        dia:integer;
        codigo:integer;
        precio:real;
        total:integer; 
        vendidos:integer;
        nombre:string;
        descripcion:string;
    end;

    tdetalle =  record 
        anno:integer;
        mes:integer;
        dia:integer;
        codigo:integer;
        vendidos:integer;
    end;

    tbin = file of tmaestro;

var 
    detalles: array [1..DIMF] of text;
    registros: array [1..DIMF] of tdetalle;


procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        begin
            regd.anno:=VALORALTO;
            regd.mes:=VALORALTO;
        end
    else 
        begin
            readln(det,
                   regd.anno,
                   regd.mes,
                   regd.dia,
                   regd.codigo, 
                   regd.vendidos);
        end;
end;

procedure imprimirRegm(p:tmaestro);
begin 
    writeln(' - ',p.anno,
            '/',p.mes,
            '/',p.dia,
            ' Codigo: ',p.codigo,
            ', Precio: ',p.precio:0:2,
            ', Total: ',p.total,
            ', Vendidos: ',p.vendidos,
            ' - ',p.nombre,
            ' - ',p.descripcion);
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
                   reg.anno,
                   reg.mes,
                   reg.dia,
                   reg.codigo, 
                   reg.precio,
                   reg.total,
                   reg.vendidos,
                   texto);
            texto:=trim(texto);
            indice:=pos('@',texto);
            reg.nombre:=copy(texto,0,indice-1);
            reg.descripcion:=copy(texto,indice+1,length(texto));
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
        anno:integer;
        mes:integer;
        dia:integer;
        codigo:integer;
    end;
var 
    minimo:tminimo;
    i:integer;
begin
    minimo.anno:=VALORALTO;
    minimo.indice:=1;
    for i:=1 to DIMF do 
        begin 
            if (registros[i].anno<minimo.anno) or 
              ((registros[i].anno=minimo.anno) and (registros[i].mes<minimo.mes)) or
              ((registros[i].anno=minimo.anno) and (registros[i].mes=minimo.mes) and (registros[i].dia<minimo.dia)) or
              ((registros[i].anno=minimo.anno) and (registros[i].mes=minimo.mes) and (registros[i].dia=minimo.dia) and (registros[i].codigo<minimo.codigo)) then
                begin 
                    minimo.anno:=registros[i].anno;
                    minimo.mes:=registros[i].mes;
                    minimo.dia:=registros[i].dia;
                    minimo.codigo:=registros[i].codigo;
                    minimo.indice:=i;
                end;
        end;
    min:=registros[minimo.indice];
    leer(detalles[minimo.indice],registros[minimo.indice]);
end;

procedure actualizar(var maestro:tbin);
var 
    regm,menosVentas,maximo:tmaestro;
    min,actual:tdetalle;    
begin 
    writeln('bo1');
    maximo.vendidos:=VALORBAJO;
    menosVentas.vendidos:=VALORALTO;

    reset(maestro);
    read(maestro,regm);
    cargarRegistros();
    minimo(min);

    while (min.anno<>VALORALTO) do 
        begin
            actual:=min;
            actual.vendidos:=0;


            while (actual.anno=min.anno) and 
                  (actual.mes=min.mes) and 
                  (actual.dia=min.dia) and 
                  (actual.codigo=min.codigo) do 
                begin 
                    actual.vendidos:=actual.vendidos+min.vendidos;
                    minimo(min);
                end;

            while (regm.anno<>actual.anno) and 
                  (regm.mes<>actual.mes) and 
                  (regm.dia<>actual.dia) and 
                  (regm.codigo<>actual.codigo) do 
                begin 
                    read(maestro,regm);
                end;
            regm.vendidos:=regm.vendidos+actual.vendidos;

            if (regm.vendidos<menosVentas.vendidos) then 
                menosVentas:=regm 
            else if (regm.vendidos>maximo.vendidos) then 
                maximo:=regm;

            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
    writeln('El semanario mas vendido fue: ');
    imprimirRegm(maximo);
    writeln('El semanario menos vendido fue: ');
    imprimirRegm(menosVentas);

end;

var 
    maestro:Text;
    bin:tbin;
begin 
    writeln('bo-1');
    textToBin(maestro,bin);
    writeln('bo0');
    imprimirBin(bin);
    inicializarDetalles();
    actualizar(bin);
    imprimirBin(bin);
    cerrarDetalles();
end.