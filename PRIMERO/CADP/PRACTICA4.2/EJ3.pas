program E3;
const
    dimf=10;
type
    diames=1..31;
    regviaje=record
        dia:diames;
        monto:real;
        distancia:real;
    end;
    vectormes = array [diames] of integer;
    vector = array [1..dimf] of regviaje;
procedure leer (var viaje:regviaje);
begin
    writeln('Ingrese dia:');
    readln(viaje.dia);
    writeln('Ingrese monto:');
    readln(viaje.monto);
    writeln('Ingrese distancia:');
    readln(viaje.distancia);
end;
    
procedure cargar (var v:vector;var diml:integer);
var
    i:integer;
    reg:regviaje;
begin
    i:=1;
    diml:=0;
    leer(reg);
    while (i<dimf) and (reg.distancia<>0) do
        begin
            v[i]:=reg;
            diml:=diml+1;   
            i:=i+1;   
            leer(reg);
        end;
end;

procedure escribir (v:vector;diml:integer);
var
    i:integer;
begin
    for i:=1 to diml do
        begin
            writeln('');
            writeln('i: ',i);
            writeln(v[i].dia);
            writeln(v[i].monto);
            writeln(v[i].distancia);
            writeln('');
        end;
end;

procedure b (v:vector;diml:integer);
var
    i:integer;
    promediosum:real;
    min:regviaje;
    mes:vectormes;
begin
    promediosum:=0;
    if (diml>0) then
        min:=v[1];
    for i:=1 to 31 do
        mes[i]:=0;
    for i:=1 to diml do
        begin
            promediosum:=promediosum+v[i].monto;
            if (v[i].monto<min.monto) then
                min:=v[i];
            mes[v[i].dia]:=mes[v[i].dia]+1;
        end;
    writeln('El promedio de los montos es:',(promediosum/diml):0:2);
    writeln('En el viaje de menor monto la distancia fue:',min.distancia,' y el dia del mes fue: ',min.dia);
    for i:=1 to 31 do
        writeln('En el dia ',i,' se realizaron ',mes[i],' viajes.');
end;

procedure c (var v:vector;var diml:integer);
var
    i,j,eliminados:integer;
begin
    eliminados:=0;
    for i:=1 to diml do
        begin
            if (v[i].distancia=100) then
                begin        
                    for j:=i to (diml-1) do
                        v[j]:=v[j+1];
                    eliminados:=eliminados+1;
                end;  
        end;
    diml:=diml-eliminados;
end;


var
    v:vector;
    diml:integer;
begin
    cargar(v,diml);
    b(v,diml);
    escribir(v,diml);
    c(v,diml);
    escribir(v,diml);
end.
    
    