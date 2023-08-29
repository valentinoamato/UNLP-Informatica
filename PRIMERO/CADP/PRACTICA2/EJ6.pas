//Realizar un módulo que reciba un par de números (precioA,precioB) y retorne si precioB es el doble de precioA.

Program ejercicio4;
procedure minimos (codigo,precio:integer;var min1,min2,codigomin1,codigomin2:integer);
begin
    if (precio<min1) then
        begin
            min2:=min1;
            codigomin2:=codigomin1;
            min1:=precio;
            codigomin1:=codigo;
        end
    else if (precio<min2) then
        begin
            min2:=precio;
            codigomin2:=codigo;
        end;
end;
function esMaximo(precio,max : integer) : integer;
var 
    nmax:integer;
begin
    if (precio>max) then
        nmax:=precio
    else
        nmax:=max;
    esMaximo:=nmax;
end;
var
    precio,min1,min2,max,i,sumaprecios,codigo,codigomin1,codigomin2,codigomax:integer;
    promedio:real;
    tipo:string;
begin
    precio:=0;
    min1:=999;
    min2:=999;
    max:=-999; //inicializo con un precioaksdnajsdnaJNSJAND
    sumaprecios:=0;
    for i:=1 to 5 do 
        begin
            writeln('precio: ');
            readln(precio);
            writeln('codigo: ');
            readln(codigo);
            writeln('tipo: ');
            readln(tipo);
            sumaprecios:=sumaprecios+precio;
            minimos(codigo,precio,min1,min2,codigomin1,codigomin2);
            if (tipo='pantalon') then
                begin
                    max:=esMaximo(precio,max);
                    codigomax:=codigo;
                end;
        end;
        promedio:=sumaprecios/5;

        writeln('min1',codigomin1,'min2',codigomin2,'max',codigomax,'promedio',promedio,0:2);
        write(promedio:0:2)
        
end.
