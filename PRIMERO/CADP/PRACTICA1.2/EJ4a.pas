program test;

var 
    min1,min2,num:integer;

begin
    min1:=999;
    min2:=999;
    repeat
        write('Ingrese un numero: ');
        read(num);
        if (num<min1) then
            begin
                min2:=min1;
                min1:=num;
            end
        else if (num<min2) then
            min2:=num;
    until (num=0);
    writeln(min1);
    writeln(min2);
end.