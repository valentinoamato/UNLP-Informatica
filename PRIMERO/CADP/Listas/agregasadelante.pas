program listas;
type
    lista = ^nodo;
    nodo = record
        sig:lista;
        num:integer;
    end;
procedure agregar (var l:lista;registro:nodo);
var
    aux:lista;
begin
    new(aux);
    aux^:=registro;
    aux^.sig:=l;
    l:=aux;
end;

procedure cargar (var l:lista);
var
    x:nodo;
begin
    read(x.num);
    while (x.num<>0) do
        begin
            agregar(l,x);
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
    l:lista;

begin
    l:=nil;
    cargar(l);
    recorrer(l);
end.