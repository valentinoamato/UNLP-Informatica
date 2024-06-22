///3 detalles con a,b y cant.
///Generar maestro con a,b y cant.
///Todos los archivos ordenados por a,b.
program apunte;
const 
    VALORALTO = 9999;
type 
    tregistro = record 
        a:integer;
        b:integer;
        cant:integer;
    end;

    tarch = file of tregistro;

procedure leer(var detalle:Text;var reg:tregistro);
begin 
    if (eof(detalle)) then 
        reg.a:=VALORALTO
    else 
        readln(detalle,reg.a,reg.b,reg.cant);
end;

procedure imprimirMaestro(var maestro:tarch);
var 
    reg:tregistro;
begin 
    reset(maestro);
    while (not eof(maestro)) do 
        begin 
            read(maestro,reg);
            writeln('A: ',reg.a,', B: ',reg.b,', Cant: ',reg.cant);
        end;
    close(maestro);
end;

procedure minimo(var det1,det2,det3: Text;var min, rdet1,rdet2,rdet3:tregistro);
var 
    i_min:integer;
begin 
    i_min:=1;
    min:=rdet1;
    if (rdet2.a<min.a) or ((rdet2.a=min.a) and (rdet2.b<min.b)) then 
        begin 
            i_min:=2;
            min:=rdet2;
        end;
    if (rdet3.a<min.a) or ((rdet3.a=min.a) and (rdet3.b<min.b)) then 
        begin 
            i_min:=3;
            min:=rdet3;
        end;
    if (i_min=1) then 
        leer(det1,rdet1)
    else if (i_min=2) then 
        leer(det2,rdet2)
    else 
        leer(det3,rdet3);
end;

procedure merge(var maestro:tarch;var det1,det2,det3:text);
var 
    min,actual,rdet1,rdet2,rdet3:tregistro;
begin 
    rewrite(maestro);
    reset(det1);
    reset(det2);
    reset(det3);
    leer(det1,rdet1);
    leer(det2,rdet2);
    leer(det3,rdet3);
    minimo(det1,det2,det3,min,rdet1,rdet2,rdet3);
    while (min.a<>VALORALTO) do 
        begin 
            actual:=min;
            actual.cant:=0;
            while (actual.a=min.a) and (actual.b=min.b) do 
                begin 
                    actual.cant:=actual.cant+min.cant;
                    minimo(det1,det2,det3,min,rdet1,rdet2,rdet3);
                end;
            write(maestro,actual);
        end;        
    close(maestro);
    close(det1);
    close(det2);
    close(det3);
end;

var 
    maestro:tarch;
    det1,det2,det3:Text;
begin 
    assign(maestro,'merge.dat');
    assign(det1,'detalles/detalle1.txt');
    assign(det2,'detalles/detalle2.txt');
    assign(det3,'detalles/detalle3.txt');
    merge(maestro,det1,det2,det3);
    writeln;
    writeln('Maestro generado: ');
    imprimirMaestro(maestro);
end.