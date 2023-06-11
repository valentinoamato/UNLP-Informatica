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
procedure buscar(pri:lista;num:integer);
begin
    while (pri<>nil) and (pri^.num<num) do 
            pri:=pri^.sig;  

    if (pri<>nil) and (pri^.num=num) then
        write('existe')
    else
        write('no existe');
end;


procedure eliminar(var pri:lista;num:integer);
var
    actual,anterior:lista;
begin
    actual:=pri;
    while (actual<>nil) and (actual^.num<>num) do 
        begin
            anterior:=actual;
            actual:=actual^.sig;  
        end;    

    if (actual<>nil) then
        begin
            if (actual = pri) then
                pri:=pri^.sig
            else
                anterior^.sig:=actual^.sig;
        end;

    dispose(actual);

end;

procedure eliminarv2(var pri:lista;num:integer);
var
    actual,anterior:lista;
begin
    actual:=pri;
    anterior:=nil;
    while (actual<>nil) and (actual^.num<>num) do
        begin
            anterior:=actual;
            actual:=actual^.sig;
        end;
    if (anterior<>nil) then
        anterior^.sig:=actual^.sig
    else
        if (pri<>nil) then
            pri:=pri^.sig;
    dispose(actual);
end;


var
    pri:lista;
    ult:lista;
    num:integer;

begin
    pri:=nil;
    ult:=nil;
    cargar(pri,ult);
    while True do
        begin
            recorrer(pri);
            read(num);
            write('gola');
            eliminarv2(pri,num);
        end;
end.