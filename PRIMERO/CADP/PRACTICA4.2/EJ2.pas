program test;

const
    dimf=10;

type
    vector = array [1..dimf] of string;

procedure cargar (var v:vector;var diml:integer);
var
    nombre:string;
    i:integer;
begin
    diml:=0;
    i:=1;
    writeln('ingrese nombrel:');
    readln(nombre);
    while (nombre<>'ZZZ') and (i<=dimf) do
        begin
            v[i]:=nombre;
            i:=i+1;
            diml:=diml+1;
            writeln('ingrese nombrel:');
            readln(nombre);
        end;
end;

procedure leer(v:vector;diml:integer);
var
    i:integer;
begin
    for i:=1 to diml do
        write(v[i]);
end;

procedure b (var v:vector;nombre:string;var diml:integer);
var
    i,j:integer;
begin
    i:=1;
    while (v[i]<>nombre) and (i<=diml) do
        i:=i+1;
    if (i<=diml) then
        begin
            for j:=i to (diml-1) do
                begin
                    v[j]:=v[j+1];
                end;
        end;
    diml:=diml-1;
end;

procedure c (var v:vector;nombre:string;var diml:integer);
var
    i:integer;
begin
    if (diml<dimf) then
        begin
            for i:=diml downto 4 do
                v[i+1]:=v[i];
            diml:=diml+1;
        end;
    v[4]:=nombre;
end;

procedure d (var v:vector;nombre:string;var diml:integer);
begin
    if (diml<dimf) then
        v[diml+1]:=nombre;
    diml:=diml+1;
end;

var
    v:vector;
    diml:integer;
    nombre:string;
begin
    cargar(v,diml);
    leer(v,diml);
    writeln('ingrese nombrel:');
    readln(nombre);
    b(v,nombre,diml);
    leer(v,diml);
    writeln('ingrese nombrel:');
    readln(nombre);
    c(v,nombre,diml);
    leer(v,diml);
    writeln('ingrese nombrel:');
    readln(nombre);
    d(v,nombre,diml);
    leer(v,diml);
end.

    


    
