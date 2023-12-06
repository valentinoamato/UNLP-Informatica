program ordenar;
type
vector = array [1..100] of integer;


procedure cargar(var v:vector; var dimL:integer); //Carga el vector con una cantidad aleatoria (5;15) de  numeros aleatorios (-15;15)
var
    i:integer;
begin
    diml:=random(11)+5;
    for i:=1 to diml do
        v[i]:=random(31)-15;;
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

function BusquedaBinariaRecursiva(v:vector; elemento, izquierda, derecha: Integer): Integer;//retorna el indice mas cercano
var
  medio: Integer;
begin
    if izquierda > derecha then
        begin
            if (derecha>0) then
                BusquedaBinariaRecursiva:=derecha
            else
                BusquedaBinariaRecursiva:=1;
        end
    else
        begin
            medio := (izquierda + derecha) div 2;
            if v[medio] = elemento then
                BusquedaBinariaRecursiva := medio // Elemento encontrado
            else if  elemento<v[medio] then
                BusquedaBinariaRecursiva := BusquedaBinariaRecursiva(v, elemento, izquierda, medio - 1)
            else
                BusquedaBinariaRecursiva := BusquedaBinariaRecursiva(v, elemento, medio + 1, derecha);
        end;
end;


Function BusquedaBinariaIterativa (v:vector; valor,diml:integer):integer;//retorna el indice mas cercano
Var 
    pri, ult, medio : integer;
Begin
    pri:= 1;
    ult:= diml;  
    medio:= (pri + ult) div 2;
    While  (pri <= ult) and (valor <> v[medio]) do 
        begin
            if (valor < v[medio]) then 
                ult:=medio-1 
            else 
                pri:=medio+1;
            medio := ( pri + ult ) div 2 ;
        end;
    if (medio>0) then
        BusquedaBinariaIterativa:=medio
    else
        BusquedaBinariaIterativa:=1;
end;


procedure eliminarEntre(var v:vector;n,m:integer; var diml:integer);//Elimina todos los elementos del vector entre dos valores (inclusivo)
//Funciona mal si m>n, m^n<1, m^n>diml
var
    salto,i,indiceIzq,indiceDer:integer;
begin
    indiceIzq:=BusquedaBinariaRecursiva(v,n,1,diml);
    indiceDer:=BusquedaBinariaRecursiva(v,m,1,diml)+1;
    salto:=indiceDer-indiceIzq;

    i:=indiceIzq;
    while ((i+salto)<=diml) do
        begin
            v[i]:=v[i+salto];
            i:=i+1;
        end;
    diml:=diml-salto;
end;



var
    v:vector;
    diml,izq,n,m:integer;
begin
    cargar(v,diml);
    escribir(v,diml);
    seleccion(v,diml);
    escribir(v,diml);
    insercion(v,diml);
    escribir(v,diml);
    writeln('Ingrese el numero a buscar:');
    readln(n);
    writeln('BusquedaBinariaRecursiva: ',BusquedaBinariaRecursiva(v,n,1,diml));
    writeln('BusquedaBinariaIterativa: ',BusquedaBinariaIterativa(v,n,diml));
    writeln('Ingrese el n (borrar varios):');
    readln(n);
    writeln('Ingrese el m (borrar varios):');
    readln(m);
    eliminarEntre(v,n,m,diml);
    escribir(v,diml);
end.



