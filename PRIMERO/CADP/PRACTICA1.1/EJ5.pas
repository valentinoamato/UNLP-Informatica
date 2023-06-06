program test;

var 
    num1,num2:real;
    num3:integer;
begin
    num3:=0;
    write('ingrese un numero real: ');
    read(num1);
    repeat
        write('ingrese un numero real: ');
        read(num2);
        num3:=num3+1;
    until (((num1*2)=num2) OR (num3=10));
end.