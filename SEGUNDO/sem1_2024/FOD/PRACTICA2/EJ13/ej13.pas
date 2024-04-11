program test;

uses sysutils;

const 
    VALORALTO = 'ZZZZ';

type 
    tfecha = record 
        anno:integer;
        mes:integer;
        dia:integer;
        hora:integer;
        minuto:integer;
    end;

    tmaestro = record 
        fecha:tfecha;
        destino:string;
        asientos:integer;
    end;

    tlista =^ tnodo;
    tnodo = record
        sig:tlista;
        dato:tmaestro;
    end;

    tbin = file of tmaestro;

var 
    det1,det2: Text;
    regd1,regd2: tmaestro;

procedure agregar(var pri:tlista;reg:tmaestro);
var 
    aux:tlista;
begin 
    new(aux);
    aux^.dato:=reg;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure imprimirVuelo(p:tmaestro);
begin 
    writeln(' Destino: ',
            p.destino,' ',
            p.fecha.dia,'/',
            p.fecha.mes,'/',
            p.fecha.anno,' ',
            p.fecha.hora,':',
            p.fecha.minuto,' Asientos Disponibles: ',
            p.asientos,'.');
end;

procedure imprimirLista(pri:tlista);
begin 
    writeln;
    writeln('Los vuelos en la lista son: ');
    while (pri<>nil) do 
        begin 
            imprimirVuelo(pri^.dato);
            pri:=pri^.sig;
        end;
end;

procedure leer(var det:Text;var regd:tmaestro);
begin
    if (eof (det)) then 
        regd.destino:=valoralto
    else 
        begin
            readln(det,
                   regd.fecha.anno,
                   regd.fecha.mes,
                   regd.fecha.dia,
                   regd.fecha.hora,
                   regd.fecha.minuto,
                   regd.asientos,
                   regd.destino);
            regd.destino:=trim(regd.destino);
        end;
end;

procedure imprimirBin(var bin:tbin);
var 
    vuelo:tmaestro;
begin 
    reset(bin);
    writeln;
    writeln('Los vuelos en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,vuelo);
            imprimirVuelo(vuelo);
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
            readln(txt,
                   reg.fecha.anno,
                   reg.fecha.mes,
                   reg.fecha.dia,
                   reg.fecha.hora,
                   reg.fecha.minuto,
                   reg.asientos,
                   reg.destino);
            reg.destino:=trim(reg.destino);
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure minimo(var min:tmaestro); //War crime ahead
begin
    //Para calcular el minimo tengo que tener en cuenta destino,
    // si los destinos son iguales, tengo que tener en cuenta en anno,
    // si son iguales... mes,dia,hora,minuto
    if (regd1.destino<regd2.destino) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.destino<regd1.destino) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    if (regd1.fecha.anno<regd2.fecha.anno) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.fecha.anno<regd1.fecha.anno) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    if (regd1.fecha.mes<regd2.fecha.mes) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.fecha.mes<regd1.fecha.mes) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    if (regd1.fecha.dia<regd2.fecha.dia) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.fecha.dia<regd1.fecha.dia) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    if (regd1.fecha.hora<regd2.fecha.hora) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.fecha.hora<regd1.fecha.hora) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    if (regd1.fecha.minuto<regd2.fecha.minuto) then 
        begin 
            min:=regd1;
            leer(det1,regd1);
            exit;
        end;
    if (regd2.fecha.minuto<regd1.fecha.minuto) then 
        begin 
            min:=regd2;
            leer(det2,regd2);
            exit;
        end;

    min:=regd1;
    leer(det1,regd1);
end;    

function mismoVuelo(vuelo1,vuelo2:tmaestro):boolean;
begin 
    mismoVuelo:=(vuelo1.fecha.anno=vuelo2.fecha.anno) and
                (vuelo1.fecha.mes=vuelo2.fecha.mes) and
                (vuelo1.fecha.dia=vuelo2.fecha.dia) and
                (vuelo1.fecha.hora=vuelo2.fecha.hora) and
                (vuelo1.fecha.minuto=vuelo2.fecha.minuto) and
                (vuelo1.destino=vuelo2.destino);
end;

procedure actualizar(var maestro:tbin);
var 
    regm,actual,min:tmaestro;
begin 
    reset(det1);
    reset(det2); 
    reset(maestro);

    leer(det1,regd1);
    leer(det2,regd2);
    minimo(min);
    read(maestro,regm);

    while (min.destino<>valoralto) do 
        begin
            actual:=min;
            actual.asientos:=0;

            while (mismoVuelo(actual,min)) do 
                begin
                    actual.asientos:=actual.asientos+min.asientos;
                    minimo(min);
                end;

            while (not mismoVuelo(regm,actual)) do 
                begin
                    read(maestro,regm);
                end;
            regm.asientos:=regm.asientos-actual.asientos;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(det1);
    close(det2);
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
end;

procedure cargarLista(var pri:tlista;var bin:tbin);
var 
    asientos:integer;
    reg:tmaestro;
begin 
    writeln;
    write('Ingrese una cantidad de asientos disponibles: ');
    reset(bin);
    readln(asientos);
    while (not eof(bin)) do 
        begin 
            read(bin,reg);
            if (reg.asientos<asientos) then 
                agregar(pri,reg);
        end;
    writeln('Se ha creado una lista con los vuelos que tiene menos de ',asientos,' asientos disponibles.');
    close(bin);
end;


var 
    maestro:Text;
    bin:tbin;
    pri:tlista;
begin 
    pri:=nil;
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    imprimirBin(bin);
    assign(det1,'detalle1.txt');
    assign(det2,'detalle2.txt');
    actualizar(bin);
    imprimirBin(bin);
    cargarLista(pri,bin);
    imprimirLista(pri);
end.