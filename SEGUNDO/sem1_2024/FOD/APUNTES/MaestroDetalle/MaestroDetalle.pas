//El maestro contiene a,b y cantidad.
//Los detalles (3) contienen a,b y cantidad.
//Todos los archivos se encuentran ordenados por a y b
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

procedure leer(var detalle:Text;var reg:tregistro);
begin 
    if (eof(detalle)) then 
        reg.a:=VALORALTO
    else 
        readln(detalle,reg.a,reg.b,reg.cant);
end;

procedure minimo(var min,rdet1,rdet2,rdet3:tregistro;var det1,det2,det3:Text);
var 
    m:integer;
begin 
    min:=rdet1;
    m:=1;
    if (rdet2.a<min.a) or ((rdet2.a=min.a) and (rdet2.b<min.b)) then 
        begin 
            min:=rdet2;
            m:=2;
        end;
    if (rdet3.a<min.a) or ((rdet3.a=min.a) and (rdet3.b<min.b)) then 
        begin 
            min:=rdet3;
            m:=3;
        end;
    if (m=1) then  
        leer(det1,rdet1)
    else if (m=2) then  
        leer(det2,rdet2)
    else  
        leer(det3,rdet3);
end;


procedure actualizar(var maestro:tarch;var det1,det2,det3:Text);
var 
    mae,min,actual,rdet1,rdet2,rdet3:tregistro;
begin 
    reset(maestro);
    reset(det1);
    reset(det2);
    reset(det3);

    leer(det1,rdet1);
    leer(det2,rdet2);
    leer(det3,rdet3);

    minimo(min,rdet1,rdet2,rdet3,det1,det2,det3);


    if (not eof(maestro)) then 
        read(maestro,mae);
    
    while (min.a<>VALORALTO) do 
        begin 
            actual:=min;
            actual.cant:=0;
            while (actual.a=min.a) and (actual.b=min.b) do 
                begin 
                    actual.cant:=actual.cant+min.cant;
                    minimo(min,rdet1,rdet2,rdet3,det1,det2,det3);
                end;
            
            while (actual.a<>mae.a) or (actual.b<>mae.b) do 
                read(maestro,mae);

            mae.cant:=mae.cant+actual.cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,mae);
            if (not eof(maestro)) then 
                read(maestro,mae);
        end;
end;

var 
    maestro:tarch;
    det1,det2,det3:Text;
begin 
    assign(maestro,'maestro.dat');
    assign(det1,'detalles/detalle1.txt');
    assign(det2,'detalles/detalle2.txt');
    assign(det3,'detalles/detalle3.txt');
    writeln;
    writeln('Maestro antes de actualizar: ');
    imprimirMaestro(maestro);
    actualizar(maestro,det1,det2,det3);
    writeln;
    writeln('Maestro despues de actualizar: ');
    imprimirMaestro(maestro);
end.