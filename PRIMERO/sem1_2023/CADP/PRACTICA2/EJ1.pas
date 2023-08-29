program Ejercicio3;
procedure suma(num1: integer; var num2:integer);
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
1,10
-0,11
2,11
13
3,13
16
4,16
20
5,20
25
Si se ingresa 10 el programa imprime 25
}