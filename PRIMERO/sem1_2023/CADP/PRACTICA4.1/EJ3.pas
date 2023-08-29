program test;
const
    dimF=10;
type
    enteros = array[1..dimF] of integer;
procedure imprimir(var v:enteros;x,y,dimL:integer);
begin
    // if (x>y) then
    //     begin
    //         for i:=y to x do //i=4-5-6-7-8 imprimir=8-7-6-5-4
    //             begin
    //                 writeln(v[(dimL-i)+(x div y)]); //6-5-4-3-2
    //                 writeln(v[(dimL-i)+(x div y)]); //8-7-6-5-4-3-2
    //             end;
    //     end;

    // for i:=x to y do
    //     begin
    //         writeln(v[i]);
    //     end;
        if (x>y) then
            y:=y-1
            
        else 
            y:=y+1;
    while (x<>y) do
        begin
            writeln(v[x]); //6
            if (x>y) then
                x:=x-1

            else 
                x:=x+1;
        end;

end;
procedure cargarVector(var v:enteros; var dimL : integer);
var
    i,r:integer;
begin
    i:=0;
    readln(r);
    while (r <> 0) and (i<(dimF)) do
        begin
            v[i+1]:=r;
            i:=i+1;
            if(i<(dimF)) then

                readln(r);
        end;
    dimL:=i;
end;
var
    e:enteros;
    dimL,x,y:integer;
begin
    dimL:=0;

    cargarVector(e,dimL);
    writeln('ingrese x e y:');
    read(x);
    read(y);
    imprimir(e,x,y,dimL);
end.