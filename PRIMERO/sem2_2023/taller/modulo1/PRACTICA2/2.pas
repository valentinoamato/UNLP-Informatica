program ejercicio2;

procedure imprimirDigitos(n:integer);
begin 
    if (n<>0) then 
        begin
            imprimirDigitos(n div 10);
            write(' ',(n mod 10));
        end;
end;

procedure leerNumeros();
var 
    n:integer;
begin 
    writeln();
    write('Ingrese un numero:');
    readln(n);
    while (n<>0) do 
        begin  
            imprimirDigitos(n);
            writeln();
            write('Ingrese un numero:');
            readln(n);
        end;
end;

begin 
    leerNumeros();
end.