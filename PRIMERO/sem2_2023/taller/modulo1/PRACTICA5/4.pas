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

    //D 

    tcodigos =^ tnodoCodigos;
    tnodoCodigos = record
        sig:tcodigos;
        codigo:integer;
    end;

procedure reclamoRandom(var reclamo:treclamo);
begin 
    reclamo.codigo:= random(200)+1;
    reclamo.dni:= random(10)+1;
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

procedure agregarArbol(var arbol:tarbol;reclamo:treclamo);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.dato.reclamos:=nil;
            agregarReclamos(arbol^.dato.reclamos,reclamo);
            arbol^.dato.dni:=reclamo.dni;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end 
    else 
        begin 
            if (arbol^.dato.dni=reclamo.dni) then 
                begin 
                    agregarReclamos(arbol^.dato.reclamos,reclamo);
                end 
            else 
                begin 
                    if (reclamo.dni>arbol^.dato.dni) then 
                        agregarArbol(arbol^.HD,reclamo)
                    else
                        agregarArbol(arbol^.HI,reclamo);
                end;
        end;
end;

procedure cargar(var arbol:tarbol);
var 
    i:integer;
    reclamo:treclamo;
begin 
    writeln('Iniciando carga...');
    for i:=1 to random(10)+10 do 
        begin 
            reclamoRandom(reclamo);
            write(i,': ');
            imprimirReclamo(reclamo);
            agregarArbol(arbol,reclamo);
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

procedure modulob(arbol:tarbol;dni:integer;var cant:integer);
var 
    aux:treclamos;
begin 
    if (arbol<>nil) then 
        begin 
            if (dni=arbol^.dato.dni) then 
                begin
                    aux:=arbol^.dato.reclamos;
                    while (aux<>nil) do
                        begin 
                            cant:=cant+1;
                            aux:=aux^.sig;
                        end;
                end
            else 
                begin 
                    if (dni>arbol^.dato.dni) then 
                        modulob(arbol^.HD,dni,cant)
                    else   
                        modulob(arbol^.HI,dni,cant);
                end;
        end;
end;

procedure moduloc(arbol:tarbol;dniA,dniB:integer;var cant:integer);
var 
    aux:treclamos;
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.dni>dniA) and (arbol^.dato.dni<dniB) then 
                begin
                    aux:=arbol^.dato.reclamos;
                    while (aux<>nil) do
                        begin 
                            cant:=cant+1;
                            aux:=aux^.sig;
                        end;
                    moduloc(arbol^.HI,dniA,dniB,cant);
                    moduloc(arbol^.HD,dniA,dniB,cant);
                end
            else 
                begin 
                    if (arbol^.dato.dni>dniA) then 
                        moduloc(arbol^.HI,dniA,dniB,cant)
                    else   
                        moduloc(arbol^.HD,dniA,dniB,cant);
                end;
        end;
end;

procedure imprimirCodigos(pri:tcodigos);
begin 
    while (pri<>nil) do 
        begin 
            writeln(pri^.codigo);
            pri:=pri^.sig;
        end;
end;

procedure agregarCodigo(var pri:tcodigos;codigo:integer);
var 
    aux:tcodigos;
begin 
    new(aux);
    aux^.codigo:=codigo;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure modulod(arbol:tarbol;var codigos:tcodigos;anno:integer);
var 
    aux:treclamos;
begin
    if (arbol<>nil) then 
        begin 
            modulod(arbol^.HI,codigos,anno);
            modulod(arbol^.HD,codigos,anno);
            aux:=arbol^.dato.reclamos;
            while (aux<>nil) do
                begin 
                    if (aux^.dato.anno=anno) then 
                        agregarCodigo(codigos,aux^.dato.codigo);
                    aux:=aux^.sig;
                end;
        end;
end;


var 
    arbol:tarbol;
    anno,cant,dni,dniA,dniB:integer;
    codigos:tcodigos;
begin
    Randomize;
    arbol:=nil;
    codigos:=nil;

    //A
    cargar(arbol);
    imprimirArbol(arbol);

    //B
    writeln;
    writeln('B:');
    write('Ingrese un DNI:');
    readln(dni);
    cant:=0;
    modulob(arbol,dni,cant);
    writeln('Hay ',cant,' reclamos con el DNI ',dni,'.');

    //C
    writeln;
    writeln('C:');
    write('Ingrese un DNI:');
    readln(dniA);
    write('Ingrese otro DNI:');
    readln(dniB);
    cant:=0;
    moduloc(arbol,dniA,dniB,cant);
    writeln('Hay ',cant,' reclamos con el DNI entre ',dniA,' y ',dniB,'.');

    //D
    writeln;
    writeln('D:');
    write('Ingrese un anno:');
    readln(anno);
    modulod(arbol,codigos,anno);
    writeln('Los codigos de los reclamos con anno ',anno,' son:');
    imprimirCodigos(codigos);

end.