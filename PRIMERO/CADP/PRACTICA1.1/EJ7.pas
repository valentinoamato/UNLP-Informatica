program siete;
const
    dif=0.1;
var
    codigo:integer;
    precioa,preciob:real;

begin

    repeat
        write('ingrese el codigo del producto:');
        read(codigo);
        write('ingrese el precio anterior del producto:');
        read(precioa);
        write('ingrese el nuevo precio del producto:');
        read(preciob);
        if ((preciob-precioa)>precioa*dif) then
            writeln('El aumento de precio del producto ',codigo,' es superior al 10%')
        else
            writeln('El aumento de precio del producto ',codigo,' no es superior al 10%');

    until (codigo=32767);
 end.