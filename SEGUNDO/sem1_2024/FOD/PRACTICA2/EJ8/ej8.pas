program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        codigo:integer;
        anno:integer;
        mes:integer;
        dia:integer;
        monto:real;
        nombre:string;
    end;

procedure leer(var maestro:Text;var reg:tmaestro);
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.codigo,
                   reg.anno,
                   reg.mes,
                   reg.dia,
                   reg.monto,
                   reg.nombre);
            reg.nombre:=trim(reg.nombre);
        end
    else 
        reg.codigo:=VALORALTO;
end;


procedure reportar(var maestro:Text);
type 
    ttotal = record
        cliente:real;
        clientes:real;
    end;
var 
    reg:tmaestro;
    total:ttotal;
    actual:integer;
begin 
    reset(maestro);
    leer(maestro,reg);
    total.cliente:=0;
    total.clientes:=0;
    actual:=reg.codigo;
    while (reg.codigo<>VALORALTO) do 
        begin 
            if (total.cliente=0) then 
                begin
                    writeln;
                    writeln('Cliente N',reg.codigo,', ',reg.nombre,':');
                end;
            total.cliente:=total.cliente+reg.monto;
            total.clientes:=total.clientes+reg.monto;
            writeln('- Fecha=',reg.dia,'/',reg.mes,'/',reg.anno,' Monto=',reg.monto:0:2);
            leer(maestro,reg);
            if (reg.codigo<>actual) then
                begin 
                    writeln('Monto total del cliente = ',total.cliente:0:2);
                    total.cliente:=0;
                    actual:=reg.codigo;
                end;
        end;
    writeln;
    writeln('Ingreso total de la empresa = ',total.clientes:0:2);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
