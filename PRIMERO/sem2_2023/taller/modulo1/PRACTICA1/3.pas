program ejercicio3;
const
    maxGeneros = 8;
type 
    tipoGenero = 1..maxGeneros;
    tipoPelicula = record 
        codigo:integer;
        genero:tipoGenero;
        puntaje:real;
    end;

    tipoLista =^ tipoNodo;
    tipoNodo = record 
        sig:tipoLista;
        dato:tipoPelicula;
    end;

    tipoMejoresPuntajes = array [1..maxGeneros] of tipoPelicula;

procedure agregar (var pri:tipoLista;pelicula:tipoPelicula);
var 
    aux:tipoLista;
begin 
    new(aux);
    aux^.dato:=pelicula;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure peliculaRandom(var pelicula:tipoPelicula);
begin 
    pelicula.codigo:=random(200)+1;
    pelicula.genero:=random(maxGeneros)+1;
    pelicula.puntaje:=((random(10)+1)/(random(10)+1));
end;

procedure cargar (var pri:tipoLista);
var
    i,j:integer;
    pelicula:tipoPelicula;
begin
    j:=random(30)+1;
    for i:=1 to j do 
        begin
            peliculaRandom(pelicula);
            agregar(pri,pelicula);
        end;
end;

procedure imprimir (pri:tipoLista);
begin 
    writeln();
    while (pri<>nil) do 
        begin 
            writeln('Codigo=',pri^.dato.codigo,' Genero=',pri^.dato.genero,' Puntaje=',pri^.dato.puntaje:0:2);
            pri:=pri^.sig;
        end;
    writeln();
end;

procedure inicializarVector(var vector:tipoMejoresPuntajes;var diml:integer);
var 
    i:integer;
begin
    diml:=maxGeneros;
    for i:=1 to diml do 
        begin 
            vector[i].codigo:=-1;
            vector[i].genero:=i;
            vector[i].puntaje:=-1.0;
        end;
end;

procedure cargarVector(var vector:tipoMejoresPuntajes;var diml:integer;pri:tipoLista);
begin
    inicializarVector(vector,diml);
    while (pri<>nil) do 
        begin 
            if (pri^.dato.puntaje>vector[pri^.dato.genero].puntaje) then 
                vector[pri^.dato.genero]:=pri^.dato;
            pri:=pri^.sig;
        end;
end;

procedure imprimirVector(vector:tipoMejoresPuntajes;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml do 
        writeln('Codigo=',vector[i].codigo,' Genero=',vector[i].genero,' Puntaje=',vector[i].puntaje:0:2);
    writeln();
end;

procedure insercion(var vector:tipoMejoresPuntajes;diml:integer);
var 
    i,j:integer;
    actual:tipoPelicula;
begin 
    for i:=2 to diml do
        begin
            j:=i-1;
            actual:=vector[i];
            while (j>0) and (vector[j].puntaje>actual.puntaje) do 
                begin 
                    vector[j+1]:=vector[j];
                    j:=j-1;
                end;
            vector[j+1]:=actual;
        end;
end;

var 
    pri:tipoLista;
    vector:tipoMejoresPuntajes;
    diml:integer;
begin 
    Randomize;
    pri:=nil;

    cargar(pri);
    imprimir(pri);

    cargarVector(vector,diml,pri);
    imprimirVector(vector,diml);

    insercion(vector,diml);
    imprimirVector(vector,diml);
end.

