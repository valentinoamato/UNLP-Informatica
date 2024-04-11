program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        localidad:integer;
        municipio:integer;
        hospital:integer;
        casos:integer;
        fecha:string;
        nombreLoc:string;
        nombreMun:string;
        nombreHos:string;
    end;

procedure leer(var maestro:Text;var reg:tmaestro);
var 
    texto:string;
    indice:integer;
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.localidad,
                   reg.municipio,
                   reg.hospital,
                   reg.casos,
                   texto);
            texto:=trim(texto);
            indice:=pos('@',texto);
            reg.nombreLoc:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            indice:=pos('@',texto);
            reg.nombreMun:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            indice:=pos('@',texto);
            reg.nombreHos:=copy(texto,0,indice-1);
            delete(texto,1,indice);

            reg.fecha:=texto;
        end
    else 
        begin
            reg.municipio:=VALORALTO;
            reg.localidad:=VALORALTO;
            reg.hospital:=VALORALTO;
        end;
end;

procedure reportar(var maestro:Text);
type 
    tcasos = record
        localidad:integer;
        municipio:integer;
    end;

var 
    reg:tmaestro;
    casos,actual:tcasos;
    localidad:integer;
    municipios:Text;
    crear:boolean;
begin 
    crear:=True;

    reset(maestro);
    leer(maestro,reg);
    
    casos.localidad:=0;
    casos.municipio:=0;

    actual.localidad:=reg.localidad;
    actual.municipio:=reg.municipio;

    while (reg.localidad<>VALORALTO) do 
        begin 
            if (casos.localidad=0) and (casos.municipio=0) then 
                begin
                    writeln;
                    writeln('Localidad: ',reg.nombreLoc,'.');
                end;
            if (casos.municipio=0) then 
                begin
                    writeln;
                    writeln('   Municipio: ',reg.nombreMun,'.');
                end;

            writeln('       Hospital: ',reg.nombreHos,', Casos=',reg.casos);
            casos.municipio:=casos.municipio+reg.casos;
            leer(maestro,reg);

            if (reg.municipio<>actual.municipio) or (reg.localidad<>actual.localidad) then
                begin 
                    writeln('   Casos del municipio: ',casos.municipio,'.');
                    casos.localidad:=casos.localidad+casos.municipio;
                    casos.municipio:=0;
                    actual.municipio:=reg.municipio;
                end;

            if (reg.localidad<>actual.localidad) then 
                begin 
                    writeln('Casos de la localidad: ',casos.localidad,'.');
                    casos.localidad:=0;
                    actual.localidad:=reg.localidad;
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
