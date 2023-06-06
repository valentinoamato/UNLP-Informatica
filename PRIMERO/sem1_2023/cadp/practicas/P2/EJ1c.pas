program Ejercicio3;
procedure suma(var num1: integer; var num2:integer);
begin
        num2 := num1 + num2;
        num1 := 0;
    end;
var
    i, x : integer;
begin
    read(x); { leo la variable x }
    for i:= 1 to 5 do
        suma(i,x);
    write(x); { imprimo las variable x }
end.

{
Error, no se puede modificar la variable a iterar en el for

}