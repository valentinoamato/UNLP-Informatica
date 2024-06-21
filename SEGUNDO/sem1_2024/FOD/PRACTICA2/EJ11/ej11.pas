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

    ttiempo = record
        anno:integer;
        mes:integer;
        dia:integer;
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
        end;
end;

procedure reportar(var maestro:Text);
var 
    aux,actual:tmaestro;
    tiempo:ttiempo;
    anno:integer;
begin 
    reset(maestro);
    leer(maestro,aux);

    write('Ingrese un anno:');
    readln(anno);
    while (aux.anno<>VALORALTO) and (aux.anno<>anno) do 
        leer(maestro,aux);
    if (aux.anno=VALORALTO) then
        writeln('No se encontro el anno ',anno,'.')
    else
        begin         
            tiempo.anno:=0;
            tiempo.mes:=0;
            tiempo.dia:=0;

            actual:=aux;
            actual.tiempo:=0;
            writeln;
            writeln('Anno: ',anno,'.');
        end;
    

    while (aux.anno=anno) do 
        begin
            writeln;
            writeln('   Mes: ',aux.mes,'.');
            while (aux.anno=anno) and (aux.mes=actual.mes) do
                begin 
                    writeln('       Dia: ',aux.dia,'.');
                    while (aux.anno=anno) and (aux.mes=actual.mes) and (aux.dia=actual.dia) do 
                        begin 
                            while (aux.anno=anno) and (aux.mes=actual.mes) and (aux.dia=actual.dia) and (aux.id=actual.id) do 
                                begin 
                                    actual.tiempo:=actual.tiempo+aux.tiempo;
                                    leer(maestro,aux);
                                end;
                            writeln('           -ID: ',actual.id,', Tiempo=',actual.tiempo);
                            tiempo.dia:=tiempo.dia+actual.tiempo;
                            actual.tiempo:=0;
                            actual.id:=aux.id;
                        end;
                        writeln;
                        writeln('       Tiempo total del dia: ',tiempo.dia,'.');
                        tiempo.mes:=tiempo.mes+tiempo.dia;
                        tiempo.dia:=0;
                        actual.dia:=aux.dia;
                end;
            writeln;
            writeln('   Tiempo total del mes: ',tiempo.mes,'.');
            tiempo.anno:=tiempo.anno+tiempo.mes;
            tiempo.mes:=0;
            actual.mes:=aux.mes;
        end;
    if (tiempo.anno<>0) then 
        writeln;
        writeln('Tiempo total del anno: ',tiempo.anno,'.');
    close(maestro);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
