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

    tvotos = record 
        provincia:integer;
        pais:integer;
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
        end;
end;


procedure reportar(var maestro:Text);
var 
    reg,actual:tmaestro;
    votos:tvotos;
begin 
    reset(maestro);
    leer(maestro,reg);
    
    votos.provincia:=0;
    votos.pais:=0;

    actual:=reg;
    actual.votos:=0;

    while (reg.provincia<>VALORALTO) do 
        begin 
            writeln;
            writeln('Provincia: ',actual.provincia,'.');
            while (reg.provincia=actual.provincia) do 
                begin 
                    while (reg.provincia=actual.provincia) and (reg.localidad=actual.localidad) do 
                        begin 
                            actual.votos:=actual.votos+reg.votos;
                            leer(maestro,reg);
                        end;
                        writeln('Localidad: ',actual.localidad,', Votos: ',actual.votos,'.');
                        votos.provincia:=votos.provincia+actual.votos;
                        actual.localidad:=reg.localidad;
                        actual.votos:=0;
                end;
                writeln('Total de Votos Provincia:', votos.provincia);
                votos.pais:=votos.pais+votos.provincia;
                votos.provincia:=0;
                actual.provincia:=reg.provincia;
        end;
    writeln;
    writeln('Total General de Votos: ',votos.pais);
    close(maestro);                    
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
