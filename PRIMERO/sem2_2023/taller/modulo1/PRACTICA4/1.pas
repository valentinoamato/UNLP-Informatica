program ejercicio1;
type 
    tipoVenta = record 
        codigo:integer;
        cantidad:integer;
        precio:real;
    end;

    tipoProducto = record 
        codigo:integer;
        cantidad:integer;
        total:real;
    end; 

    tipoArbol =^ tipoNodo;
    tipoNodo = record 
        dato:tipoProducto;
        HI:tipoArbol;
        HD:tipoArbol;
    end;

procedure ventaRandom(var venta:tipoVenta);
begin 
    venta.codigo:=random(10)+1;
    venta.cantidad:=random(10)+1;
    venta.precio:=venta.codigo*3;
end;

procedure agregarVenta(var arbol:tipoArbol;venta:tipoVenta);
var 
    producto:tipoProducto;
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            producto.codigo:=venta.codigo;
            producto.cantidad:=venta.cantidad;
            producto.total:=(venta.precio*venta.cantidad);
            arbol^.dato:=producto;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end 
    else 
        if (arbol^.dato.codigo=venta.codigo) then 
            begin
                arbol^.dato.total:=arbol^.dato.total+(venta.precio*venta.cantidad);
                arbol^.dato.cantidad:=arbol^.dato.cantidad+venta.cantidad;
            end
        else
            if (venta.codigo<arbol^.dato.codigo) then 
                agregarVenta(arbol^.HI,venta)
            else 
                agregarVenta(arbol^.HD,venta);
end;

procedure imprimirVenta(venta:tipoVenta);
begin 
    writeln('Codigo=',venta.codigo,' Cantidad=',venta.cantidad,' Precio=',venta.precio:0:2);
end;

procedure cargar(var arbol:tipoArbol);
var 
    i:integer;
    venta:tipoVenta;
begin
    writeln('Iniciando carga de ventas:');
    for i:=1 to random(16)+5 do 
        begin 
            ventaRandom(venta);
            write('Venta ',i,': ');
            imprimirVenta(venta);
            agregarVenta(arbol,venta);
        end;
end;

procedure imprimirProducto(producto:tipoProducto);
begin 
    writeln('Codigo=',producto.codigo,' Cantidad=',producto.cantidad,' Total=',producto.total:0:2);
end;

procedure imprimir(arbol:tipoArbol);
begin 
    if (arbol<>nil) then 
        begin 
            imprimir(arbol^.HI);
            imprimirProducto(arbol^.dato);
            imprimir(arbol^.HD);
        end;
end;

procedure mayorCantidad(arbol:tipoArbol;var producto:tipoProducto);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.cantidad>producto.cantidad) then 
                producto:=arbol^.dato;
            mayorCantidad(arbol^.HI,producto);
            mayorCantidad(arbol^.HD,producto);
        end;
end;

procedure menores(arbol:tipoArbol;codigo:integer;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.codigo<codigo) then 
                begin 
                    cant:=cant+1;
                    menores(arbol^.HI,codigo,cant);
                    menores(arbol^.HD,codigo,cant);
                end 
            else 
                menores(arbol^.HI,codigo,cant);
        end;
end;

procedure totalEntre(arbol:tipoArbol;a:integer;b:integer;var total:real);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.codigo>a) and (arbol^.dato.codigo<b) then 
                begin 
                    total:=total+arbol^.dato.total;
                    totalEntre(arbol^.HI,a,b,total);
                    totalEntre(arbol^.HD,a,b,total);
                end 
            else 
                if (arbol^.dato.codigo>a) then 
                    totalEntre(arbol^.HI,a,b,total)
                else 
                    totalEntre(arbol^.HD,a,b,total);
        end;
end;

var 
    arbol:tipoArbol;
    producto:tipoProducto;
    codigo,cant,a,b:integer;
    total:real;
begin 
    Randomize;
    arbol:=nil;
    cargar(arbol); //a

    imprimir(arbol);//b

    producto.cantidad:=-999;
    mayorCantidad(arbol,producto);//c
    writeln('El producto mas vendido fue el: ',producto.codigo);

    write('Ingrese un codigo de producto:');
    readln(codigo);
    cant:=0;
    menores(arbol,codigo,cant);//d
    writeln('Hay ',cant,' productos con codigo menor a ',codigo,'.');

    write('Ingrese un codigo de producto a: ');
    readln(a);
    write('Ingrese un codigo de producto b: ');
    readln(b);
    total:=0;
    totalEntre(arbol,a,b,total);//d
    writeln('El monto total de todos los productos con codigo entre ',a,' y ',b,' es: ',total:0:2);
end.