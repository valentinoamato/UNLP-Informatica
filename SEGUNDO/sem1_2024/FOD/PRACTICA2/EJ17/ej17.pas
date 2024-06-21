program test;

uses sysutils;

const 
    VALORALTO=9999;
    MAX_CASOS = 30;

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

    tcasos = record
        localidad:integer;
        municipio:integer;
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
            reg.localidad:=VALORALTO;
        end;
end;

procedure reportar(var maestro:Text);
var 
    aux,actual:tmaestro;
    casos:tcasos;
    municipios:Text;
begin 
    reset(maestro);
    leer(maestro,aux);

    assign(municipios,'municipios.txt');
    rewrite(municipios);
    
    casos.localidad:=0;
    casos.municipio:=0;

    actual:=aux;
    actual.casos:=0;

    while (aux.localidad<>VALORALTO) do 
        begin 
            writeln;
            writeln('Localidad: ',actual.nombreLoc,'.');
            while (aux.localidad=actual.localidad) do 
                begin 
                    writeln;
                    writeln('   Municipio: ',actual.nombreMun,'.');
                    while (aux.localidad=actual.localidad) and (aux.municipio=actual.municipio) do 
                        begin 
                            while (aux.localidad=actual.localidad) and (aux.municipio=actual.municipio) and (aux.hospital=actual.hospital) do 
                                begin 
                                    actual.casos:=actual.casos+aux.casos;
                                    leer(maestro,aux);
                                end;
                            writeln('       Hospital: ',actual.nombreHos,', Casos=',actual.casos);
                            casos.municipio:=casos.municipio+actual.casos;
                            actual.casos:=0;
                            actual.hospital:=aux.hospital;
                            actual.nombreHos:=aux.nombreHos;
                        end;
                    writeln('   Casos del municipio: ',casos.municipio,'.');
                    if (casos.municipio>MAX_CASOS) then 
                        writeln(municipios,actual.nombreLoc,' ',actual.nombreMun,' ',casos.municipio);
                    casos.localidad:=casos.localidad+casos.municipio;
                    casos.municipio:=0;
                    actual.municipio:=aux.municipio;
                    actual.nombreMun:=aux.nombreMun;
                end;
            writeln('Casos de la localidad: ',casos.localidad,'.');
            casos.localidad:=0;
            actual.localidad:=aux.localidad;
            actual.nombreLoc:=aux.nombreLoc;
        end;
    writeln;
    close(maestro);
    close(municipios);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.
