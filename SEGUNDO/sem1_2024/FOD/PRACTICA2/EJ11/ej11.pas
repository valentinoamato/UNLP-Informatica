program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        anno:integer;
        mes:integer;
        dia:integer;
        id:integer;
        tiempo:integer;
    end;

procedure leer(var maestro:Text;var reg:tmaestro);
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.anno,
                   reg.mes,
                   reg.dia,
                   reg.id,
                   reg.tiempo);
        end
    else 
        begin
            reg.anno:=VALORALTO;
            reg.mes:=VALORALTO;
            reg.dia:=VALORALTO;
        end;
end;

procedure reportar(var maestro:Text);
type 
    ttiempo = record
        anno:integer;
        mes:integer;
        dia:integer;
    end;

var 
    reg:tmaestro;
    tiempo,actual:ttiempo;
    anno:integer;
begin 
    reset(maestro);
    leer(maestro,reg);

    write('Ingrese un anno:');
    readln(anno);
    while (not eof(maestro)) and (reg.anno<>anno) do 
        leer(maestro,reg);
    if (eof(maestro)) then
        begin 
            writeln('No se encontro el anno ',anno,'.');
            exit;
        end;
    
    tiempo.anno:=0;
    tiempo.mes:=0;
    tiempo.dia:=0;

    actual.anno:=reg.anno;
    actual.mes:=reg.mes;
    actual.dia:=reg.dia;

    while (reg.anno<>VALORALTO) and (reg.anno=anno) do 
        begin 
            if (tiempo.anno=0) and (tiempo.mes=0) and (tiempo.dia=0) then 
                begin
                    writeln;
                    writeln('Anno: ',anno,'.');
                end;
            if (tiempo.mes=0) and (tiempo.dia=0) then 
                begin
                    writeln;
                    writeln('   Mes: ',reg.mes,'.');
                end;
            if (tiempo.dia=0) then 
                begin
                    writeln('       Dia: ',reg.dia,'.');
                end;

            writeln('           ID: ',reg.id,', Tiempo=',reg.tiempo);
            tiempo.dia:=tiempo.dia+reg.tiempo;
            leer(maestro,reg);

            if (reg.dia<>actual.dia) or (reg.mes<>actual.mes) or (reg.anno<>actual.anno) then
                begin 
                    writeln('       Tiempo total del dia: ',tiempo.dia,'.');
                    tiempo.mes:=tiempo.mes+tiempo.dia;
                    tiempo.dia:=0;
                    actual.dia:=reg.dia;
                end;

            if (reg.mes<>actual.mes) or (reg.anno<>actual.anno) then
                begin 
                    writeln('   Tiempo total del mes: ',tiempo.mes,'.');
                    tiempo.anno:=tiempo.anno+tiempo.mes;
                    tiempo.mes:=0;
                    actual.mes:=reg.mes;
                end;

            if (reg.anno<>actual.anno) then 
                begin 
                    writeln('Tiempo total del anno: ',tiempo.anno,'.');
                    tiempo.anno:=0;
                    actual.anno:=reg.anno;
                end;
        end;
    writeln;
    close(maestro);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
