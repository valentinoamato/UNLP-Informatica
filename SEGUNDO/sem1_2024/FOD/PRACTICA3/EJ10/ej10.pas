program test;
uses sysutils;
type 
    tlista = ^ tnodo;
    tnodo = record 
        localidad:integer;
        sig:tlista;
    end;

    treg = record 
        localidad:integer;
        mesa:integer;
        votos:integer;
    end;

    tarch = file of treg;
var 
    arch:tarch;

procedure cargar();
var 
    txt:Text;
    reg:treg;
begin 
    assign(txt,'maestro.txt');
    assign(arch,'maestro.dat');
    reset(txt);
    rewrite(arch);
    while (not eof(txt)) do 
        begin 
            readln(txt,reg.localidad,reg.mesa,reg.votos);
            write(arch,reg);
        end;
    close(arch);
    close(txt);
end;

function exists(pri:tlista;localidad:integer):boolean;
begin 
    if (pri=nil) then 
        exists:=False
    else 
        begin 
            if (pri^.localidad=localidad) then 
                exists:=True 
            else 
                exists:=exists(pri^.sig,localidad);
        end;
end;

procedure agregar(var pri:tlista;localidad:integer);
var 
    aux:tlista;
begin 
    new(aux);
    aux^.localidad:=localidad;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure laburar();
var 
    votos,localidad,total:integer;
    reg:treg;
    pri:tlista;
    i:integer;
begin 
    reset(arch);
    i:=0;
    total:=0;
    pri:=nil;
    writeln;
    while (not eof(arch)) do 
        begin 
            read(arch,reg);
            localidad:=reg.localidad;
            i:=i+1;
            if (not exists(pri,localidad)) then 
                begin 
                    agregar(pri,localidad);
                    seek(arch,0);
                    votos:=0;
                    while (not eof(arch)) do 
                        begin   
                            read(arch,reg);
                            if (reg.localidad=localidad) then 
                                votos:=votos+reg.votos;
                        end;
                    total:=total+votos;
                    writeln('Codigo de Localidad: ',localidad,', Cantidad de Votos: ',votos,'.');
                    seek(arch,i);
                end;
        end; 
    writeln('Total General de Votos: ',total,'.');
end;

begin 
    cargar();
    laburar();
end.