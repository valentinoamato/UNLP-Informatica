program ejercicio2;
type 
    //A-I
    tauto = record 
        patente:string;
        anno:integer;
        marca:string;
        modelo:string;
    end;

    tarbol =^ tnodo;
    tnodo = record 
        dato:tauto;
        HI:tarbol;
        HD:tarbol;
    end;

    //A-II
    tmarca = record
        patente:string;
        anno:integer;
        modelo:string;
    end;

    tmarcas =^ nodoMarcas;
    nodoMarcas = record 
        sig:tmarcas;
        dato:tmarca;
    end;

    tdatoArbolMarcas = record
        marcas:tmarcas;
        marca:string;
    end;

    tarbolMarcas =^ tnodoArbolMarcas;
    tnodoArbolMarcas = record 
        dato:tdatoArbolMarcas;
        HI:tarbolMarcas;
        HD:tarbolMarcas;
    end;

    //D
    tanno = record
        patente:string;
        marca:string;
        modelo:string;
    end;

    tlista =^ nodoLista;
    nodoLista = record
        sig:tlista;
        dato:tanno;
    end;

    tannos = array [2010..2018] of tlista;

//A-I A-II
procedure autoRandom(var auto:tauto);
begin 
    Str((random(100)+1),auto.patente);
    auto.patente:= 'patente'+auto.patente;
    auto.anno:= random(9)+2010;
    Str((random(10)),auto.marca);
    auto.marca:= 'marca'+auto.marca;
    Str((random(10)),auto.modelo);
    auto.modelo:= 'modelo'+auto.modelo;
end;

procedure imprimirAuto(auto:tauto);
begin 
    writeln(' ',auto.patente,' anno: ',auto.anno,' ',auto.marca,' ',auto.modelo);
end;

procedure agregarI(var arbol:tarbol;auto:tauto); 
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.HI:=nil;
            arbol^.HD:=nil;
            arbol^.dato:=auto;
        end
    else
        begin  
            if (auto.patente>arbol^.dato.patente) then 
                agregarI(arbol^.HD,auto)
            else 
                agregarI(arbol^.HI,auto);
        end;
end;

procedure agregarTMarcas(var pri:tmarcas;auto:tauto);
var 
    aux:tmarcas;
begin 
    new(aux);
    aux^.dato.patente:=auto.patente;
    aux^.dato.anno:=auto.anno;
    aux^.dato.modelo:=auto.modelo;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure agregarII(var arbol:tarbolMarcas;auto:tauto);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.HI:=nil;
            arbol^.HD:=nil;
            arbol^.dato.marca:=auto.marca;
            arbol^.dato.marcas:=nil;
            agregarTMarcas(arbol^.dato.marcas,auto);
        end
    else
        begin  
            if (auto.marca>arbol^.dato.marca) then 
                agregarII(arbol^.HD,auto)
            else 
                begin 
                    if (auto.marca=arbol^.dato.marca) then
                        agregarTMarcas(arbol^.dato.marcas,auto)
                    else
                        agregarII(arbol^.HI,auto);
                end;
        end;
end;

procedure cargar(var arbolI:tarbol;var arbolII:tarbolMarcas);
var 
    i:integer;
    auto:tauto;
begin 
    writeln;
    writeln('Cargando autos...');
    writeln;
    for i:=1 to (random(6)+10) do 
        begin 
            autoRandom(auto);
            write(i,'- ');
            imprimirAuto(auto);
            agregarI(arbolI,auto);
            agregarII(arbolII,auto);
        end;
end;
    
procedure imprimirI(arbol:tarbol);
begin 
    if (arbol<>nil) then    
        begin 
            imprimirI(arbol^.HI);
            imprimirAuto(arbol^.dato);
            imprimirI(arbol^.HD);
        end;
end;

procedure imprimirII(arbol:tarbolMarcas);
var 
    aux:tmarcas;
begin 
    if (arbol<>nil) then    
        begin 
            imprimirII(arbol^.HI);
            aux:=arbol^.dato.marcas;
            writeln('Marca:',arbol^.dato.marca);
            while (aux<>nil) do 
                begin 
                    writeln(' ',aux^.dato.patente,' anno: ',aux^.dato.anno,' ',aux^.dato.modelo);
                    aux:=aux^.sig;
                end;
            imprimirII(arbol^.HD);
        end;
end;

procedure modulob(arbol:tarbol;marca:string;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.marca=marca) then 
                cant:=cant+1;
            modulob(arbol^.HI,marca,cant);
            modulob(arbol^.HD,marca,cant);
        end;
end;

procedure moduloc(arbol:tarbolMarcas;marca:string;var cant:integer);
var 
    aux:tmarcas;
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.marca=marca) then 
                begin 
                    aux:=arbol^.dato.marcas;
                    while (aux<>nil) do 
                        begin 
                            cant:=cant+1;
                            aux:=aux^.sig;
                        end;
                end 
            else 
                if (marca>arbol^.dato.marca) then 
                    moduloc(arbol^.HD,marca,cant)
                else 
                    moduloc(arbol^.HI,marca,cant)
        end;
end;

procedure inicializarVector(vector:tannos);
var 
    i:integer;
begin 
    for i:=2010 to 2018 do 
        vector[i]:=nil;
end; 

procedure imprimirVector(vector:tannos);
var 
    i:integer;
    aux:tlista;
begin 
    for i:=2010 to 2018 do 
        begin 
            aux:=vector[i]; 
            while (aux<>nil) do 
                begin
                    writeln(i,': ',' ',aux^.dato.patente,' ',aux^.dato.marca,' ',aux^.dato.modelo);
                    aux:=aux^.sig;
                end;
        end;
end;

procedure agregarAnno(var vector:tannos;auto:tauto);
var 
    aux:tlista;
begin 
    new(aux);
    aux^.dato.patente:=auto.patente;
    aux^.dato.marca:=auto.marca;
    aux^.dato.modelo:=auto.modelo;
    aux^.sig:=vector[auto.anno];
    vector[auto.anno]:=aux;
end;


procedure modulod(arbol:tarbol;var vector:tannos);
begin 
    if (arbol<>nil) then 
        begin
            agregarAnno(vector,arbol^.dato);
            modulod(arbol^.HI,vector); 
            modulod(arbol^.HD,vector); 
        end;
end;
            
procedure moduloe(arbol:tarbol;patente:string;var modelo:string);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.dato.patente=patente) then 
                modelo:=arbol^.dato.modelo
            else 
                begin 
                    if (patente>arbol^.dato.patente) then 
                        moduloe(arbol^.HD,patente,modelo)
                    else 
                        moduloe(arbol^.HI,patente,modelo); 
                end;
        end; 
end;

procedure modulof(arbol:tarbolMarcas;patente:string;var modelo:string);
var 
    aux:tmarcas;
begin 
    if (arbol<>nil) then 
        begin 
            modulof(arbol^.HI,patente,modelo);
            modulof(arbol^.HD,patente,modelo);
            aux:=arbol^.dato.marcas;
            while (aux<>nil) do 
                begin 
                    if(aux^.dato.patente=patente) then 
                        modelo:=aux^.dato.modelo;
                    aux:=aux^.sig;
                end;
        end;
end;


var 
    arbolI:tarbol;
    arbolII:tarbolMarcas;
    vector:tannos;
    cant:integer;
    patente,marca,modelo:string;
begin 
    Randomize;
    arbolI:=nil;
    arbolII:=nil;

    //Modulo a)
    cargar(arbolI,arbolII);

    //ArbolI
    writeln;
    writeln('ArbolI:');
    imprimirI(arbolI);

    //ArbolII
    writeln;
    writeln('ArbolII:');
    imprimirII(arbolII);

    //modulob
    writeln;
    writeln('modulob:');
    cant:=0;
    writeln('Ingrese una marca:');
    readln(marca);
    modulob(arbolI,marca,cant);
    writeln('La cantidad de autos con marca ',marca,' es ',cant);

    //moduloc
    writeln;
    writeln('moduloc:');
    cant:=0;
    moduloc(arbolII,marca,cant);
    writeln('La cantidad de autos con marca ',marca,' es ',cant);

    //modulod
    writeln;
    writeln('modulod:');
    inicializarVector(vector);
    modulod(arbolI,vector);
    imprimirVector(vector);

    //moduloe
    writeln;
    writeln('moduloe:');
    writeln('Ingrese una patente:');
    readln(patente);
    modelo:='NO';
    moduloe(arbolI,patente,modelo);
    writeln('El auto con patente ',patente,' es ',modelo);

    //modulof
    writeln;
    writeln('modulof:');
    modelo:='NO';
    modulof(arbolII,patente,modelo);
    writeln('El auto con patente ',patente,' es ',modelo);
    
end.