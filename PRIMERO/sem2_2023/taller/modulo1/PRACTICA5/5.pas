program ejercicio4;
type 
    treclamo = record 
        codigo:integer;
        dni:integer;
        anno:integer;
        tipo:integer;
    end;

    treclamoReducido = record 
        codigo:integer;
        anno:integer;
        tipo:integer;
    end;

    treclamos =^ tnodoReclamos;
    tnodoReclamos = record 
        sig:treclamos;
        dato:treclamoReducido;
    end;

    tdatoArbol = record 
        dni:integer;
        reclamos:treclamos;
    end;

    tarbol =^ tnodoArbol;
    tnodoArbol = record 
        HI:tarbol;
        HD:tarbol;
        dato:tdatoArbol;
    end;

procedure reclamoRandom(var reclamo:treclamo);
begin 
    reclamo.codigo:= random(200)+1;
    write('Ingrese un dni: ');
    readln(reclamo.dni);
    reclamo.anno:= random(4)+2000;
    reclamo.tipo:= random(5)+1;
end;
    
procedure imprimirReclamo(reclamo:treclamo);
begin 
    writeln('Codigo: ',reclamo.codigo,'  dni: ',reclamo.dni,'  anno: ',reclamo.anno,'  tipo: ',reclamo.tipo);
end;

procedure imprimirReclamoReducido(reclamo:treclamoReducido);
begin 
    writeln('Codigo: ',reclamo.codigo,'  anno: ',reclamo.anno,'  tipo: ',reclamo.tipo);
end;

procedure agregarReclamos(var pri:treclamos;reclamo:treclamo);
var 
    aux:treclamos;
    reducido:treclamoReducido;
begin 
    reducido.codigo:=reclamo.codigo;
    reducido.anno:=reclamo.anno;
    reducido.tipo:=reclamo.tipo;
    new(aux);
    aux^.dato:=reducido;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure agregarArbol(var arbol:tarbol;reclamo:treclamo;var nodo:tarbol);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.dato.reclamos:=nil;
            agregarReclamos(arbol^.dato.reclamos,reclamo);
            arbol^.dato.dni:=reclamo.dni;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
            nodo:=arbol;
        end 
    else 
        begin 
            if (reclamo.dni>arbol^.dato.dni) then 
                agregarArbol(arbol^.HD,reclamo,nodo)
            else
                agregarArbol(arbol^.HI,reclamo,nodo);
        end;
end;

procedure cargar(var arbol:tarbol);
var 
    i:integer;
    reclamo:treclamo;
    ultimoDNI:integer;
    nodo:tarbol;
begin 
    ultimoDNI:=0;
    writeln('Iniciando carga...');
    for i:=1 to random(10)+10 do 
        begin 
            reclamoRandom(reclamo);
            write(i,': ');
            imprimirReclamo(reclamo);
            if (ultimoDNI<>reclamo.dni) then
                agregarArbol(arbol,reclamo,nodo)
            else 
                agregarReclamos(nodo^.dato.reclamos,reclamo);
            ultimoDNI:=reclamo.dni;
        end;
end;

procedure imprimirArbol(arbol:tarbol);
var 
    aux:treclamos;
begin 
    if (arbol<>nil) then 
        begin 
            imprimirArbol(arbol^.HI);
            aux:=arbol^.dato.reclamos;
            writeln;
            writeln('Reclamos con dni ',arbol^.dato.dni,': ');
            while (aux<>nil) do 
                begin 
                    imprimirReclamoReducido(aux^.dato);
                    aux:=aux^.sig;
                end;
            imprimirArbol(arbol^.HD);
        end;
end;

var 
    arbol:tarbol;
begin
    Randomize;
    //A
    arbol:=nil;
    cargar(arbol);
    imprimirArbol(arbol);
end.