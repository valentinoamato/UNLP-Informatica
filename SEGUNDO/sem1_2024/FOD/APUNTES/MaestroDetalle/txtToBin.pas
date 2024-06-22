program test;
type 
    tregistro = record 
        a:integer;
        b:integer;
        cant:integer;
    end;

    tarch = file of tregistro;

var 
    bin:tarch;
    txt:Text;
    reg:tregistro;
begin 
    assign(bin,'maestro.dat');
    assign(txt,'maestro.txt');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin 
            readln(txt,reg.a,reg.b,reg.cant);
            write(bin,reg);
        end;
    close(bin);
    close(txt);
end.