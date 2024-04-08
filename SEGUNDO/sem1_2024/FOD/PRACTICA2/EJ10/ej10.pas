program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        departamento:integer;
        division:integer;
        empleado:integer;
        categoria:integer;
        horas:integer;
    end;

var 
    valores:  array [1..15] of real;

procedure leer(var maestro:Text;var reg:tmaestro);
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.departamento,
                   reg.division,
                   reg.empleado,
                   reg.categoria,
                   reg.horas);
        end
    else 
        begin
            reg.departamento:=VALORALTO;
            reg.division:=VALORALTO;
            reg.empleado:=VALORALTO;
        end;
end;

procedure cargarValores(var archivoValores:Text);
var 
    indice:integer;
    valor:real;
begin 
    reset(archivoValores);
    while (not eof(archivoValores)) do 
        begin 
            readln(archivoValores,indice,valor);
            valores[indice]:=valor;
        end;
    close(archivoValores);
end; 

function getMonto(categoria,cantidad:integer):real;
begin 
    getMonto:=valores[categoria]*cantidad;
end;

procedure reportar(var maestro:Text);
type 
    thoras = record
        division:integer;
        departamento:integer;
    end;
    tmonto =  record 
        division:real;
        departamento:real;
    end;
var 
    reg:tmaestro;
    horas,actual:thoras;
    monto:tmonto;
begin 
    reset(maestro);
    leer(maestro,reg);
    
    horas.division:=0;
    horas.departamento:=0;
    
    monto.division:=0;
    monto.departamento:=0;

    actual.division:=reg.division;
    actual.departamento:=reg.departamento;

    while (reg.departamento<>VALORALTO) do 
        begin 
            if (horas.departamento=0) and (horas.division=0) then 
                begin
                    writeln;
                    writeln('Departamento N',reg.departamento,'.');
                end;
            if (horas.division=0) then 
                begin
                    writeln;
                    writeln('Division N',reg.division,'.');
                end;

            writeln('Empleado N',reg.empleado,', Horas=',reg.horas,', Monto=',getMonto(reg.categoria,reg.horas):0:2);
            horas.division:=horas.division+reg.horas;
            monto.division:=monto.division+getMonto(reg.categoria,reg.horas);
            leer(maestro,reg);

            if (reg.division<>actual.division) or (reg.departamento<>actual.departamento) then
                begin 
                    writeln('Total de horas division: ',horas.division,'.');
                    writeln('Monto total por division: ',monto.division:0:2,'.');
                    horas.departamento:=horas.departamento+horas.division;
                    monto.departamento:=monto.departamento+monto.division;
                    horas.division:=0;
                    monto.division:=0;
                    actual.division:=reg.division;
                end;

            if (reg.departamento<>actual.departamento) then 
                begin 
                    writeln('Total horas departamento: ',horas.departamento,'.');
                    writeln('Monto total departamento: ',monto.departamento:0:2,'.');
                    horas.departamento:=0;
                    monto.departamento:=0;
                    horas.division:=0;
                    monto.division:=0;
                    actual.division:=reg.division;
                    actual.departamento:=reg.departamento;
                end;
        end;
    writeln;
    close(maestro);
end;

var 
    maestro:Text;
    archivoValores:Text;
begin 
    assign(archivoValores,'valores.txt');
    cargarValores(archivoValores);

    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
