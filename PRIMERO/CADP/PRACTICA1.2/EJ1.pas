program test;

var
    i,num,total:integer;

begin
    total:=0;
    for i:=1 to 10 do
        begin
            write('Ingrese un numero: ');
            read(num);
            total:=total+num;
        end;
    write('total: ',total);
end. 
