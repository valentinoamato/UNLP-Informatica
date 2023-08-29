PROGRAM ua;
CONST
    A=10;
TYPE
    SUB=1..A;
    test = record
        tEstVar:integer;
        I:INTEGER;
    end;
    vector = array [1..100] of integer;

PROCEDURE cargar (VAR v:vector;var diml:integer);
var
    num:integer;
BEGIN
    diml:=0;
    read(num);
    while (dimL<A) and (num<>5) do
        begin
            dimL:=dimL+1;
            writeln('dimL:',dimL);
            v[dimL]:=num;
            read(num);
        end;
end;
PROCEDURE cargar2 (VAR v:vector;var diml:integer);
var
    num:integer;
BEGIN
    diml:=0;
    read(num);
    while (dimL<A) and (num<>5) do
        begin
            dimL:=dimL+1;
            v[dimL]:=num;
            writeln('dimL:',dimL);
            read(num);
        end;
end;
PROCEDURE agregar (VAR v:vector;num:integer;var dimL:integer);
BEGIN
    if (dimL<A) then
        begin
            dimL:=dimL+1;
            v[dimL]:=num;
        end;
end;
procedure leer (v:vector;dimL:integer);
var
    i:integer;
begin
    for i:=1 to dimL do
        begin
            write(v[i]);
        end;
end;
procedure insertar (var v:vector;
                    num:integer;
                    pos:integer;
                    var diml:integer);
var
    i:integer;
begin
    if (dimL<A) and (pos>=1) and (pos<=diml+1) then
        begin
            for i:=dimL downto pos do
                v[i+1]:=v[i];
            v[pos]:=num;
            diml:=diml+1;
        end;
end;
procedure eliminar (var v:vector;
                    pos:integer;
                    var diml:integer);
var
    i:integer;
begin
    if (pos>=1) and (pos<=diml) then
        begin
            for i:=pos to (dimL-1) do
                v[i]:=v[i+1];
            diml:=diml-1;
        end;
end;
procedure buscar (v:vector;
                    num:integer;
                    diml:integer);
var
    pos:integer;
begin
    pos:=1;
    while (pos<=dimL) and (v[pos]<num) do
        pos:=pos+1;
        
    if (v[pos]=num) then
        write('existe')
    else
        write('no existe');
end;
VAR
    TESTVAR:integer;
    I,dimL,pos,num:integer;
    reg:test;
    v:vector;
    b:boolean;
begin
    // read(reg.testVAR);
    // read(reg.i);
    // reg.testVAR:=5;
    // write(reg.testvar,reg.i);
    // HOLA(reg.testvar,reg.I);
    // write(reg.testvar,reg.i);
    // cargar(v,dimL);
    // leer(v,dimL);
    // write('dimL:',dimL);
    // agregar(v,10,dimL);
    // leer(v,dimL)
    // for I:=40 to 1 do
    //     write('hi');
    // while True do
    //     begin
    //         writeln('pos:');
    //         readln(pos);
    //         writeln('num:');
    //         readln(num);
    //         insertar(v,num,pos,dimL);
    //         leer(v,dimL);
    //     end;
    cargar(v,dimL);
    leer(v,dimL);
    write('test');
    while True do
        begin


            writeln('num:');
            readln(num);
            buscar(v,num,dimL);
            leer(v,dimL);
        end;
end.