program test;
const 
    VALORALTO = 9999;
type 
    tingreso =  record 
        codigo:integer;
        nombre:string[25];
        monto:real;
    end;

procedure leer(var ingresos:Text;var aux:tingreso);
begin 
    if (not eof(ingresos)) then 
        readln(ingresos,aux.codigo,aux.monto,aux.nombre)
    else 
        aux.codigo:=VALORALTO;
end;

procedure comprimir();
var 
    ingresos:Text;
    comprimido:Text;
    aux,acumular:tingreso;
begin 
    assign(ingresos,'ingresos.txt');
    assign(comprimido,'comprimido.txt');
    reset(ingresos);
    rewrite(comprimido);
    leer(ingresos,aux);
    while (aux.codigo<>VALORALTO) do 
        begin
            acumular:=aux;
            acumular.monto:= 0;
            while (aux.codigo=acumular.codigo) do 
                begin 
                    acumular.monto:=acumular.monto+aux.monto;
                    leer(ingresos,aux);
                end;
            writeln(comprimido,acumular.codigo,' ',acumular.monto:0:2,acumular.nombre);
        end;
    close(ingresos);
    close(comprimido);
end;

begin 
    comprimir();
end.