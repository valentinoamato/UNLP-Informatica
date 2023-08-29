program ej1;
function Cumple (num: integer): boolean;
begin
    Cumple:=((num MOD 2) = 0);
end;
var
    x,y:integer;

begin
    read(x);
    read(y);
    writeln(Cumple(x));
    writeln(Cumple(y));
    
end.
