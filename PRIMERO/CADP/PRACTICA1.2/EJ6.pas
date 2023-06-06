program test;
type
    subrango = 1..200;
var
    codigo:subrango;
    i,precio,cant,pmin1,pmin2,cmin1,cmin2:integer;

begin
    pmin1:=-999;
    pmin2:=-999;
    cmin1:=0;
    cmin2:=0;
    cant:=0;

    for i:=1 to 20 do
        begin
            write('Ingrese el codigo del producto: ');
            read(codigo);
            write('Ingrese el precio del producto: ');
            read(precio);
            if (precio<pmin1) then
                begin
                pmin2:=pmin1;

        end;
end.