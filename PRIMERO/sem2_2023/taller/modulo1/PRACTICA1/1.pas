program ejercicio1;
const 
    maxVentas = 50;
type
    tipodia = 1..31;
    tipocodigo = 1..15;
    tipocantidad = 1..99;
    tipoventa = record 
        dia:tipodia;
        codigo:tipocodigo;
        cantidad:tipocantidad;
    end;
    tipoventas = array [1..maxVentas] of tipoventa;

    tipoVentaCodigoPar = record 
        codigo:tipocodigo;
        cantidad:tipocantidad;
    end;

    tipoVentasCodigoPar = array [1..maxVentas] of tipoVentaCodigoPar;

procedure cargar(var ventas:tipoventas;var diml:integer);
var 
    i:integer;
begin 
    diml:=random(maxVentas)+1;
    for i:=1 to diml do
        begin
            ventas[i].dia:=random(31)+1;
            ventas[i].codigo:=random(15)+1;
            ventas[i].cantidad:=random(99)+1;
        end;
end;

procedure imprimir(ventas:tipoventas;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml do 
        writeln('Venta ',i,': Dia=',ventas[i].dia,' Codigo=',ventas[i].codigo,' Cantidad=',ventas[i].cantidad,'.');
    writeln();
end;

procedure imprimirVentasCodigoPar(ventas:tipoVentasCodigoPar;dimlVentasCodigoPar:integer);
var 
    i:integer;
begin 
    writeln();
    writeln('Ventas con codigo par: ');
    for i:=1 to dimlVentasCodigoPar do 
        writeln('Venta ',i,' Codigo=',ventas[i].codigo,' Cantidad=',ventas[i].cantidad,'.');
    writeln();
end;

procedure insercion(var ventas:tipoventas;diml:integer);
var 
    i,j:integer;
    actual:tipoventa;
begin
    for i:=2 to diml do 
        begin 
            actual:=ventas[i];
            j:=i-1;

            while (j>0) and (ventas[j].codigo>actual.codigo) do 
                begin
                    ventas[j+1]:=ventas[j];
                    j:=j-1;
                end;
            ventas[j+1]:=actual;
        end;
end;

function busquedaBinaria (ventas:tipoventas;diml,codigo:integer):integer;
var 
    indiceI,indiceD,medio:integer;
begin
    indiceI:=1;
    indiceD:=diml;
    medio:=((indiceI+indiceD) div 2);
    while (indiceI<indiceD) and (ventas[medio].codigo<>codigo) do 
        begin
            medio:=((indiceI+indiceD) div 2);
            if (codigo>ventas[medio].codigo) then 
                indiceI:=medio+1
            else 
                indiceD:=medio-1;
        end;
    busquedaBinaria:=medio;
end;

procedure eliminar (var ventas:tipoventas; var diml:integer);
var 
    i,indiceI,indiceD,codigoI,codigoD,salto:integer;
    
begin 
    codigoI:=random(15)+1;
    codigoD:=random(15-codigoI)+codigoI;
    writeln('Se eliminaran todas las ventas con codigo entre ',codigoI,' y ',codigoD,'.');
    i:=1;
    while (i<diml) and (ventas[i].codigo<codigoI) do
        i:=i+1;
    indiceI:=i;
    while (i<diml) and (ventas[i].codigo<=codigoD) do
        i:=i+1;
    indiceD:=i; 

    salto:=indiceD-indiceI;
    while ((indiceI+salto)<diml) do 
        begin
            ventas[indiceI]:=ventas[indiceI+salto]; 
            indiceI:=indiceI+1;
        end;
    diml:=diml-salto;
end;

procedure modulog (ventas:tipoventas;var ventasCodPar:tipoVentasCodigoPar;diml:integer;var dimlVentasCodigoPar:integer);//Retorna la informacion de cada codigo par con su cantidad 
var 
    i:integer;
    ventaCodigoPar:tipoVentaCodigoPar;
begin 
    dimlVentasCodigoPar:=0;
    for i:=1 to diml do 
        begin
            if ((ventas[i].codigo mod 2)=0) then
                begin 
                    dimlVentasCodigoPar:=dimlVentasCodigoPar+1;
                    ventaCodigoPar.codigo:=ventas[i].codigo;
                    ventaCodigoPar.cantidad:=ventas[i].cantidad;
                    ventasCodPar[dimlVentasCodigoPar]:=ventaCodigoPar;
                end;
        end;
end; 


var 
    ventas:tipoventas;
    ventasCodigoPar:tipoVentasCodigoPar;
    diml,dimlVentasCodigoPar:integer;
begin 
    Randomize;
    cargar(ventas,diml);
    imprimir(ventas,diml);

    insercion(ventas,diml);
    imprimir(ventas,diml);

    eliminar(ventas,diml);
    imprimir(ventas,diml);

    modulog(ventas,ventasCodigoPar,diml,dimlVentasCodigoPar);
    imprimirVentasCodigoPar(ventasCodigoPar,dimlVentasCodigoPar);
end.