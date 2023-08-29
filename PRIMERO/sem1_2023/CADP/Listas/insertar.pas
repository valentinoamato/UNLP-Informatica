program listas;
type
    lista = ^nodo;
    nodo = record
        sig:lista;
        num:integer;
    end;
procedure agregar (var pri:lista;var ult:lista;registro:nodo);
var
    aux:lista;
begin
    new(aux);
    aux^:=registro;
    aux^.sig:=nil;
    if (pri=nil) then
        pri:=aux
    else
        ult^.sig:=aux;
    ult:=aux;
end;

procedure cargar (var l:lista;var ult:lista);
var
    x:nodo;
begin
    read(x.num);
    while (x.num<>0) do
        begin
            agregar(l,ult,x);
            read(x.num);
        end;
end;

procedure recorrer (l:lista);
begin
    while (l<>nil) do
        begin
            write(l^.num);
            l:=l^.sig;
        end;
end;

procedure insertar(var pri:lista;registro:nodo);
var
    anterior,actual,reg:lista;

begin
    new(reg);
    reg^:=registro;
    actual:=pri;
    anterior:=nil;
    while (actual<>nil) and (actual^.num<reg^.num) do 
        begin
            anterior:=actual;
            actual:=actual^.sig;  
        end;
    reg^.sig:=actual;
    if (anterior<>nil) then
        anterior^.sig:=reg
    else
        pri:=reg;

end;





var
    pri:lista;
    ult:lista;
    num:integer;
    a:nodo;

begin
    pri:=nil;
    ult:=nil;
    cargar(pri,ult);
    while True do
        begin
            recorrer(pri);
            read(a.num);
            write('gola');
            insertar(pri,a);
        end;
end.