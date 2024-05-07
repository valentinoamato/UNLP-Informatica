program test;

Uses sysutils;
const 
    DIMF = 5;
type 
    tsesion = record 
        codigo:integer;
        fecha:integer;
        tiempo:integer;
    end;

    tlista = ^ tnodo;
    tnodo = record 
        codigo:integer;
        sig:tlista;
    end;

var 
    detalles: array [1..DIMF] of text;

procedure inicializarDetalles();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            assign(detalles[i],'detalles/detalle'+i.tostring()+'.txt');
            reset(detalles[i]);
        end;
end;

procedure cerrarDetalles();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        close(detalles[i]);
end;

function exists(pri:tlista;codigo:integer):boolean;
begin 
    if (pri=nil) then 
        exists:=False
    else 
        begin 
            if (pri^.codigo=codigo) then 
                exists:=True 
            else 
                exists:=exists(pri^.sig,codigo);
        end;
end;

procedure agregar(var pri:tlista;codigo:integer);
var 
    aux:tlista;
begin 
    new(aux);
    aux^.codigo:=codigo;
    aux^.sig:=pri;
    pri:=aux;
end;

procedure cargarLista(var pri:tlista);
var 
    sesion:tsesion;
    i:integer;
begin
    pri:=nil;
    for i:=1 to DIMF do 
        begin  
            reset(detalles[i]);
            while (not eof(detalles[i])) do  
                begin 
                    readln(detalles[i],sesion.codigo,sesion.fecha,sesion.tiempo);
                    if (not exists(pri,sesion.codigo)) then 
                        agregar(pri,sesion.codigo);
                end;
        end;
end;

procedure crearMaestro();
var 
    sesion:tsesion;
    maestro:Text;
    pri:tlista;
    i,codigo,tiempo:integer;
begin 
    assign(maestro,'maestro.txt');
    rewrite(maestro);
    inicializarDetalles();
    cargarLista(pri);
    while (pri<>nil) do 
        begin
            codigo:=pri^.codigo;
            tiempo:=0;
            for i:=1 to DIMF do 
                begin  
                    reset(detalles[i]);
                    while (not eof(detalles[i])) do  
                        begin 
                            readln(detalles[i],sesion.codigo,sesion.fecha,sesion.tiempo);
                            if (sesion.codigo=codigo) then 
                                tiempo:=tiempo+sesion.tiempo;
                        end;
                end;
            writeln(maestro,
                    'Codigo: ',
                    codigo,
                    ', Fecha: ',
                    sesion.fecha,
                    ', Tiempo Total: ',
                    tiempo);
            pri:=pri^.sig;
        end;
    close(maestro);
    writeln;
    writeln('Se ha creado el archivo maestro: "maestro.txt".');
end;

begin 
    crearMaestro();
end.