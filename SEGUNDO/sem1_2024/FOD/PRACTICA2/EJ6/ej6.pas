program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    DIMF = 5;
type 


    tsesion = record 
        codigo:integer;
        fecha:integer;
        tiempo:integer;
    end;

    tbin = file of tsesion;

var 
    detalles: array [1..DIMF] of text;
    registros: array [1..DIMF] of tsesion;


procedure leer(var det:Text;var regd:tsesion);
begin
    if (eof (det)) then 
        regd.codigo:=VALORALTO
    else 
        begin
            readln(det,regd.codigo,regd.fecha,regd.tiempo);
        end;
end;

procedure imprimirSesion(p:tsesion);
begin 
    writeln(' Codigo: ',p.codigo,
            ', Fecha: ',p.fecha,
            ', Tiempo: ',p.tiempo);
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

procedure minimo(var min:tsesion);
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

procedure crearMaestro();
var 
    min,actual:tsesion;
    maestro:Text;
    
begin 
    assign(maestro,'maestro.txt');
    rewrite(maestro);

    inicializarDetalles();
    cargarRegistros();
    minimo(min);
    while (min.codigo<>VALORALTO) do 
        begin
            actual:=min;
            actual.tiempo:=0;

            while (actual.codigo=min.codigo) do 
                begin 
                    actual.tiempo:=actual.tiempo+min.tiempo;
                    minimo(min);
                end;

            writeln(maestro,
                    'Codigo: ',
                    actual.codigo,
                    ', Fecha: ',
                    actual.fecha,
                    ', Tiempo Total: ',
                    actual.tiempo);
        end;
    close(maestro);
    writeln;
    writeln('Se ha creado el archivo maestro: "maestro.txt".');
end;

var 
    bin:tbin;
begin 
    crearMaestro();
end.