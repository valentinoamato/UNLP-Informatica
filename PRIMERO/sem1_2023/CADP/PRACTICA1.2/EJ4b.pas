program test;

var 
    min1,min2,num:integer;

begin
    min1:=999;
    min2:=999;
    read(num);
    while (num<>0) do
        begin
            if (num<min1) then
                begin
                    min2:=min1;
                    min1:=num;
                end
            else if (num<min2) then
                min2:=num;
            write('Ingrese un numero: ');
            read(num);
        end;
    writeln(min1);
    writeln(min2);
end.