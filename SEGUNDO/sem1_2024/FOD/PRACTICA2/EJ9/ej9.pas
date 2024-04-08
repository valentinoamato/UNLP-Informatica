program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        provincia:integer;
        localidad:integer;
        mesa:integer;
        votos:integer;
    end;

procedure leer(var maestro:Text;var reg:tmaestro);
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.provincia,
                   reg.localidad,
                   reg.mesa,
                   reg.votos);
        end
    else 
        begin
            reg.provincia:=VALORALTO;
            reg.localidad:=VALORALTO;
        end;
end;


procedure reportar(var maestro:Text);
type 
    ttotal = record
        localidad:integer;
        provincia:integer;
        pais:integer;
    end;
    tactual = record 
        localidad:integer;
        provincia:integer;
    end;
var 
    reg:tmaestro;
    total:ttotal;
    actual:tactual;
begin 
    reset(maestro);
    leer(maestro,reg);
    
    total.localidad:=0;
    total.provincia:=0;
    total.pais:=0;

    actual.localidad:=reg.localidad;
    actual.provincia:=reg.provincia;

    while (reg.provincia<>VALORALTO) do 
        begin 
            if (total.provincia=0) and (total.localidad=0) then 
                begin
                    writeln;
                    writeln('Provincia N',reg.provincia,':');
                end;
            total.localidad:=total.localidad+reg.votos;
            leer(maestro,reg);

            if (reg.localidad<>actual.localidad) then
                begin 
                    writeln('Localidad N',actual.localidad,': ',total.localidad,'.');
                    total.provincia:=total.provincia+total.localidad;
                    total.localidad:=0;
                    actual.localidad:=reg.localidad;
                end;

            if (reg.provincia<>actual.provincia) then 
                begin 
                    writeln('Total de Votos Provincia: ',total.provincia,'.');
                    total.pais:=total.pais+total.provincia;
                    total.localidad:=0;
                    total.provincia:=0;
                    actual.localidad:=reg.localidad;
                    actual.provincia:=reg.provincia;
                end;
        end;
    writeln;
    writeln('Total General de Votos: ',total.pais);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
