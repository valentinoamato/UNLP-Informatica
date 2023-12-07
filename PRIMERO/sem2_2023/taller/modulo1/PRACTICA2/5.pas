program ejercicio5;
type 
    tipovector = array [1..20] of integer;

procedure cargar (var vector:tipovector;indice:integer);
begin 
    if (indice<20) then 
        begin 
            vector[indice]:=random(100)+1;
            cargar(vector,indice+1);
        end;
end;

procedure imprimir (vector:tipovector;indice:integer);
begin 
    if (indice<20) then 
        begin 
            writeln(indice,': ',vector[indice]);
            imprimir(vector,indice+1);
        end;
end;

procedure seleccion (var vector:tipovector);
var 
    i,j,min,aux:integer;
begin 
    for i:=1 to 19 do 
        begin
            min:=i;
            for j:=i to 20 do 
                begin 
                    if (vector[j]<vector[min]) then
                        min:=j;
                end;
            aux:=vector[min];
            vector[min]:=vector[i];
            vector[i]:=aux;
        end;
end; 


procedure buscar (vector:tipovector;indiceI,indiceD,n:integer;var indiceN:integer);
var 
    medio:integer;
begin 
    medio:=(indiceI+indiceD) div 2;
    writeln('IndiceI: ',indiceI,' IndiceD: ',indiceD,' N: ',n,' IndiceN: ',indiceN,' Medio:',medio);
    if (indiceI<=indiceD) then 
        begin 
            if (vector[medio]=n) then 
                indiceN:=medio
            else 
                if (vector[medio]>n) then 
                    buscar(vector,indiceI,medio-1,n,indiceN)
                else
                    buscar(vector,medio+1,indiceD,n,indiceN);
        end 
    else 
        indiceN:=-1;
end;

var 
    vector:tipovector;
    n,indice:integer;
begin 
    Randomize;
    cargar(vector,1);

    writeln('Sin orden: ');
    imprimir(vector,1);

    seleccion(vector);

    writeln();
    writeln('Con orden: ');
    imprimir(vector,1);

    write('Ingrese un numero a buscar:');
    readln(n);
    buscar(vector,1,20,n,indice);
    if (indice<>-1) then 
        writeln('El numero ',n,' se encuentra en la pocision ',indice,' del vector.')
    else 
        writeln('El numero ',n,' no se encuentra en el vector.');
end.