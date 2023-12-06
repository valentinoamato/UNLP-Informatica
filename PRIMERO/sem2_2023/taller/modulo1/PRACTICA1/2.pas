program ejercicio2;
const 
    maxOficinas=20;
type
    tipoOficina = record 
        codigo:integer;
        dni:integer;
        valor:real;
    end;

    tipoOficinas = array [1..maxOficinas] of tipoOficina;

procedure cargar(var oficinas:tipoOficinas;var diml:integer);
var 
    i:integer;
begin
    Randomize;
    diml:=random(maxOficinas)+1;
    for i:=1 to diml do 
        begin 
            oficinas[i].codigo:=random(50)+1;
            oficinas[i].dni:=random(500)+1;
            oficinas[i].valor:=random(5000)+1;
        end;
end;

procedure imprimir (oficinas:tipoOficinas;diml:integer);
var 
    i:integer;
begin 
    writeln();
    for i:=1 to diml do 
        writeln('Codigo=',oficinas[i].codigo,' DNI=',oficinas[i].dni,' Valor=',oficinas[i].valor:0:2);
    writeln();
end;

procedure insercion (var oficinas:tipoOficinas;var diml:integer);
var 
    i,j:integer;
    actual:tipoOficina;
begin 
    for i:=2 to diml do 
        begin
            actual:=oficinas[i];
            j:=i-1;

            while (j>0) and (oficinas[j].codigo>actual.codigo) do 
                begin 
                    oficinas[j+1]:=oficinas[j];
                    j:=j-1;
                end;
            oficinas[j+1]:=actual;
        end;
end;

procedure seleccion (var oficinas:tipoOficinas;diml:integer);
var 
    i,j,max:integer;
    aux:tipoOficina;
begin
    for i:=1 to diml-1 do 
        begin
            max:=i;
            for j:=i to diml do 
                begin 
                    if (oficinas[j].valor>oficinas[max].valor) then
                        max:=j;
                end;
            aux:=oficinas[max];
            oficinas[max]:=oficinas[i];
            oficinas[i]:=aux;
        end;
end;
        
         


var 
    oficinas:tipoOficinas;
    diml:integer;
begin 
    cargar(oficinas,diml);
    imprimir(oficinas,diml);

    insercion(oficinas,diml);
    writeln('Oficinas ordenadas por codigo: ');
    imprimir(oficinas,diml);
    
    seleccion(oficinas,diml);
    writeln('Oficinas ordenadas por valor: ');
    imprimir(oficinas,diml);
end.