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

var
    pri:lista;
    ult:lista;

begin
    pri:=nil;
    ult:=nil;
    cargar(pri,ult);
    recorrer(pri);
end.