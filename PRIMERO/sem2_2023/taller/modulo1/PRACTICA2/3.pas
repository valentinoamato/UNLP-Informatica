program ejercicio3;

type
    tipolista = ^ tiponodo;
    tiponodo = record 
        dato:integer;
        sig:tipolista;
    end;

procedure agregar (var pri:tipolista;dato:integer);
var 
    aux:tipolista;
begin 
    new(aux);
    aux^.sig:=pri;
    aux^.dato:=dato;
    pri:=aux;
end;

procedure cargar(var pri:tipolista);
var 
    i:integer;
begin 
    for i:=1 to (random(15)+6) do 
        agregar(pri,(random(100)));
end;

procedure imprimir(pri:tipolista);
begin 
    if (pri<>nil) then 
        begin 
            writeln(pri^.dato);
            imprimir(pri^.sig);
        end;
end;

procedure buscarMinimo (pri:tipolista;var minimo:integer);
begin 
    if (pri<>nil) then 
        begin 
            if (pri^.dato<minimo) then 
                minimo:=pri^.dato;
            buscarMinimo(pri^.sig,minimo);
        end;
end;


procedure buscarMaximo (pri:tipolista;var maximo:integer);
begin 
    if (pri<>nil) then 
        begin 
            if (pri^.dato>maximo) then 
                maximo:=pri^.dato;
            buscarMaximo(pri^.sig,maximo);
        end;
end;


function buscar (pri:tipolista;nbuscar:integer):boolean;
begin 
    if (pri<>nil) then 
        begin 
            if (pri^.dato=nbuscar) then 
                buscar:=True
            else
                buscar:=buscar(pri^.sig,nbuscar);
        end
    else 
        buscar:=False;
end;

var 
    pri:tipolista;
    n:integer;
begin 
    Randomize;
    pri:=nil;
    cargar(pri);
    imprimir(pri);

    n:=999;
    buscarMinimo(pri,n);
    writeln('El minimo es:',n);

    n:=-999;
    buscarMaximo(pri,n);
    writeln('El maximo es:',n);

    write('Ingrese un numero a buscar:');
    readln(n);
    writeln('Resultado de la busqueda:',buscar(pri,n));
end.