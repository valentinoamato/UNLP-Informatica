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
var
    numA,numB,n,ndobles:integer;
begin
    n:=0;
    ndobles:=0;
    read(numA);
    read(numB);
    while (numA<>0) or (numB<>0) do
        begin
            n:=n+1;
            if (esDoble(numA,numB)) then
                ndobles:=ndobles+1;
            read(numA);
            read(numB);
        end;
    writeln(n,ndobles);
end.
