//Maestro con a,b y cant. 
//N detalles con a,b y cant.
//Todos los archivos estan ordenados por a y b.
program apunte;
const 
    VALORALTO = 9999;
    N_DETALLES = 3;
type 
    tregistro = record 
        a:integer;
        b:integer;
        cant:integer;
    end;

    tarch = file of tregistro;
    tdetalles = array [1..N_DETALLES] of Text;
    tregistros = array [1..N_DETALLES] of tregistro;

procedure leer(var detalle:Text;var reg:tregistro);
begin 
    if (eof(detalle)) then 
        reg.a:=VALORALTO
    else 
        readln(detalle,reg.a,reg.b,reg.cant);
end;

procedure asignarDetalles(var detalles:tdetalles);
var 
    i:integer;
    s:string;
begin 
    for i:=1 to N_DETALLES do 
        begin
            str(i,s);
            assign(detalles[i],('detalles/detalle'+s+'.txt'));
        end;
end;

procedure resetearDetalles(var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to N_DETALLES do 
        reset(detalles[i]);
end;

procedure cargarRegistros(var detalles:tdetalles;var registros:tregistros);
var 
    i:integer;
begin 
    for i:=1 to N_DETALLES do 
        leer(detalles[i],registros[i]);
end;

procedure cerrarDetalles(var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to N_DETALLES do 
        close(detalles[i]);
end;

procedure imprimirMaestro(var arch:tarch);
var 
    reg:tregistro;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch,reg);
            writeln('A: ',reg.a,', B: ',reg.b,', Cant: ',reg.cant);
        end;
    close(arch);
end;

procedure minimo(var min:tregistro;var detalles:tdetalles;var registros:tregistros);
var 
    i,i_min:integer;
begin 
    min:=registros[1];
    i_min:=1;
    for i:=2 to N_DETALLES do 
        begin
            if (registros[i].a<min.a) or 
               ((registros[i].a=min.a) and (registros[i].b<min.b)) then 
                begin   
                    min:=registros[i];
                    i_min:=i;
                end;
        end;
    leer(detalles[i_min],registros[i_min]);
end;

procedure actualizar(var maestro:tarch;var detalles:tdetalles);
var 
    min,actual,mae:tregistro;
    registros:tregistros;
begin 
    reset(maestro);
    resetearDetalles(detalles);
    cargarRegistros(detalles,registros);
    minimo(min,detalles,registros);
    if (not eof(maestro)) then 
        read(maestro,mae);
    while (min.a<>VALORALTO) do 
        begin 
            actual:=min;
            actual.cant:=0;
            while (actual.a=min.a) and (actual.b=min.b) do 
                begin 
                    actual.cant:=actual.cant+min.cant;
                    minimo(min,detalles,registros);
                end;
            while (actual.a<>mae.a) or (actual.b<>mae.b) do 
                read(maestro,mae);
            
            mae.cant:=mae.cant+actual.cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,mae);
            if (not eof(maestro)) then 
                read(maestro,mae);
        end;
    cerrarDetalles(detalles);
    close(maestro);
end;

var 
    detalles:tdetalles;
    maestro:tarch;
begin 
    assign(maestro,'maestro.dat');
    asignarDetalles(detalles);
    writeln;
    writeln('Maestro antes de actualizar: ');
    imprimirMaestro(maestro);
    actualizar(maestro,detalles);
    writeln;
    writeln('Maestro despues de actualizar: ');
    imprimirMaestro(maestro);
end.