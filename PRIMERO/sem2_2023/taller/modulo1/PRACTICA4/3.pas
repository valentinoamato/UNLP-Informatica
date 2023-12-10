program ejercicio3;
type 
    tfinal = record 
        alumno:integer;
        materia:integer;
        nota:integer;
    end;
//I
    tmaterias = array [1..10] of integer;
    talumno = record
        numero:integer;
        materias:tmaterias;
    end;

    tarbol =^ tnodo;
    tnodo = record 
        dato:talumno;
        HI:tarbol;
        HD:tarbol;
    end;
//II
    tfinalII = record 
        alumno:integer;
        nota:integer;
    end;

    tfinales =^ tnodoII;
    tnodoII = record 
        dato:tfinalII;
        sig:tfinales;
    end;

    tmateriasII = array [1..10] of tfinales; 
//B
    tpromedio = record 
        alumno:integer;
        promedio:real;
    end;

    tpromedios =^ nodoPromedio;
    nodoPromedio = record 
        sig:tpromedios;
        dato:tpromedio;
    end;

procedure finalRandom(var final:tfinal);
begin 
    final.alumno:=random(10)+1;
    final.materia:=random(5)+1;
    final.nota:=random(10)+1;
end;

procedure imprimirFinal(final:tfinal);
begin 
    writeln('Alumno=',final.alumno,' Materia=',final.materia,' Nota=',final.nota);
end;

procedure imprimirAlumno(alumno:talumno);
var 
    i:integer;
begin 
    writeln;
    write('Numero=',alumno.numero);
    for i:=1 to 10 do 
        begin 
            if (alumno.materias[i]<>-1) then 
                write(' ',i,': ',alumno.materias[i]);
        end;
end;

procedure imprimir(arbol:tarbol);
begin 
    if (arbol<>nil) then 
        begin 
            imprimir(arbol^.HI);
            imprimirAlumno(arbol^.dato);
            imprimir(arbol^.HD);
        end;
end;

procedure imprimirII(materias:tmateriasII);
var 
    i:integer;
begin 
    for i:=1 to 10 do 
        begin 
            if (materias[i]<>nil) then 
                begin 
                    writeln;
                    write(i,') ');
                    while (materias[i]<>nil) do 
                        begin
                            write(materias[i]^.dato.alumno,'=',materias[i]^.dato.nota,' ');
                            materias[i]:=materias[i]^.sig;
                        end;
                end;
        end;
end;


procedure inicializarMaterias(var materias:tmaterias);
var 
    i:integer;
begin 
    for i:=1 to 10 do 
        materias[i]:=-1;
end;

procedure inicializarFinales(var materias:tmateriasII);
var 
    i:integer;
begin 
    for i:=1 to 10 do 
        materias[i]:=nil;
end;

procedure agregarFinal(var alumno:talumno;final:tfinal);
begin 
    if (alumno.materias[final.materia]=-1) and (final.nota>=4) then 
        alumno.materias[final.materia]:=final.nota;
end; 

procedure crearNodo(var arbol:tarbol;final:tfinal);
begin 
    new(arbol);
    arbol^.dato.numero:=final.alumno;
    inicializarMaterias(arbol^.dato.materias);
    agregarFinal(arbol^.dato,final);
    arbol^.dato.materias[final.materia]:=final.nota;
    arbol^.HI:=nil;
    arbol^.HD:=nil;
end;

procedure agregarFinalII(var pri:tfinales;final:tfinal);
var 
    aux:tfinales;
begin 
    new(aux);
    aux^.sig:=pri;
    pri:=aux;
    aux^.dato.alumno:=final.alumno;
    aux^.dato.nota:=final.nota;
end;

procedure agregarII(var materias:tmateriasII;final:tfinal);
begin 
    agregarFinalII(materias[final.materia],final);
end;

procedure agregar(var arbol:tarbol;final:tfinal);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.numero=final.alumno) then 
                begin
                    agregarFinal(arbol^.dato,final);
                end
            else 
                begin
                    if (final.alumno<=arbol^.dato.numero) then 
                        agregar(arbol^.HI,final)
                    else 
                        agregar(arbol^.HD,final);
                end;
        end
    else 
        begin
            crearNodo(arbol,final);
        end;
end;

procedure cargar(var arbol:tarbol;var materias:tmateriasII);
var 
    i:integer;
    final:tfinal;
begin 
    Randomize;
    inicializarFinales(materias);
    writeln('Iniciando carga.');
    for i:=1 to random(30)+5 do 
        begin 
            finalRandom(final);
            write(i,': ');
            imprimirFinal(final);
            agregar(arbol,final);
            agregarII(materias,final);
        end;
end;
//B
procedure imprimirb(promedios:tpromedios);
begin 
    while (promedios<>nil) do 
        begin 
            writeln('Alumno=',promedios^.dato.alumno,' Promedio=',promedios^.dato.promedio:0:2);
            promedios:=promedios^.sig;
        end;
end;

procedure agregarb(var pri:tpromedios;promedio:tpromedio);
var 
    aux:tpromedios;
begin 
    new(aux);
    aux^.dato:=promedio;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure alumnoTOpromedio(alumno:talumno;var promedio:tpromedio);
var 
    i,total,cant:integer;
begin 
    total:=0;
    cant:=0;
    for i:=1 to 10 do 
        begin 
            if (alumno.materias[i]<>-1) then 
                begin 
                    cant:=cant+1;
                    total:=total+alumno.materias[i];
                end;
        end;
    promedio.alumno:=alumno.numero;
    promedio.promedio:=total/cant;
end;
 
procedure modulob(arbol:tarbol;var pri:tpromedios;codigo:integer);
var 
    promedio:tpromedio;
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.numero>codigo) then 
                begin 
                    alumnoTOpromedio(arbol^.dato,promedio);
                    agregarb(pri,promedio);
                    modulob(arbol^.HI,pri,codigo);
                    modulob(arbol^.HD,pri,codigo);
                end
            else 
                modulob(arbol^.HD,pri,codigo);
        end;
end;
 
//C
function cantAprobados(alumno:talumno):integer;
var 
    i,cant:integer;
begin 
    cant:=0;
    for i:=1 to 10 do 
        begin 
            if (alumno.materias[i]>=4) then 
                cant:=cant+1;
        end;
    cantAprobados:=cant;
end;

procedure moduloc(arbol:tarbol;a,b,aprobados:integer;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.numero>a) and (arbol^.dato.numero<b) then
                begin 
                    if (cantAprobados(arbol^.dato)=aprobados) then 
                        cant:=cant+1;
                    moduloc(arbol^.HI,a,b,aprobados,cant);
                    moduloc(arbol^.HD,a,b,aprobados,cant);
                end 
            else 
                if (arbol^.dato.numero>a) then
                    moduloc(arbol^.HI,a,b,aprobados,cant)
                else
                    moduloc(arbol^.HD,a,b,aprobados,cant);
        end;
end;




var 
    arbol:tarbol;
    materias:tmateriasII;
    promedios:tpromedios;
    codigo,a,b,aprobados,cant:integer;
begin 
    arbol:=nil;
    promedios:=nil;
    cargar(arbol,materias);
    imprimir(arbol);    //Imprime la estructura A-I
    imprimirII(materias);//Imprime la estructura A-II

    writeln;
    write('Ingrese un numero de alumno: ');
    readln(codigo);
    modulob(arbol,promedios,codigo);//B
    writeln('Los promedios de los alumnos con codigo mayor a ',codigo,' son:');
    imprimirb(promedios);

    writeln;
    write('Ingrese un numero de alumno: ');
    readln(a);
    write('Ingrese otro numero de alumno: ');
    readln(b);
    write('Ingrese una cantidad de finales aprobados: ');
    readln(aprobados);
    cant:=0;
    moduloc(arbol,a,b,aprobados,cant);//C
    writeln('La cantidad de alumnos con codigo entre ',a,' y ',b,', y ',aprobados,' finales aprobados es: ',cant);
end.


