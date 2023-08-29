program test;

var
    c1,c2,c3:char;
    n:integer;

begin
    n:=0;
    writeln('Ingrese un caracter: ');
    readln(c1);
    writeln('Ingrese otro caracter: ');
    readln(c2);
    writeln('Ingrese otro caracter: ');
    readln(c3);
    if (c1='a')or(c1='e')or(c1='i')or(c1='o')or(c1='u') then
        n:=n+1;
    if (c2='a')or(c2='e')or(c2='i')or(c2='o')or(c2='u') then
        n:=n+1;
    if (c3='a')or(c3='e')or(c3='i')or(c3='o')or(c3='u') then
        n:=n+1;
    
    if (n=3) then
        writeln('Los tres caracteres son vocales.')
    else if (n>0) then
        writeln('Al menos un caracter no era vocal.');
        
end.
