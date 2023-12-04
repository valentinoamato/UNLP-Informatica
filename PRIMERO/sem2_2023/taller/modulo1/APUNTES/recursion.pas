program test;


procedure procPotencia(x,n:integer;var res:integer);
begin
    if (n=0) then
        res:=1
    else
        if (n=1) then
            res:=x
        else
            begin
                procPotencia(x,(n-1),res);
                res:=res*x;
            end;
end;

function funcPotencia(x,n:integer):integer;
begin
    if (n=0) then
        funcPotencia:=1
    else
        if (n=1) then
            funcPotencia:=x
        else
            begin
                funcPotencia:=x*funcPotencia(x,(n-1));
            end;
end;

var
    x,n,res:integer;

begin
    writeln('Ingrese x: ');
    readln(x);
    writeln('Ingrese n: ');
    readln(n);
    procPotencia(x,n,res);
    writeln('resProcPotencia: ',res);
    writeln('resFuncPotencia: ',funcPotencia(x,n));
end.