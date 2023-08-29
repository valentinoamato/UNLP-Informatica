// 2.- Realizar un programa que lea números hasta leer el valor 0 e imprima, para cada número
// leído, sus dígitos en el orden en que aparecen en el número. Debe implementarse un módulo
// recursivo que reciba el número e imprima lo pedido. Ejemplo si se lee el valor 256, se debe
// imprimir 2 5 6
program P2P2;
type
    lista=^nodo;
    nodo=record
        sig:lista;
        numero:integer;
    end;

procedure ImprimirDigitos (n:integer);
var
d,m:integer;
begin
    d:=n DIV 10;
    m:=n mod 10;
    if (d<>0) then
        ImprimirDigitos(d);
    write(' ',m,' ');
end;

procedure AgregaAdelante(var pri:lista;n:integer);
var
    aux:lista;
begin
    new(aux);
    aux^.sig:=pri;
    aux^.numero:=n;
    pri:=aux;
end;

procedure CargarLista(var pri:lista);
var
    i:integer;
begin
    writeln('Ingrese un numero: ');
    readln(i);
    while (i<>0) do
        begin
            AgregaAdelante(pri,i);
            readln(i);
        end;
end;

procedure ImprimirLista( pri:lista);
begin
    while (pri<>nil)do
        begin
            writeln(pri^.numero);
            pri:=pri^.sig;
        end;
end;

procedure ImprimirDigitosLista (pri:lista);
begin
    while (pri<>nil)do
        begin
            writeln();
            ImprimirDigitos(pri^.numero);
            writeln();
            write('|-----------|');
            pri:=pri^.sig;
        end;
end;

var
    pri:lista;
    i,diml:integer;
begin
    pri:=nil;
    CargarLista(pri);
    writeln('Imprimir Lista: ');
    ImprimirLista(pri);
    writeln('Imprimir DIgitos Lista: ');
    ImprimirDigitosLista(pri);
end.