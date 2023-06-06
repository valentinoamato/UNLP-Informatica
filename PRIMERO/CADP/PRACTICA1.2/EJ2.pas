program test;

var
    i,num,max:integer;

begin
    max:=-999; //se inicializa el maximo en un numero bajo
    for i:=1 to 10 do
        begin
            write('Ingrese un numero: ');
            read(num);
            if (num>max) then
                max:=num;
        end;
    write('el numero mas grande es: ',max);

end. 