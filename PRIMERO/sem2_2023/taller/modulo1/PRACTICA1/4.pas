program ejercicio4;
const 
    maxElementos=30;
    cantRubros=8;
type 
    tiporubro=1..cantRubros;
    tipoProducto = record
        codigo:integer;
        rubro:tiporubro;
        precio:real;
    end;

    tipoLista=^tipoNodo;
    tipoNodo = record 
        sig:tipoLista;
        dato:tipoProducto;
    end;

    tipoVectorRubros = array [1..cantRubros] of tipoLista;

    tipoVectorRubro3 = array [1..maxElementos] of tipoProducto;

procedure productoRandom(var producto:tipoProducto);
begin
    producto.codigo:=random(200)+1;
    producto.rubro:=random(cantRubros)+1;
    producto.precio:=((random(200)+1)/(random(200)+1));
end;

procedure insertar(var pri:tipoLista;producto:tipoProducto);
var 
    anterior,actual,aux:tipoLista;
begin
    actual:=pri;
    anterior:=nil;
    while (actual<>nil) and (actual^.dato.codigo<producto.codigo) do 
        begin 
            anterior:=actual;
            actual:=actual^.sig;
        end;
    new(aux);
    aux^.dato:=producto;
    aux^.sig:=actual;
    if (anterior<>nil) then 
        anterior^.sig:=aux
    else 
        pri:=aux;
end;

procedure cargarVectorRubros (var vector:tipoVectorRubros;var diml:integer);
var 
    i:integer;
    producto:tipoProducto;
begin 
    diml:=cantRubros;
    for i:=1 to diml do 
        vector[i]:=nil;
    for i:=1 to (random(80)+1) do 
        begin
            productoRandom(producto);
            insertar(vector[producto.rubro],producto);
        end;
end;

procedure imprimirProducto (producto:tipoProducto);
begin 
    writeln('Codigo=',producto.codigo,' Rubro=',producto.rubro,' precio=',producto.precio:0:2);
end;

procedure imprimirVectorRubros(vector:tipoVectorRubros;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml do 
        begin 
            writeln('Rubro ',i,':');
            while (vector[i]<>nil) do 
                begin
                    imprimirProducto(vector[i]^.dato);
                    vector[i]:=vector[i]^.sig;
                end;
        end;
    writeln();
end;        

procedure cargarVectorRubros3(vectorRS:tipoVectorRubros;var vectorR3:tipoVectorRubro3;var diml:integer);
var 
    i:integer;
begin 
    i:=1;
    while (vectorRS[3]<>nil) and (i<maxElementos) do 
        begin
            vectorR3[i]:=vectorRS[3]^.dato;
            vectorRS[3]:=vectorRS[3]^.sig;
            i:=i+1;
        end;
    diml:=i-1;
end;

procedure imprimirVectorRubros3(vector:tipoVectorRubro3;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml do
        imprimirProducto(vector[i]);
    writeln();
end;

procedure seleccion(var vector:tipoVectorRubro3;diml:integer);
var 
    i,j,max:integer;
    aux:tipoProducto;
begin 
    for i:=1 to diml-1 do 
        begin
            max:=i;
            for j:=i to diml do 
                begin 
                    if (vector[j].precio>vector[max].precio) then 
                        max:=j;
                end;
            aux:=vector[max];
            vector[max]:=vector[i];
            vector[i]:=aux;
        end;
end;

procedure promedio(vector:tipoVectorRubro3;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml-1 do 
        vector[i+1].precio:=vector[i+1].precio+vector[i].precio;
    writeln('Promedio=',(vector[diml].precio/diml):0:2);
end;
            
var 
    vectorRS:tipoVectorRubros;
    vectorR3:tipoVectorRubro3;
    dimlRubros:integer;
    dimlRubro3:integer;
begin 
    Randomize;

    cargarVectorRubros(vectorRS,dimlRubros);
    imprimirVectorRubros(vectorRS,dimlRubros);

    cargarVectorRubros3(vectorRS,vectorR3,dimlRubro3);
    imprimirVectorRubros3(vectorR3,dimlRubro3);

    seleccion(vectorR3,dimlRubro3);
    imprimirVectorRubros3(vectorR3,dimlRubro3);

    promedio(vectorR3,dimlRubro3);
end.