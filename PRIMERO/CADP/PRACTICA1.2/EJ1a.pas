program test;

var
    i,num,total,q5:integer;

begin
    total:=0;
    q5:=0;
    for i:=1 to 10 do
        begin
            write('Ingrese un numero: ');
            read(num);
            total:=total+num;
            if (num>5) then
                q5:=q5+1;
        end;
    write('total: ',total);
    write('mayores a 5: ',q5);
end. 