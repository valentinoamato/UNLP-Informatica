//Realizar un módulo que reciba un par de números (numA,numB) y retorne si numB es el doble de numA.

Program ejercicio4;
function esDoble(num1,num2 : integer) : boolean;
var 
    esdoblevar:boolean;
begin
    if (num2=(num1*2)) then
        esdoblevar:=True
    else
        esdoblevar:=False;
    esDoble:=esdoblevar;
end;

begin

    writeln(esDoble(2,4));
end.

