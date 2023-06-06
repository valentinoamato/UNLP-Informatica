program test;

var
    num1,num2,num3:integer;

begin 
    write('ingrese un numero: ');
    read(num1);

    write('ingrese un numero: ');
    read(num2);

    write('ingrese un numero: ');
    read(num3);
    if (num1>num2) AND (num1>num3) then
        begin
            if (num2>num3) then
                writeln(num1,num2,num3)
            else
                writeln(num1,num3,num2);
        end;

    if (num2>num3) AND (num2>num1) then
        begin
            if num1>num3 then
                writeln(num2,num1,num3)
            else
                writeln(num2,num3,num1);
        end;

    if (num3>num2) AND (num3>num1) then
        begin
            if num2>num1 then
                writeln(num3,num2,num1)
            else
                writeln(num3,num1,num2);
        end;
end.