program ejercicio3;
const
    productos = 20;
    rubros = 5;
type 
    //A
    trubros = 1 .. rubros;
    tproducto = record 
        codigo:integer;
        rubro:trubros;
        stock:integer;
        precio:real;
    end;

    tproductoReducido = record
        codigo:integer;
        stock:integer;
        precio:real;
    end;

    tarbol =^ tnodo;
    tnodo = record 
        dato:tproductoReducido;
        HI:tarbol; 
        HD:tarbol;
    end; 

    tvector = array [trubros] of tarbol;

    //C,D

    tVectorEnteros = array [trubros] of integer;

procedure productoRandom (var producto:tproducto);
begin 
    producto.codigo := random(200)+1;
    producto.rubro := random(rubros)+1;
    producto.stock := random(20)+1;
    producto.precio := (random(200)+1)/(random(200)+1);
end;

procedure imprimirProductoReducido (producto:tproductoReducido);
begin 
    writeln('Codigo:',producto.codigo,'  Stock:',producto.stock,'  Precio:',producto.precio:0:2);
end;

procedure imprimirProducto (producto:tproducto);
begin 
    writeln('Codigo:',producto.codigo,'  Rubro:',producto.rubro,'  Stock:',producto.stock,'  Precio:',producto.precio:0:2);
end;

procedure inicializarVector (var vector:tvector);
var 
    i:integer;
begin 
    for i:=1 to rubros do 
        vector[i]:=nil;
end;

procedure agregarArbol (var arbol:tarbol;producto:tproductoReducido);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.HI:=nil;
            arbol^.HD:=nil;
            arbol^.dato:=producto;
        end 
    else 
        begin 
            if (producto.codigo>arbol^.dato.codigo) then 
                agregarArbol(arbol^.HD,producto)
            else
                agregarArbol(arbol^.HI,producto);
        end;
end;

procedure productoToProductoReducido(producto:tproducto;var reducido:tproductoReducido);
begin 
    reducido.codigo:=producto.codigo;
    reducido.stock:=producto.stock;
    reducido.precio:=producto.precio;
end;

procedure cargar (var vector:tvector);
var 
    i:integer;
    producto:tproducto;
    reducido:tproductoReducido;
begin 
    writeln('Iniciando carga...');
    for i:=1 to productos do 
        begin 
            write(i,': ');
            productoRandom(producto);
            imprimirProducto(producto);
            productoToProductoReducido(producto,reducido);
            agregarArbol(vector[producto.rubro],reducido);
        end;
end;

procedure imprimirArbol(arbol:tarbol);
begin 
    if (arbol<>nil) then 
        begin 
            imprimirArbol(arbol^.HI);
            imprimirProductoReducido(arbol^.dato);
            imprimirArbol(arbol^.HD);
        end;
end;

procedure imprimirVector(vector:tvector);
var 
    i:integer;
begin 
    for i:=1 to rubros do 
        begin 
            writeln;
            writeln('Rubro ',i,':');
            imprimirArbol(vector[i]);
        end;
end;

procedure buscarEnArbol(arbol:tarbol;codigo:integer;var existe:boolean);
begin 
    if (arbol<>nil) then 
        begin 
            if (codigo=arbol^.dato.codigo) then 
                existe:=True
            else 
                begin
                    if (codigo>arbol^.dato.codigo) then
                        buscarEnArbol(arbol^.HD,codigo,existe)
                    else 
                        buscarEnArbol(arbol^.HI,codigo,existe);
                end;
        end;
end;


procedure modulob(vector:tvector;rubro,codigo:integer;var existe:boolean);
begin 
    buscarEnArbol(vector[rubro],codigo,existe);
end;

procedure maximo (arbol:tarbol;var codigo:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.HD<>nil) then 
                maximo(arbol^.HD,codigo)
            else 
                codigo:=arbol^.dato.codigo;
        end;
end;

procedure cargarVectorC(vector:tvector;var vectorC:tVectorEnteros);
var 
    i,codigo:integer;
begin 
    for i:=1 to rubros do 
        begin
            codigo:=-1;
            maximo(vector[i],codigo);
            vectorC[i]:=codigo;
        end;
end;

procedure imprimirVectorNumeros(vector:tVectorEnteros);
var 
    i:integer;
begin 
    for i:=1 to rubros do 
        begin 
            writeln(i,': ',vector[i],'   ');
        end;
end;

procedure cantEntre(arbol:tarbol;codigoA,codigoB:integer;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.codigo>codigoA) and (arbol^.dato.codigo<codigoB) then
                begin 
                    cant:=cant+1;
                    cantEntre(arbol^.HI,codigoA,codigoB,cant);
                    cantEntre(arbol^.HD,codigoA,codigoB,cant);
                end
            else
                begin
                    if (arbol^.dato.codigo>codigoA) then
                        cantEntre(arbol^.HI,codigoA,codigoB,cant)
                    else 
                        cantEntre(arbol^.HD,codigoA,codigoB,cant);
                end;
        end;
end;


procedure cargarVectorD(vector:tvector;var vectorD:tVectorEnteros;codigoA,codigoB:integer);
var 
    i,cant:integer;
begin 
    for i:=1 to rubros do 
        begin 
            cant:=0;
            cantEntre(vector[i],codigoA,codigoB,cant);
            vectorD[i]:=cant;
        end;
end;


var
    rubro,codigo,codigoA,codigoB:integer;
    vector:tvector;
    existe:boolean;
    vectorC,vectorD:tVectorEnteros;
begin
    Randomize;

    //A
    inicializarVector(vector);
    cargar(vector);
    imprimirVector(vector);

    //B
    writeln;
    writeln('B:');
    write('Ingrese un rubro:');
    readln(rubro);
    write('Ingrese un codigo:');
    readln(codigo);
    existe:=False;
    modulob(vector,rubro,codigo,existe);
    if (existe) then 
        writeln('El producto con codigo ',codigo,' existe en el rubro ',rubro,'.')
    else
        writeln('El producto con codigo ',codigo,' NO existe en el rubro ',rubro,'.');

    //C
    writeln;
    writeln('C:');
    cargarVectorC(vector,vectorC);
    imprimirVectorNumeros(vectorC);

    //D
    writeln;
    writeln('D:');
    write('Ingrese un codigo:');
    readln(codigoA);
    write('Ingrese otro codigo:');
    readln(codigoB);
    cargarVectorD(vector,vectorD,codigoA,codigoB);
    writeln('La cantidad de elementos por rubro con codigo entre ',codigoA,' y ',codigoB,' son:');
    imprimirVectorNumeros(vectorD);

end.