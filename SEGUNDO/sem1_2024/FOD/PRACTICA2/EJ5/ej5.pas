program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    DIMF = 30;
type 
    tproducto =  record 
        codigo:integer;
        nombre:string;
        descripcion:string;
        actual:integer; //stock actual
        minimo:integer; //stock minimo
        precio:real;
    end;

    tdetalle = record 
        codigo:integer;
        cant:integer; //cantidad vendida
    end;

    tbin = file of tproducto;

var 
    detalles: array [1..DIMF] of text;
    registros: array [1..DIMF] of tdetalle;


procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.codigo:=VALORALTO
    else 
        begin
            readln(det,regd.codigo,regd.cant);
        end;
end;

procedure imprimirProducto(p:tproducto);
begin 
    writeln(' Codigo: ',p.codigo,
            ', Actual: ',p.actual,
            ', Minimo: ',p.minimo,
            ', Nombre: ',p.nombre,
            ', Descripcion: ',p.descripcion,
            ', Precio: ',p.precio:0:2);
end;

procedure imprimirBin(var bin:tbin);
var 
    producto:tproducto;
begin 
    reset(bin);
    writeln;
    writeln('Los productos en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,producto);
            imprimirProducto(producto);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tproducto;
    texto:string;
    indice:integer;
begin 
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,reg.codigo,reg.actual,reg.minimo,reg.precio,texto);
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
var 
    regm:tproducto;
    cant,codigo:integer;
    min:tdetalle;
    stock_minimo:Text;
    
begin 
    reset(maestro);
    read(maestro,regm);

    assign(stock_minimo,'stock_minimo.txt');
    rewrite(stock_minimo);
    writeln(stock_minimo,'Los productos con stock disponible menor al minimo son:');

    cargarRegistros();
    minimo(min);
    while (min.codigo<>VALORALTO) do 
        begin
            codigo:=min.codigo;
            cant:=0;

            while (codigo=min.codigo) do 
                begin 
                    cant:=cant+min.cant;
                    minimo(min);
                end;
            while (regm.codigo<>codigo) do 
                begin
                    read(maestro,regm);
                end;
            regm.actual:=regm.actual-cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 

            if (regm.actual<regm.minimo) then
                writeln(stock_minimo,
                        regm.codigo,' ',
                        regm.actual,' ',
                        regm.minimo,' ',
                        regm.precio:0:2,' ',
                        regm.nombre,' ',
                        regm.descripcion);
            
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(maestro);
    close(stock_minimo);
    writeln;
    writeln('Productos con stock menor al minimo listados en stock_minimo.txt');
    writeln('Actualizacion realizada con exito.');
end;

var 
    maestro:Text;
    bin:tbin;
begin 
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    imprimirBin(bin);
    inicializarDetalles();
    actualizar(bin);
    imprimirBin(bin);
    cerrarDetalles();
end.