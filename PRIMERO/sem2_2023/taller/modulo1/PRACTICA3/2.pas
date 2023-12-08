program ejercicio2;
type 
    tipoDia = 1..31;
    tipoVenta = record 
        codigo:integer;
        dia:tipoDia;
        cantidad:integer;
    end;

    tipoProductosVendidos = record 
        codigo:integer;
        cantidad:integer;
    end;

    tipoArbolI = ^ tipoNodoI;
    tipoNodoI = record 
        dato:tipoVenta;
        HI:tipoArbolI;
        HD:tipoArbolI;
    end;

    tipoArbolII = ^ tipoNodoII;
    tipoNodoII = record 
        dato:tipoProductosVendidos;
        HI:tipoArbolII;
        HD:tipoArbolII;
    end;

procedure agregarI(var arbol:tipoArbolI;venta:tipoVenta);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.dato:=venta;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end
    else 
        if (venta.codigo<=arbol^.dato.codigo) then 
            agregarI(arbol^.HI,venta)
        else 
            agregarI(arbol^.HD,venta);
end;

procedure agregarII(var arbol:tipoArbolII;productosVendidos:tipoProductosVendidos);
begin 
    if (arbol=nil) then 
        begin
            new(arbol);
            arbol^.dato:=productosVendidos;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end
    else 
        if (arbol^.dato.codigo=productosVendidos.codigo) then 
            arbol^.dato.cantidad:=arbol^.dato.cantidad+productosVendidos.cantidad
        else
            if (productosVendidos.codigo<=arbol^.dato.codigo) then 
              agregarII(arbol^.HI,productosVendidos)
            else 
                agregarII(arbol^.HD,productosVendidos);
end;

procedure ventaRandom(var venta:tipoVenta);
begin 
    venta.codigo:=random(10)+1;
    venta.dia:=random(31)+1;
    venta.cantidad:=random(5)+1;
end;

procedure imprimirI(arbol:tipoArbolI);
begin 
    if (arbol<>nil) then 
        begin 
            imprimirI(arbol^.HI);
            writeln('Codigo=',arbol^.dato.codigo,' Dia=',arbol^.dato.dia,' Cantidad=',arbol^.dato.cantidad);
            imprimirI(arbol^.HD);
        end;
end;

procedure imprimirII(arbol:tipoArbolII);
begin 
    if (arbol<>nil) then 
        begin 
            imprimirII(arbol^.HI);
            writeln('Codigo=',arbol^.dato.codigo,' Cantidad=',arbol^.dato.cantidad);
            imprimirII(arbol^.HD);
        end;
end;


procedure cargar(var arbolI:tipoArbolI;var arbolII:tipoArbolII);
var 
    i:integer;
    venta:tipoVenta;
    productosVendidos:tipoProductosVendidos;
begin 
    for i:=1 to random(15)+6 do 
        begin 
            ventaRandom(venta);
            agregarI(arbolI,venta);
            productosVendidos.codigo:=venta.codigo;
            productosVendidos.cantidad:=venta.cantidad;
            agregarII(arbolII,productosVendidos);
        end;
end;

procedure cantidadProductosI(arbol:tipoArbolI;codigo:integer;var cantidad:integer);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.dato.codigo=codigo) then 
                cantidad:=cantidad+arbol^.dato.cantidad;
            if (codigo<=arbol^.dato.codigo) then
                cantidadProductosI(arbol^.HI,codigo,cantidad)
            else
                cantidadProductosI(arbol^.HD,codigo,cantidad);
        end;
end;
    
procedure cantidadProductosII(arbol:tipoArbolII;codigo:integer;var cantidad:integer);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.dato.codigo=codigo) then 
                cantidad:=arbol^.dato.cantidad
            else 
                if (codigo<arbol^.dato.codigo) then
                    cantidadProductosII(arbol^.HI,codigo,cantidad)
                else
                    cantidadProductosII(arbol^.HD,codigo,cantidad);
        end;
end;


var 
    arbolI:tipoArbolI;
    arbolII:tipoArbolII;
    codigo,cantidad:integer;
begin 
    Randomize;
    arbolI:=nil;
    arbolII:=nil;
    cargar(arbolI,arbolII);

    writeln;
    writeln('ARBOL I:');
    imprimirI(arbolI);

    writeln;
    writeln('ARBOL II:');
    imprimirII(arbolII);

    writeln;
    write('Ingrese un codigo de producto a buscar: ');
    readln(codigo);
    cantidad:=0;
    cantidadProductosI(arbolI,codigo,cantidad);
    writeln('ARBOL I: ',cantidad);
    writeln;
    cantidad:=0;
    cantidadProductosII(arbolII,codigo,cantidad);
    writeln('ARBOL II: ',cantidad);
end.