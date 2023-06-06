program test;

var 
    num1,num2:real;

begin
    write('ingrese un numero real: ');
    read(num1);
    repeat
        write('ingrese un numero real: ');
        read(num2);

    until ((num1*2)=num2);
end.