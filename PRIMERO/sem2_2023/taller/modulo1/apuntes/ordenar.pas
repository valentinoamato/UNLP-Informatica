program ordenar;
type
vector = array [1..100] of integer;


procedure cargar(var v:vector; var dimL:integer); //Carga el vector con numeros hasta que se ingresa el 0
var
    i,n:integer;
begin
    i:=1;
    writeln('Ingrese un numero: ');
    readln(n);
    diml:=0;
    while (n<>0) do
        begin
            v[i]:=n;
            i:=i+1;
            dimL:=dimL+1;
            write('Ingrese un numero: ');
            readln(n);
        end;
end;


procedure escribir(v:vector;diml:integer);
var
    i:integer;
begin
    writeln();
    for i:=1 to diml do
        write('|',v[i]);
    writeln();

end;


procedure seleccion (var v:vector;diml:integer);
var
    i,j,pos,item:integer;
begin
    for i:=1 to diml-1 do //busca el minimo y lo guarda en pos su indice
        begin
            pos:=i;

            for j:=i+1 to diml do
                if (v[j]<v[pos]) then
                    pos:=j;

            //intercambia el elemento iterado con el minimo
            item:=v[pos];
            v[pos]:=v[i];
            v[i]:=item;
        end;
end;

procedure insercion(var v:vector;diml:integer);
var
    i,j,actual:integer;
begin
    for i:=2 to dimL do
        begin
            j:=i-1;
            actual:=v[i];

            while (j>0) and (v[j]>actual) do
                begin
                    v[j+1]:=v[j];
                    j:=j-1;
                end;
            v[j+1]:=actual;
        end;
end;






var
    v:vector;
    diml:integer;
begin
    cargar(v,diml);
    escribir(v,diml);
    seleccion(v,diml);
    escribir(v,diml);
    cargar(v,diml);
    escribir(v,diml);
    insercion(v,diml);
    escribir(v,diml);
end.



