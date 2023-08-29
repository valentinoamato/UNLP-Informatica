program test;
type
    sub=1..5;
    regactor=record
        dni:integer;
        nombre:string;
        edad:integer;
        genero:sub;
    end;
    lista=^nodo;
    nodo = record
        dato:regactor;
        sig:lista;
    end;
    codigos=array [sub] of integer;

procedure escribir (pri:lista);
begin
    while (pri<>nil) do
        begin
            writeln('dni: ',pri^.dato.dni,' nombre: ',pri^.dato.nombre,' edad: ',pri^.dato.edad,' genero: ',pri^.dato.genero);
            pri:=pri^.sig;
        end;
end;

procedure leer (var reg:regactor);
begin
    writeln('ingrese dni: ');
    readln(reg.dni);
    writeln('ingrese nombre: ');
    readln(reg.nombre);
    writeln('ingrese edad: ');
    readln(reg.edad);
    writeln('ingrese genero: ');
    readln(reg.genero);
end;

procedure agregar (var pri:lista;reg:regactor);
var
    nuevo:lista;
begin
    new(nuevo);
    nuevo^.dato:=reg;
    nuevo^.sig:=pri;
    pri:=nuevo;
end;

procedure cargar (var pri:lista);
var
    reg:regactor;
begin
    repeat
        leer(reg);
        agregar(pri,reg);
    until (reg.dni=0);

end;

procedure a (pri:lista);
var
    cant,pares,num:integer;

begin
    cant:=0;
    while (pri<>nil) do
        begin
            num:=pri^.dato.dni;
            pares:=0;
            while (num<>0) do
                begin
                    if (num mod 10 mod 2=0) then
                        pares:=pares+1
                    else
                        pares:=pares-1;
                    num:=num div 10;
                end;
            if (pares>0) then
                cant:=cant+1;
            pri:=pri^.sig;
        end;
    writeln('Actores con mayoria de digitos pares en dni: ',cant);
end;
                    
procedure b (pri:lista);
var
    vector:codigos;
    i:integer;
    max1,max2:sub;
begin
    max1:=1;
    max2:=1;
    for i:=1 to 5 do
        vector[i]:=0;

    while (pri<>nil) do
        begin
            vector[pri^.dato.genero]:=vector[pri^.dato.genero]+1;
            pri:=pri^.sig;
        end;
    
    for i:=1 to 5 do
        begin
            if (vector[i]>vector[max1]) then
                begin
                    max2:=max1;
                    max1:=i;
                end
            else if (vector[i]>vector[max2]) then
                max2:=i;
        end;
    writeln('genero mas elegido',max1);
    writeln('segundo genero mas elegido',max2);

    
end;

procedure c (var pri:lista;dni:integer);
var
    anterior,actual:lista;
begin
    actual:=pri;
    anterior:=nil;
    while (actual<>nil) and (actual^.dato.dni<>dni) do
        begin
            write('dni: ',actual^.dato.dni);
            anterior:=actual;
            actual:=actual^.sig;
        end;
    if (actual<>nil) then
        begin
            if (anterior<>nil) then
                begin
                    anterior^.sig:=actual^.sig;
                end
            else
                pri:=pri^.sig;
            dispose(actual);
        end;
end;

var
    pri:lista;
    dni:integer;

begin
    pri:=nil;
    cargar(pri);
    escribir(pri);
    writeln('|||||||||||');
    a(pri);
    writeln('|||||||||||');
    b(pri);
    writeln('|||||||||||');
    writeln('Ingrese dni a eliminar: ');
    readln(dni);
    c(pri,dni);
    writeln('|||||||||||');
    escribir(pri);
end.


