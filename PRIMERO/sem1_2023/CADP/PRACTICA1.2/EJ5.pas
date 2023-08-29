program test;

var
    max,min,sum,num:integer;

begin
    max:=-999;
    min:=999;
    sum:=0;
    repeat
        writeln('Ingrese un numero: ');
        read(num);
        if (num>max) then
            max:=num;
        if (num<min) then
            min:=num;
        sum:=sum+num;
    until (num=100);
    writeln('Max:',max);
    writeln('Min:',min);
    writeln('Sum:',Sum);
end.
