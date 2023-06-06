program Vectores;
const
    cant_datos = 10;
type
    vdatos = array[1..cant_datos] of real;
procedure cargarVector(var v:vdatos; var dimL : integer);
var
    i:integer;
    r:real;
begin
    i:=0;
    readln(r);
    while (r <> 0) and (i<(cant_datos)) do
        begin
            v[i+1]:=r;
            i:=i+1;
            if(i<(cant_datos)) then

                readln(r);
        end;
    dimL:=i;
end;

procedure modificarVectorySumar(var v:vdatos;dimL : integer; n: real; var suma: real);
var
    i:integer;
begin
    i:=0;
    while (i<dimL) do
        begin
            v[i+1]:=v[i+1]+n;
            suma:=suma+v[i+1];
            i:=i+1;
        end;
end;

{ programa principal }
var
    datos : vdatos;
    i, dim : integer;
    num, suma : real;
begin
    dim := 0;
    suma := 0;
    num:=0;
    cargarVector(datos,dim); { completar }
    writeln('Ingrese un valor a sumar');
    readln(num);
    modificarVectorySumar(datos,dim,num,suma);{completar}
    writeln('La suma de los valores es: ', suma:0:2);
    writeln(suma:0:2);
    writeln('Se procesaron: ',dim, ' números');
end.