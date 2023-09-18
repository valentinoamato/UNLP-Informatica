// 1. El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
// de las expensas de dichas oficinas. Implementar un programa con:
// a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
// administra. Se debe leer, para cada oficina, el código de identificación, DNI del
// propietario y valor de la expensa. La lectura finaliza cuando llega el código de
// identificación -1.
// b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
// código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
// vistos en la cursada.
// c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
// generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
// retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
// Luego el programa debe informar el DNI del propietario o un cartel indicando que no
// se encontró la oficina.
// d) Un módulo recursivo que retorne el monto total de las expensas.

program test;
const
    dimf = 10; //300
type
    oficinas = record
        codigo:integer;
        dni:integer;
        valor:integer;
    end;

    vector = array [1..dimf] of oficinas;

procedure leeroficina(var reg:oficinas);
begin
    write('Codigo (0): ');
    readln(reg.codigo);
    writeln('DNI: ',reg.codigo);
    reg.dni:=reg.codigo;
    reg.valor:=random(500)+20;
end;

procedure imprimirvector(v:vector;diml:integer);
var
    i:integer;
begin
    for i:=1 to diml do
        begin
            writeln();
            write(' Codigo: ',v[i].codigo,'||');
            write(' Dni: ',v[i].dni,'||');
            write(' Valor: ',v[i].valor,'||');
        end;    
end;

procedure moduloA(var v:vector;var diml:integer);
var
    oficina:oficinas;
    i:integer;
begin
    diml:=0;
    i:=1;
    leeroficina(oficina);
    while (oficina.codigo<>0) and (i<dimf) do
        begin
            v[i]:=oficina;
            diml:=diml+1;
            i:=i+1;
            leeroficina(oficina);
        end;
end;

procedure moduloB(var v:vector;diml:integer);//insercion
var
    i,j:integer;
    actual:oficinas;
begin
    for i:=2 to diml do
        begin
            actual:=v[i];
            j:=i-1;
            while (j>0) and (v[j].codigo>actual.codigo) do
                begin
                    v[j+1]:=v[j];
                    j:=j-1;
                end;
            v[j+1]:=actual;
        end;
end;

function moduloC(v:vector;n,izq,der:integer):integer;
var
    medio:integer;
begin
    if (izq>der) then
        moduloC:=0
    else
        begin
            medio:=(der+izq) div 2;
            writeln(medio);
            if (v[medio].codigo=n) then
                moduloC:=medio
            else if (n>v[medio].codigo) then
                moduloC:=moduloC(v,n,medio+1,der)
            else
                moduloC:=moduloC(v,n,izq,medio-1);
        end;
end;

function moduloD(v:vector;diml:integer):real;
begin
    if (diml>0) then
        moduloD:=moduloD(v,diml-1)+v[diml].valor
    else 
        moduloD:=0;
end;


var
    v:vector;
    diml,n:integer;

begin
    Randomize;
    moduloA(v,diml);
    imprimirvector(v,diml);
    moduloB(v,diml);
    writeln;
    writeln('VECTOR ORDENADO:');
    imprimirvector(v,diml);
    writeln;
    write('Ingrese un numero a buscar: ');
    readln(n);
    writeln('El resultado de la busqueda es: ',moduloC(v,n,1,diml));
    writeln('El total de las expensas es: ',moduloD(v,diml):0:2);
end.

//~1:10Hrs
