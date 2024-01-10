program ejercicio1;
const 
    maxOficinas = 30;
type 
    toficina = record 
        codigo:integer;
        dni:integer;
        valor:real;
    end; 

    toficinas = array [1..maxOficinas] of toficina;

procedure oficinaRandom(var oficina:toficina);
begin 
    oficina.codigo:=random(100)+1;
    oficina.dni:=random(200)+1;
    oficina.valor:=(random(100)+1)/(random(100)+1);
end;

procedure imprimirOficina(oficina:toficina);
begin 
    writeln('Codigo=',oficina.codigo,' DNI=',oficina.dni,' Valor=',oficina.valor:0:2);
end;

procedure cargar(var oficinas:toficinas;var diml:integer);
var 
    i:integer;
    oficina:toficina;
begin 
    diml:=(random((maxOficinas div 2) + 1) + (maxOficinas div 2) + (maxOficinas mod 2));
    for i:=1 to diml do 
        begin 
            oficinaRandom(oficina);
            oficinas[i]:=oficina;
        end;
end;

procedure imprimir(oficinas:toficinas;diml:integer);
var 
    i:integer;
begin 
    for i:=1 to diml do 
        begin 
            write(i,': ');
            imprimirOficina(oficinas[i]);
        end;
end;

procedure insercion(var oficinas:toficinas;diml:integer);
var 
    i,j:integer;
    actual:toficina;
begin 
    for i:=2 to diml do
        begin 
            j:=i-1;
            actual:=oficinas[i];
            while (j>0) and (actual.codigo<oficinas[j].codigo) do 
                begin 
                    oficinas[j+1]:=oficinas[j];
                    j:=j-1;
                end;
            oficinas[j+1]:=actual;
        end;
end;

procedure busqueda(oficinas:toficinas;diml,codigo:integer;var pos:integer);
var 
    medio,indiceI,indiceD:integer;
begin 
    indiceI:=1;
    indiceD:=diml;
    while (indiceI<=indiceD) and (pos=0) do 
        begin 
            medio:=(indiceI+indiceD) div 2;
            if (codigo=oficinas[medio].codigo) then 
                pos:=medio
            else 
                begin
                    if (codigo<oficinas[medio].codigo) then
                        indiceD:=medio-1
                    else
                        indiceI:=medio+1;   
                end;
        end;
end;

function totalExpensas(oficinas:toficinas;diml,pos:integer;total:real):real;
begin 
    if (pos<diml) then 
        totalExpensas:=totalExpensas(oficinas,diml,pos+1,total) + oficinas[pos].valor
    else 
        totalExpensas:=oficinas[pos].valor;
end;

var 
    oficinas:toficinas;
    diml,codigo,pos:integer;
    total:real;
begin 
    Randomize;
    //a
    cargar(oficinas,diml);
    writeln('A:');
    imprimir(oficinas,diml);

    //b
    writeln;
    insercion(oficinas,diml);
    writeln('B:');
    imprimir(oficinas,diml);

    //c
    writeln;
    writeln('C:');
    write('Ingrese un codigo de oficina: ');
    readln(codigo);
    pos:=0;
    busqueda(oficinas,diml,codigo,pos);
    if (pos<>0) then 
        writeln('El DNI del propietario de la oficina ',codigo,', es: ',oficinas[pos].dni)
    else 
        writeln('No se ha encontrado una oficina con codigo ',codigo);

    //d
    writeln;
    total:=0;
    pos:=1;
    writeln('D:');
    writeln('El total de las expensas es: ',totalExpensas(oficinas,diml,pos,total):0:2);
end.