program test;
const
    coeficiente=23.435;
type
    escuela = record
        CUE:integer;
        ndocentes:integer;
        nombre:string;
        nalumnos:integer;
        localidad:string;
        indice:real;
    end;
    minimos = record
        min1:real;
        CUE1:integer;
        nombre1:string;
        min2:real;
        CUE2:integer;
        nombre2:string;
    end;

function relacion(e : escuela) : real;
begin
    relacion:=e.nalumnos/e.ndocentes;
end;

procedure leer(var e : escuela);
begin
    writeln('CUE');
    readln(e.CUE);
    writeln('ndocentes'); 
    readln(e.ndocentes);
    writeln('nombre'); 
    readln(e.nombre);
    writeln('nalumnos');
    readln(e.nalumnos);
    writeln('localidad'); 
    readln(e.localidad);
    e.indice:=relacion(e);
end;



procedure min(e : escuela;var m: minimos);

begin

    if (e.indice<m.min1) then
        begin
            m.nombre2:=m.nombre1;
            m.CUE2:=m.CUE1;
            m.min2:=m.min1;
            m.nombre1:=e.nombre;
            m.CUE1:=e.CUE;
            m.min1:=e.indice;
        end
    else if (e.indice<m.min2) then
        begin
            m.nombre2:=e.nombre;
            m.CUE2:=e.CUE;
            m.min2:=e.indice;
        end;
end;




procedure superior(e : escuela;var nsuperior:integer);

begin
    if (e.indice>coeficiente) then
        nsuperior:=nsuperior+1;
end;

var
    e:escuela;
    m:minimos;
    i,nsuperior:integer;

begin
    m.min1:=999;
    m.min2:=999;
    nsuperior:=0;
    for i:=1 to 5 do
        begin
            leer(e);
            min(e,m);
            superior(e,nsuperior);

        end;
    write('nsup:',nsuperior,'CUE1:',m.CUE1,'nombre1:',m.nombre1,'CUE2:',m.CUE2,'nombre2:',m.nombre2);
end.