//El archivo maestro contiene a,b,c y cantidad. 
//El archivo se encuentra ordenado por a,b y c.
program apunte;
const 
    VALORALTO=9999;
type 
    tregistro = record 
        a:integer;
        b:integer;
        c:integer;
        cant:integer;
    end;

    tacum = record //Acumulador 
        total:integer;
        a:integer;
        b:integer;
    end;

procedure leer(var maestro:Text;var reg:tregistro);
begin 
    if (eof(maestro)) then 
        reg.a:=VALORALTO
    else 
        readln(maestro,reg.a,reg.b,reg.c,reg.cant);
end;

procedure reportar(var maestro:Text);
var 
    aux,actual:tregistro;
    acum:tacum;
begin 
    reset(maestro);
    leer(maestro,aux);

    actual:=aux;
    actual.cant:=0;

    acum.total:=0;
    acum.a:=0;
    acum.b:=0;

    while (aux.a<>VALORALTO) do 
        begin 
            writeln;
            writeln('A: ',aux.a,'.');
            while (aux.a=actual.a) do 
                begin 
                    writeln('   B: ',aux.b,'.');
                    while (aux.a=actual.a) and (aux.b=actual.b) do 
                        begin 
                            while (aux.a=actual.a) and (aux.b=actual.b) and (aux.c=actual.c) do 
                                begin 
                                    actual.cant:=actual.cant+aux.cant;
                                    leer(maestro,aux);
                                end;
                            writeln('       C: ',actual.c,', cant=',actual.cant,'.');
                            acum.b:=acum.b+actual.cant;
                            actual.cant:=0;
                            actual.c:=aux.c;
                        end;
                    writeln('   Cant B=',acum.b,'.');
                    acum.a:=acum.a+acum.b;
                    acum.b:=0;
                    actual.b:=aux.b;
                end;
            writeln('Cant A=',acum.a,'.');
            acum.total:=acum.total+acum.a;
            acum.a:=0;
            actual.a:=aux.a;
        end;
    writeln('Total=',acum.total,'.');
    close(maestro);
end;

var 
    maestro:Text;
begin 
    assign(maestro,'maestro.txt');
    reportar(maestro);
end.