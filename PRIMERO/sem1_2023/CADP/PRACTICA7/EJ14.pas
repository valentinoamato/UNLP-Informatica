program test;
type 
    subrangodia=1..31;
    reglibros=record
        prestamo:integer;
        isbn:integer;
        socio:integer;
        dia:subrangodia;
    end;
    lista=^nodoisbn;
    nodoisbn=record
        cant:integer;
        isbn:integer;
        sig:lista;
    end;
    vectormes=array[subrangodia] of integer;

procedure escribir (pri:lista);
begin
    while(pri<>nil)do
        begin
            write('cant: ',pri^.cant,'isbn: ',pri^.isbn);
            pri:=pri^.sig;
        end;
end;

procedure leer (var reg:reglibros);
begin
    writeln('Ingrese nro prestamo: ');
    readln(reg.prestamo);
    writeln('Ingrese nro isbn: ');
    readln(reg.isbn);
    writeln('Ingrese nro socio: ');
    readln(reg.socio);
    writeln('Ingrese nro dia: ');
    readln(reg.dia);
end;



procedure agregar (var pri:lista;cant:integer;isbn:integer);
var
    nuevo:lista;
begin
    new(nuevo);
    nuevo^.cant:=cant;
    nuevo^.isbn:=isbn;
    nuevo^.sig:=pri;
    pri:=nuevo;
end;
    

procedure abc (var pri:lista);
var
    isbn,i,max,c,j:integer;//i cuenta las veces que se presto un libro. c cuenta los libros con socio par y prestamo impar. j cuenta la cantidad de libros
    mes:vectormes;
    reg:reglibros;
begin
    leer(reg);
    isbn:=reg.isbn;
    j:=0;
    for i:=1 to 31 do
        mes[i]:=0;
    i:=0;
    c:=0;
    max:=1;
    while (reg.isbn<>-1)do
        begin
            j:=j+1;
            if (isbn=reg.isbn)  then //puntoa
                i:=i+1
            else
                begin
                    agregar(pri,i,isbn);
                    write('se agrego ',i);
                    i:=1;
                    isbn:=reg.isbn;
                end;
            
            mes[reg.dia]:=mes[reg.dia]+1;

            if (reg.prestamo mod 2<>0) and (reg.socio mod 2=0) then
                c:=c+1;
            
            leer(reg);
        end;
    agregar(pri,i,isbn);
    for i:=1 to 31 do
        if (mes[i]>mes[max]) then
            max:=i;
    writeln('El dia con mas prestamos fue: ',max);
    writeln('j: ',j,'c: ',c);

    writeln('El porcentaje de prestamos con prestamo impar y socio par es: ',(c/j*100):0:2);
end;

            
                    
var
    pri:lista;

begin
    pri:=nil;
    abc(pri);
    escribir(pri);
end.




