program hello;

var 
    num:integer;
begin
    write('ingrese un numero: ');
    read(num);
    if num >= 0 then
        write(num)
    else
        write(num*-1);
end.