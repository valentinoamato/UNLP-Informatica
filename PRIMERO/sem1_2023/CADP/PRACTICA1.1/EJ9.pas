program test;

var
    nuevon,total:integer;
    operacion:char;

begin

    total:=0;
    write('Ingrese la operacion deseada: ');
    read(operacion);
    repeat
        write('ingrese un numero: ');
        read(nuevon);
        if  (operacion='-') then
            total:=total-nuevon
        else if (operacion='+') then
            total:=total+nuevon
            else
                nuevon:=0;
    until (nuevon=0);
    if (total<>0) then
        write('Resultado:',total)
    else
        write('Operacion Invalida.');

end.