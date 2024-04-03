program test;

Uses sysutils;
const 
    valoralto = 9999;
type 
    tproducto =  record 
        codigo:integer;
        nombre:string[25];
        precio:real;
        actual:integer;
		minimo:integer;
    end;

    tdetalle = record 
        codigo:integer;
        cant:integer;
    end;

    tbin = file of tproducto;

procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.codigo:=valoralto
    else 
        readln(det,regd.codigo,regd.cant);
end;

procedure imprimirProducto(p:tproducto);
begin 
    writeln('Codigo: ',p.codigo,' Nombre: ',p.nombre,' Precio: ',p.precio:0:2,' Stock Actual: ',p.actual,' Stock Minimo: ',p.minimo);
end;

procedure imprimirBin(var bin:tbin);
var 
    producto:tproducto;
begin 
    reset(bin);
    writeln;
    writeln('Los productos en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,producto);
            imprimirProducto(producto);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tproducto;
begin 
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,reg.codigo,reg.precio,reg.actual,reg.minimo,reg.nombre);
            reg.nombre:=trim(reg.nombre);
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure actualizar(var maestro:tbin;var detalle:Text);
var 
    regm:tproducto;
    regd:tdetalle;
    ventas,codigo:integer;
begin 
    reset(detalle);
    reset(maestro);

    leer(detalle,regd);
    read(maestro,regm);
    while (regd.codigo<>valoralto) do 
        begin
            codigo:=regd.codigo;
            ventas:=0;

            while (codigo=regd.codigo) do 
                begin 
                    ventas:=ventas+regd.cant;
                    leer(detalle,regd);
                end;
            while (regm.codigo<>codigo) do 
                read(maestro,regm);
            regm.actual:=regm.actual-ventas;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(detalle);
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
end;

procedure listar(var bin:tbin);
var 
    txt:Text;
    p:tproducto;
begin 
    assign(txt,'stock_minimo.txt');
    rewrite(txt);
    reset(bin);
    while (not eof(bin)) do 
        begin 
            read(bin,p);
            if (p.actual<p.minimo) then 
                writeln(txt,p.codigo,' ',p.precio:0:2,' ',p.actual,' ',p.minimo,' ',trim(p.nombre));
        end;
    writeln('Los productos con stock menor al minimo han sido listados en stock_minimo.txt');
    close(txt);
    close(bin);
end;

procedure runMenu();
var 
    detalle,maestro:Text;
    bin:tbin;
    opcion:string;
begin 
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    assign(detalle,'detalle.txt');

    while (True) do     
        begin 
            writeln;
            writeln;
            writeln('Ingrese la operacion deseada:');
            writeln('1 - Imprimir productos.');
            writeln('2 - Actualizar datos.');
            writeln('3 - Listar productos con stock menor al minimo.');
            writeln('4 - Finalizar programa.');
            write('--> ');
            readln(opcion);
            case opcion of 
                '1': imprimirBin(bin);
                '2': actualizar(bin,detalle);
                '3': listar(bin);
                '4': break;
            else 
                writeln('La operacion ingresada es invalida.');
            end;
        end;
end;

begin 
    runMenu();
end.