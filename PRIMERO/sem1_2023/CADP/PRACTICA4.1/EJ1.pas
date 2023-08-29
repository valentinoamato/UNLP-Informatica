program sumador;
type
    vnums = array [1..10] of integer;
var
    numeros : vnums;
    i : integer;
begin
    for i:=1 to 10 do {primer bloque for}
        begin
            numeros[i] := i;
            write(numeros[i]);
        end;

    // for i:=1 to 9 do        
    //     begin
    //         numeros[i+1] := numeros[i+1] + numeros [i];
    //         write(numeros[i+1]);
    //     end;
for i:=1 to 9 do
    begin
        numeros[i+1] := numeros[i];
        write(numeros[i]);
    end;
end.
