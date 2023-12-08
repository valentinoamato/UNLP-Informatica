program ejercicio1;
type 
    tipoSocio = record 
        codigo:integer;
        nombre:string;
        edad:integer;
    end;

    tipoArbol =^ tipoNodo;
    tipoNodo = record 
        dato:tipoSocio;
        HI:tipoArbol;
        HD:tipoArbol;
    end;

procedure agregar(var arbol:tipoArbol;socio:tipoSocio);
begin 
    if (arbol=nil) then 
        begin 
            new(arbol);
            arbol^.dato:=socio;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end
    else
        if (socio.codigo<=arbol^.dato.codigo) then 
            agregar(arbol^.HI,socio)
        else
            agregar(arbol^.HD,socio);
end;

procedure socioRandom(var socio:tipoSocio);
var 
    s:string;
begin 
    socio.codigo:=random(200)+1;
    Str(socio.codigo,s);
    socio.nombre:='Socio '+s;
    socio.edad:=random(70)+10;
end;

procedure cargar(var arbol:tipoArbol);
var 
    socio:tipoSocio;
    i:integer;
begin 
    for i:=1 to random(15)+6 do 
        begin 
            socioRandom(socio);
            agregar(arbol,socio);
        end;
end;

procedure imprimirSocio(socio:tipoSocio);
begin 
    writeln('Codigo= ',socio.codigo,' Nombre=',socio.nombre,' Edad=',socio.edad);
end;

procedure imprimir(arbol:tipoArbol);
begin 
    if (arbol<>nil) then 
        begin 
            imprimir(arbol^.HI);
            imprimirSocio(arbol^.dato);
            imprimir(arbol^.HD);
        end;
end;

procedure imprimirPares(arbol:tipoArbol);
begin 
    if (arbol<>nil) then 
        begin 
            imprimirPares(arbol^.HD);
            if ((arbol^.dato.codigo mod 2)=0) then 
                imprimirSocio(arbol^.dato);
            imprimirPares(arbol^.HI);
        end;
end;

procedure codigoMaximo (arbol:tipoArbol;var maximo:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.HD=nil) then 
                maximo:=arbol^.dato.codigo
            else 
                codigoMaximo(arbol^.HD,maximo);
        end;
end;

procedure codigoMinimo (arbol:tipoArbol;var minimo:tipoSocio);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.HI=nil) then 
                minimo:=arbol^.dato
            else 
                codigoMinimo(arbol^.HI,minimo);
        end;
end;

procedure edadMaxima (arbol:tipoArbol;var socio:tipoSocio);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.edad>socio.edad) then 
                socio:=arbol^.dato;
            edadMaxima(arbol^.HI,socio);
            edadMaxima(arbol^.HD,socio);
        end;
end;

procedure aumentarEdad (arbol:tipoArbol);
begin 
    if (arbol<>nil) then 
        begin 
            arbol^.dato.edad:=arbol^.dato.edad+1;
            aumentarEdad(arbol^.HI);
            aumentarEdad(arbol^.HD);
        end;
end;

procedure buscarCodigo(arbol:tipoArbol;codigo:integer;var resultado:boolean);
begin 
    if (arbol<>nil) then 
        begin 
            if (codigo=arbol^.dato.codigo) then 
                resultado:=True
            else 
                if (codigo<arbol^.dato.codigo) then 
                    buscarCodigo(arbol^.HI,codigo,resultado)
                else
                    buscarCodigo(arbol^.HD,codigo,resultado);
        end;
end;

procedure buscarNombre(arbol:tipoArbol;nombre:string;var resultado:boolean);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.nombre=nombre) then 
                resultado:=True;
            buscarNombre(arbol^.HI,nombre,resultado);
            buscarNombre(arbol^.HD,nombre,resultado);
        end;
end;

procedure cantidadSocios(arbol:tipoArbol;var cantidad:integer);
begin 
    if (arbol<>nil) then 
        begin 
            cantidad:=cantidad+1;
            cantidadSocios(arbol^.HI,cantidad);
            cantidadSocios(arbol^.HD,cantidad);
        end;
end;

procedure sumaEdad(arbol:tipoArbol;var total:integer);
begin 
    if (arbol<>nil) then 
        begin 
            total:=total+arbol^.dato.edad;
            sumaEdad(arbol^.HI,total);
            sumaEdad(arbol^.HD,total);
        end;
end;

var 
    arbol:tipoArbol;
    socio:tipoSocio;
    M,n:integer;
    resultado:boolean;
    nombre:string;
begin 
    Randomize;
    arbol:=nil;

    cargar(arbol);      //a

    imprimir(arbol);    //b-IX
    
    writeln;    //b-I
    codigoMaximo(arbol,M); 
    writeln('El numero de socio mas grande es: ',M);

    writeln;    //b-II
    socio.codigo:=999;  
    codigoMinimo(arbol,socio);
    write('El socio con numero de socio mas chico es: ');
    imprimirSocio(socio);

    writeln;    //b-III
    socio.edad:=-999;  
    edadMaxima(arbol,socio);
    writeln('El numero de socio con mayor edad es: ',socio.edad);

    writeln;    //b-IV
    aumentarEdad(arbol);    
    writeln('Edad de los socios aumentada en 1:');
    imprimir(arbol);

    writeln;    //b-V
    write('Ingrese un numero de socio a buscar: ');
    readln(M);
    resultado:=False;
    buscarCodigo(arbol,M,resultado);
    writeln('El resultado de la busqueda fue: ',resultado);

    writeln;    //b-VI
    write('Ingrese un nombre de socio a buscar: ');
    readln(nombre);
    resultado:=False;
    buscarNombre(arbol,nombre,resultado);
    writeln('El resultado de la busqueda fue: ',resultado);

    writeln;    //b-VII
    M:=0;
    cantidadSocios(arbol,M);
    writeln('La cantidad de socios es: ',M);

    writeln;    //b-VIII
    M:=0;
    sumaEdad(arbol,M);
    n:=0;
    cantidadSocios(arbol,n);
    writeln('La edad promedio es: ',(M/n):0:2);    

    writeln;    //b-X
    writeln('Los socios con numero par son:');
    imprimirPares(arbol);
end.