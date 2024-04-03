program test;
type 
    tingreso =  record 
        codigo:integer;
        nombre:string[25];
        monto:real;
    end;

procedure comprimir();
var 
    ingresos:Text;
    comprimido:Text;
    leer,acumular:tingreso;
begin 
    assign(ingresos,'ingresos.txt');
    assign(comprimido,'comprimido.txt');
    reset(ingresos);
    rewrite(comprimido);

    readln(ingresos,leer.codigo,leer.monto,leer.nombre);
    while (not eof(ingresos)) do 
        begin
            acumular:=leer;
            acumular.monto:= 0;
            while (leer.codigo=acumular.codigo) and (not eof(ingresos)) do 
                begin 
                    acumular.monto:=acumular.monto+leer.monto;
                    readln(ingresos,leer.codigo,leer.monto,leer.nombre);
                end;
            writeln(comprimido,acumular.codigo,' ',acumular.monto:0:2,acumular.nombre);
        end;
    close(ingresos);
    close(comprimido);
end;

begin 
    comprimir();
end.