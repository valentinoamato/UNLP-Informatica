program test;
type
    fecha = record
        dia:integer;
        mes:string;
        anno:integer;
    end;
procedure leer(var f : fecha);
begin
    writeln('anno');
    readln(f.anno);
    if (f.anno <> 2020) then begin
        writeln('mes'); 
        readln(f.mes);
        writeln('dia'); 
        readln(f.dia);
end;
end;
function verano(f : fecha) : boolean;
var
    b:boolean;
begin

    if (f.mes = 'enero') or (f.mes = 'febrero') or (f.mes = 'marzo')  then
        b:=True
    else
        b:=False;
    verano:=b;

end;
function diez(f : fecha) : boolean;
var
    b:boolean;
begin

    if (f.dia<11)  then
        b:=True
    else
        b:=False;
    diez:=b;

end;

var
    f:fecha;
    nverano,ndiez:integer;

begin
    leer(f);
    while (f.anno <> 2020) do
        begin
            if (verano(f)) then
                nverano:=nverano+1;
            if (diez(f)) then
                ndiez:=ndiez+1;
            leer(f);
        end;
    write(nverano,ndiez);
end.