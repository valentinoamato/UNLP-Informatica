program test;

var
    i,num,max,pos:integer;

begin
    max:=-999; //se inicializa el maximo en un numero bajo
    pos:=0;
    for i:=1 to 10 do
        begin
            write('Ingrese un numero: ');
            read(num);
            if (num>max) then
                begin
                    max:=num;
                    pos:=i;
                end;
        end;
    write('el numero mas grande es: ',max,' con posicion:',pos);

end. 