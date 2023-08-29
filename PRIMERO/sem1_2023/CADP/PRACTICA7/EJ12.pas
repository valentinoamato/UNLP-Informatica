program test;
type
    subsubscripcion=1..4;
    regcliente=record
        nombre:string;
        dni:integer;
        edad:integer;
        subscripcion:subsubscripcion;
    end;
    lista=^nodo;
    nodo=record
        dato:regcliente;
        sig:lista;
    end;
    vector=array[subsubscripcion] of integer;

procedure leer (var reg:regcliente);
begin
    writeln('|||||||');
    writeln('Ingrese nombre: ');
    readln(reg.nombre);
    writeln('Ingrese dni: ');
    readln(reg.dni);
    writeln('Ingrese edad: ');
    readln(reg.edad);
    writeln('Ingrese subscripcion: ');
    readln(reg.subscripcion);
    writeln('|||||||');
end;

procedure escribir (pri:lista);
begin
    while (pri<>nil) do
        begin
            writeln('|||||||');
            writeln('nombre: ',pri^.dato.nombre);
            writeln('dni: ',pri^.dato.dni);
            writeln('edad: ',pri^.dato.edad);
            writeln('subscripciones: ',pri^.dato.subscripcion);
            writeln('|||||||');
            pri:=pri^.sig;
        end;
end;

procedure agregar (var pri:lista;reg:regcliente);
var
    nuevo:lista;
begin
    new(nuevo);
    nuevo^.sig:=pri;
    nuevo^.dato:=reg;
    pri:=nuevo;
end;

procedure cargar (var pri:lista);
var
    reg:regcliente;
begin
    leer(reg);
    write(reg.dni);
    while (reg.dni<>0) do
        begin
            agregar(pri,reg);
            leer(reg);
        end;
end;

procedure insertar (var pri:lista;reg:regcliente);
var
    actual,anterior,nuevo:lista;
begin
    actual:=pri;
    anterior:=nil;
    new(nuevo);
    nuevo^.dato:=reg;
    while (actual<>nil) and (actual^.dato.dni<reg.dni) do
        begin
            anterior:=actual;
            actual:=actual^.sig;
        end;
    
    if (anterior<>nil) then
        begin
            anterior^.sig:=nuevo;
            nuevo^.sig:=actual;
        end
    else
        begin
            nuevo^.sig:=pri;
            pri:=nuevo;
        end;
end;

procedure main(pri1:lista;var pri2:lista);
var
    ganancia:real;
    v:vector;
    i,max1,max2:integer;
begin
    ganancia:=0;
    max1:=1;
    max2:=1;
    for i:=1 to 4 do
        v[i]:=0;
    while (pri1<>nil) do
        begin
            v[pri1^.dato.subscripcion]:=v[pri1^.dato.subscripcion]+1;
            ganancia:=ganancia+pri1^.dato.subscripcion;
            if (pri1^.dato.edad>40) and (pri1^.dato.subscripcion=4) then
                insertar(pri2,pri1^.dato);
            pri1:=pri1^.sig;
        end;
    for i:=1 to 4 do
        if (v[i]>v[max1]) then
            begin
                max2:=max1;
                max1:=i;
            end
        else
            if (v[i]>v[max2]) then
                max2:=i;
        
                
    writeln('La ganancia total el: ',ganancia:0:2);
    writeln('Las subscripiones con mas clientos son: ',max1,' y ',max2);
end;
var
    pri1,pri2:lista;
begin
    pri1:=nil;
    pri2:=nil;
    cargar(pri1);
    main(pri1,pri2);
    escribir(pri2);
end.

