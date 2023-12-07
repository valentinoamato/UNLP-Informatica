program ejercicio4;
type
    tipovector = array [1..20] of integer;

procedure cargar(var vector:tipovector; inicio:integer);
begin 
    if (inicio<20) then 
        begin 
            vector[inicio]:=random(99)+1;
            inicio:=inicio+1;
            cargar(vector,inicio);
        end;
end;

procedure imprimir(vector:tipovector;inicio:integer);
begin 
    if (inicio<20) then 
        begin 
            writeln(inicio,': ',vector[inicio]);
            inicio:=inicio+1;
            imprimir(vector,inicio);
        end;
end;

procedure maximo(vector:tipovector;inicio:integer;var M:integer);
begin 
    if (inicio<20) then 
        begin 
            if (vector[inicio]>M) then 
                M:=vector[inicio];
            inicio:=inicio+1;
            maximo(vector,inicio,M);
        end;
end;

procedure total(vector:tipovector;inicio:integer;var n:integer);
begin 
    if (inicio<20) then 
        begin 
            n:=n+vector[inicio];
            inicio:=inicio+1;
            total(vector,inicio,n);
        end;
end;

var 
    vector:tipovector;
    n:integer;
begin 
    Randomize;
    cargar(vector,1);

    imprimir(vector,1);

    n:=-999;
    maximo(vector,1,n);
    writeln('El maximo es:',n);

    n:=0;
    total(vector,1,n);
    writeln('El total es:',n);
end.