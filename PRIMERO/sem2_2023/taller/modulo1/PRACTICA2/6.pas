program ejercicio6;



procedure binario(var n:integer;b:integer);
begin 
    if ((n-b)>0) then 
        begin 
            binario(n,b*2);
        end;
    if ((n-b)>=0) then 
        begin 
            write('1');
            n:=n-b;
        end
    else 
        write('0');
end;

procedure leerNumero();
var 
    i:integer;
begin 
    write('Ingrese un numero: ');
    readln(i);
    while (i<>0) do
        begin 
            write('La reprentacion binaria de ',i,' es: ');
            binario(i,1);
            writeln();
            writeln();
            writeln();
            write('Ingrese un numero: ');
            readln(i);
        end;
end;

begin 
    leerNumero();
end.