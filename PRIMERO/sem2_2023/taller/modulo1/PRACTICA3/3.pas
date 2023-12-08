program ejercicio3;
type 
    tipoFinal = record 
        nota:integer;
        codigo:integer;
    end;

    tipoFinales =^ nodoFinales;
    nodoFinales = record 
        dato:tipoFinal;
        sig:tipoFinales;
    end;

    tipoAlumno = record 
        legajo:integer;
        dni:integer;
        anno:integer;
        finales:tipoFinales;
    end;

    tipoArbol = ^ tipoNodo;
    tipoNodo = record 
        dato:tipoAlumno;
        HI:tipoArbol;
        HD:tipoArbol;
    end;

    tipoAlumnoB = record 
        dni:integer;
        anno:integer;
    end;

    tipoArbolB = ^ tipoNodoB;
    tipoNodoB = record 
        dato:tipoAlumnoB;
        HI:tipoArbolB;
        HD:tipoArbolB;
    end;

    tipoPromedio = record 
        legajo:integer;
        promedio:real;
    end;

    tipoPromedios = ^ nodoPromedio;
    nodoPromedio = record 
        sig:tipoPromedios;
        dato:tipoPromedio;
    end;

procedure agregarFinal(var alumno:tipoAlumno;final:tipoFinal);
var 
    aux:tipoFinales;
begin 
    new(aux);
    aux^.dato:=final;
    aux^.sig:=alumno.finales;
    alumno.finales:=aux;
end;

procedure finalRandom(var final:tipoFinal);
begin 
    final.codigo:=random(200)+1;
    final.nota:=random(10)+1;
end;

procedure alumnoRandom(var alumno:tipoAlumno);
var 
    final:tipoFinal;
    i:integer;
begin
    alumno.legajo:=random(1000)+1;
    alumno.dni:=random(500)+1;
    alumno.anno:=random(24)+2000;
    alumno.finales:=nil;
    for i:=1 to random(6)+5 do 
        begin 
            finalRandom(final);
            agregarFinal(alumno,final);
        end;
end;

procedure agregarAlumno(var arbol:tipoArbol;alumno:tipoAlumno);
begin 
    if (arbol=nil) then 
        begin
            new(arbol);
            arbol^.dato:=alumno;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end 
    else 
        if (alumno.legajo<=arbol^.dato.legajo) then  
            agregarAlumno(arbol^.HI,alumno)
        else 
            agregarAlumno(arbol^.HD,alumno);
end;

procedure agregarAlumnoB(var arbol:tipoArbolB;alumno:tipoAlumnoB);
begin 
    if (arbol=nil) then 
        begin
            new(arbol);
            arbol^.dato:=alumno;
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end 
    else 
        if (alumno.dni<=arbol^.dato.dni) then  
            agregarAlumnoB(arbol^.HI,alumno)
        else 
            agregarAlumnoB(arbol^.HD,alumno);
end;

procedure cargar(var arbol:tipoArbol);
var 
    i:integer;
    alumno:tipoAlumno;
begin 
    writeln('Iniciando carga del arbol A:');
    for i:=1 to random(11)+5 do 
        begin 
            alumnoRandom(alumno);
            writeln('Agregando el alumno con legajo:',alumno.legajo,' y dni:',alumno.dni);
            agregarAlumno(arbol,alumno);
        end;
end;

procedure imprimirAlumno(alumno:tipoAlumno);
begin 
    writeln();
    write('Legajo=',alumno.legajo,' DNI=',alumno.dni,' Anno=',alumno.anno);
    while (alumno.finales<>nil) do 
        begin 
            write(' C=',alumno.finales^.dato.codigo,' N=',alumno.finales^.dato.nota);
            alumno.finales:=alumno.finales^.sig;
        end;
end;

procedure imprimir(arbol:tipoArbol);
begin 
    if (arbol<>nil) then 
        begin
            imprimir(arbol^.HI); 
            imprimirAlumno(arbol^.dato);
            imprimir(arbol^.HD);
        end;
end; 

procedure imprimirAlumnoB(alumno:tipoAlumnoB);
begin 
    writeln('DNI=',alumno.dni,' Anno=',alumno.anno);
end;

procedure imprimirB(arbol:tipoArbolB);
begin 
    if (arbol<>nil) then 
        begin
            imprimirB(arbol^.HI); 
            imprimirAlumnoB(arbol^.dato);
            imprimirB(arbol^.HD);
        end;
end; 

procedure alumnoTOalumnoB(alumno:tipoAlumno;var alumnoB:tipoAlumnoB);
begin 
    alumnoB.dni:=alumno.dni;
    alumnoB.anno:=alumno.anno;
end;

procedure menores(arbol:tipoArbol;var arbolB:tipoArbolB;legajo:integer);
var 
    alumnoB:tipoAlumnoB;
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.legajo<legajo) then 
                begin
                    alumnoTOalumnoB(arbol^.dato,alumnoB);
                    agregarAlumnoB(arbolB,alumnoB);
                    menores(arbol^.HI,arbolB,legajo);
                    menores(arbol^.HD,arbolB,legajo);
                end
            else
                menores(arbol^.HI,arbolB,legajo);
        end;
end;

procedure maxLegajo(arbol:tipoArbol;var max:integer);
begin 
    if (arbol<>nil) then 
        begin 
            max:=arbol^.dato.legajo;
            maxLegajo(arbol^.HD,max);
        end;
end;

procedure maxDni(arbol:tipoArbol;var max:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.dni>max) then 
                max:=arbol^.dato.dni;
            maxDni(arbol^.HI,max);
            maxDni(arbol^.HD,max);
        end;
end;

procedure legajosImpares(arbol:tipoArbol;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if ((arbol^.dato.legajo mod 2)=1) then 
                cant:=cant+1;
            legajosImpares(arbol^.HI,cant);
            legajosImpares(arbol^.HD,cant);
        end;
end;

function getPromedio(alumno:tipoAlumno):real;
var 
    total,cant:integer;
begin 
    total:=0;
    cant:=0;
    while (alumno.finales<>nil) do 
        begin 
            cant:=cant+1;
            total:=total+alumno.finales^.dato.nota;
            alumno.finales:=alumno.finales^.sig;
        end;
    getPromedio:=(total/cant);
end;

procedure agregarPromedio(var pri:tipoPromedios;promedio:tipoPromedio);
var 
    aux:tipoPromedios;
begin 
    new(aux);
    aux^.dato:=promedio;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure imprimirPromedios(pri:tipoPromedios);
begin 
    while (pri<>nil) do 
        begin 
            writeln('Legajo=',pri^.dato.legajo,' Promedio=',pri^.dato.promedio:0:2);
            pri:=pri^.sig;
        end;
end;

procedure mayores(arbol:tipoArbol;var listaPromedio:tipoPromedios;promedio:real);
var 
    promedioActual:real;
    regpromedio:tipoPromedio;
begin 
    if (arbol<>nil) then 
        begin 
            promedioActual:=getPromedio(arbol^.dato);
            if (promedioActual>promedio) then 
                begin
                    regpromedio.promedio:=promedioActual;
                    regpromedio.legajo:=arbol^.dato.legajo;
                    agregarPromedio(listaPromedio,regpromedio);
                    mayores(arbol^.HI,listaPromedio,promedio);
                    mayores(arbol^.HD,listaPromedio,promedio);
                end
            else
                mayores(arbol^.HD,listaPromedio,promedio);
        end;
end;

var 
    arbol:tipoArbol;
    arbolB:tipoArbolB;
    n,max,cant:integer;
    promedio:real;
    promedios:tipoPromedios;
begin 
    Randomize;
    arbol:=nil;
    arbolB:=nil;
    promedios:=nil;

    cargar(arbol);  //a

    imprimir(arbol);

    writeln;
    write('Ingrese un numero de legajo:' );
    readln(n);
    menores(arbol,arbolB,n);    //b
    writeln('Los alumnos con legajo menor a ',n,' son:');
    imprimirB(arbolB);

    writeln;
    max:=0;
    maxLegajo(arbol,max);       //c
    writeln('El legajo mas grande es:',max);

    writeln;
    max:=0;
    maxDni(arbol,max);       //d
    writeln('El dni mas grande es:',max);

    writeln;
    cant:=0;
    legajosImpares(arbol,cant);  //e
    writeln('La cantidad de legajos impares es:',cant);

    writeln;
    write('Ingrese un promedio:' );
    readln(promedio);
    mayores(arbol,promedios,promedio);    //b
    writeln('Los alumnos con promedio mayor a ',promedio:0:2,' son:');
    imprimirPromedios(promedios);
end.