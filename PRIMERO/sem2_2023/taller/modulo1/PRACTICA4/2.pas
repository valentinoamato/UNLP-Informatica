program ejercicio2;
type
//a-I 
    tprestamo = record 
        isbn:integer;
        socio:integer;
        dia:integer;
        mes:integer;
        dias:integer;
    end;

    tarbol =^ tnodo;
    tnodo = record 
        dato:tprestamo;
        HI:tarbol;
        HD:tarbol;
    end;
//a-II
    tprestamoII = record 
        socio:integer;
        dia:integer;
        mes:integer;
        dias:integer;
    end;

    tprestamos =^ tnodoPrestamos;
    tnodoPrestamos = record 
        dato:tprestamoII;
        sig:tprestamos;
    end;

    tdatoII = record 
        isbn:integer;
        prestamos:tprestamos;
    end;

    tarbolII =^ tnodoII;
    tnodoII = record 
        dato:tdatoII;
        HI:tarbolII;
        HD:tarbolII;
    end;
//f-g
    tcantidad = record 
        isbn:integer;
        cantidad:integer;
    end;

    tcantidades =^ nodoCantidades;
    nodoCantidades = record 
        sig:tcantidades;
        dato:tcantidad;
    end;


//a-I-a-II
procedure prestamoRandom(var prestamo:tprestamo);
begin 
    prestamo.isbn:=random(10)+1;
    prestamo.socio:=random(30)+1;
    prestamo.dia:=random(31)+1;
    prestamo.mes:=random(12)+1;
    prestamo.dias:=random(20)+1;
end;

procedure imprimirPrestamo(prestamo:tprestamo);
begin 
    writeln('ISBN=',prestamo.isbn,' Socio=',prestamo.socio,' Dia=',prestamo.dia,' Mes=',prestamo.mes,' Dias=',prestamo.dias);
end;

//a-I
procedure agregar(var arbol:tarbol;prestamo:tprestamo);
begin 
    if (arbol<>nil) then 
        begin 
            if (prestamo.isbn<=arbol^.dato.isbn) then 
                agregar(arbol^.HI,prestamo)
            else 
                agregar(arbol^.HD,prestamo);
        end 
    else 
        begin 
            new(arbol);
            arbol^.dato:=prestamo; 
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end;
end;

procedure imprimir(arbol:tarbol);
begin 
    if (arbol<>nil) then 
        begin
            imprimir(arbol^.HI);
            imprimirPrestamo(arbol^.dato); 
            imprimir(arbol^.HD);
        end;
end; 
            

//a-II
procedure agregarPrestamo(var pri:tprestamos;prestamo:tprestamo);
var 
    aux:tprestamos;
begin 
    new(aux);
    aux^.dato.socio:=prestamo.socio;
    aux^.dato.dia:=prestamo.dia;
    aux^.dato.mes:=prestamo.mes;
    aux^.dato.dias:=prestamo.dias;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure agregarII(var arbol:tarbolII;prestamo:tprestamo);
begin 
    if (arbol<>nil) then 
        begin 
            if (prestamo.isbn=arbol^.dato.isbn) then 
                begin 
                    agregarPrestamo(arbol^.dato.prestamos,prestamo);
                end
            else
                begin       
                    if (prestamo.isbn<=arbol^.dato.isbn) then 
                        agregarII(arbol^.HI,prestamo)
                    else 
                        agregarII(arbol^.HD,prestamo);
                end
        end 
    else 
        begin 
            new(arbol);
            arbol^.dato.isbn:=prestamo.isbn;
            agregarPrestamo(arbol^.dato.prestamos,prestamo);
            arbol^.HI:=nil;
            arbol^.HD:=nil;
        end;
end;

procedure imprimirDatoII(dato:tdatoII);
begin 
    write('ISBN=',dato.isbn);
    while (dato.prestamos<>nil) do
        begin 
            write('| Socio=',dato.prestamos^.dato.socio,' Dia=',dato.prestamos^.dato.dia,' Mes=',dato.prestamos^.dato.mes,' Dias=',dato.prestamos^.dato.dias);
            dato.prestamos:=dato.prestamos^.sig;
        end;
    writeln;
end;

procedure imprimirII(arbol:tarbolII);
begin 
    if (arbol<>nil) then 
        begin
            imprimirII(arbol^.HI);
            imprimirDatoII(arbol^.dato); 
            imprimirII(arbol^.HD);
        end;
end; 
            
//i-a-II 
procedure cargar(var arbol:tarbol;var arbolII:tarbolII);
var 
    i:integer;
    prestamo:tprestamo;
begin 
    writeln('Iniciando carga.');
    for i:=1 to random(16)+5 do 
        begin 
            prestamoRandom(prestamo);
            write(i,': ');
            imprimirPrestamo(prestamo);
            agregar(arbol,prestamo);
            agregarII(arbolII,prestamo);
        end;
end;

//b
procedure modulob (arbol:tarbol;var max:integer);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.HD<>nil) then 
                modulob(arbol^.HD,max)
            else 
                max:=arbol^.dato.isbn;
        end;
end;

//c
procedure moduloc (arbol:tarbol;var min:integer);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.HI<>nil) then 
                moduloc(arbol^.HI,min)
            else 
                min:=arbol^.dato.isbn;
        end;
end;

//d
procedure modulod (arbol:tarbol;socio:integer;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin
            if (arbol^.dato.socio=socio) then
                cant:=cant+1; 
            modulod(arbol^.HI,socio,cant);
            modulod(arbol^.HD,socio,cant);
        end;
end;

//e
procedure moduloe (arbol:tarbolII;socio:integer;var cant:integer);
var 
    aux:tprestamos;
begin 
    if (arbol<>nil) then 
        begin
            aux:=arbol^.dato.prestamos;
            while (aux<>nil) do 
                begin
                    if (aux^.dato.socio=socio) then
                        cant:=cant+1; 
                    aux:=aux^.sig;
                end;
            moduloe(arbol^.HI,socio,cant);
            moduloe(arbol^.HD,socio,cant);
        end;
end;

//f-g
procedure imprimirCantidad(cantidad:tcantidad);
begin 
    writeln('ISBN=',cantidad.isbn,' Cantidad=',cantidad.cantidad);
end;

procedure imprimirCantidades(cantidades:tcantidades);
begin 
    while (cantidades<>nil) do
        begin 
            write('| ');
            imprimirCantidad(cantidades^.dato);
            cantidades:=cantidades^.sig;
        end;
end;

procedure agregarCantidad(var cantidades:tcantidades;cantidad:tcantidad);
var 
    aux:tcantidades;
begin 
    new(aux);
    aux^.sig:=cantidades;
    cantidades:=aux;
    aux^.dato:=cantidad;
end;

procedure actualizarCantidades(var cantidades:tcantidades;cantidad:tcantidad);
var 
    aux:tcantidades;
    found:boolean;
begin 
    found:=False;
    aux:=cantidades;
    while (aux<>nil) and (not found) do 
        begin 
            if (aux^.dato.isbn=cantidad.isbn) then 
                begin 
                    aux^.dato.cantidad:=aux^.dato.cantidad+cantidad.cantidad;
                    found:=True;
                end;
            aux:=aux^.sig;
        end;
    if (not found) then 
        agregarCantidad(cantidades,cantidad);
end;

//f
procedure modulof(arbol:tarbol;var cantidades:tcantidades);
var 
    cantidad:tcantidad;
begin 
    if (arbol<>nil) then 
        begin 
            cantidad.cantidad:=1;
            cantidad.isbn:=arbol^.dato.isbn;
            actualizarCantidades(cantidades,cantidad);
            modulof(arbol^.HI,cantidades);
            modulof(arbol^.HD,cantidades);
        end;
end;

//g
procedure modulog(arbol:tarbolII;var cantidades:tcantidades);
var 
    cantidad:tcantidad;
    aux:tprestamos;
begin 
    if (arbol<>nil) then 
        begin 
            cantidad.isbn:=arbol^.dato.isbn;
            cantidad.cantidad:=0;
            aux:=arbol^.dato.prestamos;
            while (aux<>nil) do 
                begin 
                    cantidad.cantidad:=cantidad.cantidad+1;
                    aux:=aux^.sig;
                end;
            actualizarCantidades(cantidades,cantidad);
            modulog(arbol^.HI,cantidades);
            modulog(arbol^.HD,cantidades);
        end;
end;

//i
procedure moduloi(arbol:tarbol;a,b:integer;var cant:integer);
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.isbn>=a) and (arbol^.dato.isbn<=b) then 
                begin
                    cant:=cant+1;
                    moduloi(arbol^.HI,a,b,cant);
                    moduloi(arbol^.HD,a,b,cant);
                end
            else 
                begin
                    if (arbol^.dato.isbn>a) then
                        moduloi(arbol^.HI,a,b,cant)
                    else 
                        moduloi(arbol^.HD,a,b,cant);
                end;
        end;
end;

//j
procedure moduloj(arbol:tarbolII;a,b:integer;var cant:integer);
var 
    aux:tprestamos;
begin 
    if (arbol<>nil) then 
        begin 
            if (arbol^.dato.isbn>=a) and (arbol^.dato.isbn<=b) then 
                begin
                    aux:=arbol^.dato.prestamos;
                    while (aux<>nil) do 
                        begin 
                            cant:=cant+1;
                            aux:=aux^.sig;
                        end;
                    moduloj(arbol^.HI,a,b,cant);
                    moduloj(arbol^.HD,a,b,cant);
                end 
            else 
                begin 
                    if (arbol^.dato.isbn>a) then  
                        moduloj(arbol^.HI,a,b,cant)
                    else
                        moduloj(arbol^.HD,a,b,cant);
                end;
        end;
end;




var 
    arbol:tarbol;
    arbolII:tarbolII;
    max,min,a,b,socio,cant:integer;
    cantidadesf,cantidadesg:tcantidades;
begin 
    Randomize;
    arbol:=nil;
    arbolII:=nil;
    cantidadesf:=nil;
    cantidadesg:=nil;

    cargar(arbol,arbolII);

    writeln;
    writeln('ARBOL a-I:');
    imprimir(arbol);

    writeln;
    writeln('ARBOL a-II:');
    imprimirII(arbolII);

    writeln;
    max:=-1;
    writeln('Modulo b:');
    modulob(arbol,max);
    writeln('El ISBN mas grande es: ',max);

    writeln;
    min:=-1;
    writeln('Modulo c:');
    moduloc(arbol,min);
    writeln('El ISBN mas chico es: ',min);

    writeln;
    cant:=0;
    writeln('Modulo d:');
    write('Ingrese numero de socio: ');
    readln(socio);
    modulod(arbol,socio,cant);
    writeln('El socio ',socio,' ha realizado ',cant,' prestamos.');

    writeln;
    cant:=0;
    writeln('Modulo e:');
    moduloe(arbolII,socio,cant);
    writeln('El socio ',socio,' ha realizado ',cant,' prestamos.');

    writeln;
    writeln('Modulo f:');
    modulof(arbol,cantidadesf);
    imprimirCantidades(cantidadesf);

    writeln;
    writeln('Modulo g:');
    modulog(arbolII,cantidadesg);
    imprimirCantidades(cantidadesg);

    writeln;
    cant:=0;
    writeln('Modulo i:');
    write('Ingrese un ISBN: ');
    readln(a);
    write('Ingrese otro ISBN: ');
    readln(b);
    moduloi(arbol,a,b,cant);
    writeln('La cantidad de prestamos realizados de los ISBN entre ',a,' y ',b,' (incluidos) es: ',cant);

    writeln;
    cant:=0;
    writeln('Modulo j:');
    moduloj(arbolII,a,b,cant);
    writeln('La cantidad de prestamos realizados de los ISBN entre ',a,' y ',b,' (incluidos) es: ',cant);
end.