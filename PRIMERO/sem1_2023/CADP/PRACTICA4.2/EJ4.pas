program EJ4;
const
    dimf=10;
type
    regalumno=record
        numero:integer;
        nombre:string;
        apellido:string;
        asistencias:integer;
    end;
    vector = array [1..dimf] of regalumno;

procedure leer (var reg:regalumno);
begin
    writeln('Ingrese numero: ');
    readln(reg.numero);
    writeln('Ingrese nombre: ');
    readln(reg.nombre);
    writeln('Ingrese apellido: ');
    readln(reg.apellido);
    writeln('Ingrese asistencias: ');
    readln(reg.asistencias);
end;
procedure cargar (var v:vector;var diml:integer);
var
    i:integer;
    alumno:regalumno;
begin
    leer(alumno);
    i:=0;
    diml:=0;
    while (alumno.numero<>0) and (i<dimf) do
        begin
            i:=i+1;
            v[i]:=alumno;
            diml:=diml+1;
            leer(alumno);
        end;
end;

procedure escribir (v:vector;diml:integer);
var
    i:integer;
begin
    for i:=1 to diml do
        begin
            writeln('|||||||||');
            writeln('numero: ',v[i].numero);
            writeln('nombre: ',v[i].nombre);
            writeln('apellido: ',v[i].apellido);
            writeln('asistencias: ',v[i].asistencias);
            writeln('|||||||||');
        end;
end;
function buscar (v:vector;diml:integer;numero:integer):integer;
var
    i:integer;
begin
    i:=1;
    while (i<diml) and (v[i].numero<>numero) do
        i:=i+1;
    if (v[i].numero=numero) then
        buscar:=i
    else
        buscar:=0;
end;

procedure insertar (var v:vector;var diml:integer;alumno:regalumno;pos:integer);
var
    i:integer;
begin
    if (diml<dimf) and (pos<(diml+1)) and (pos>0) then
        begin
            for i:=diml downto pos do
                v[i+1]:=v[i];
            v[pos]:=alumno;
            diml:=diml+1;
        end;
end;

procedure eliminarpos (var v:vector;var diml:integer;pos:integer);
var
    i:integer;
begin
    for i:=pos to (diml-1) do
        v[i]:=v[i+1];
    diml:=diml-1;
end;

procedure eliminarnro (var v:vector;var diml:integer;nro:integer);
var
    pos:integer;
begin
    pos:=buscar(v,diml,nro);
    if (pos<>0) then
        begin
            eliminarpos(v,diml,pos);
            diml:=diml-1;
        end;
end;

procedure eliminar0asistencias (var v:vector;var diml:integer);
var 
    i,eliminados:integer;
begin
    eliminados:=0;
    i:=0;
    while (i<diml) do
        begin
            i:=i+1;
            if (v[i].asistencias=0) then
                begin
                    eliminarpos(v,diml,i);
                    eliminados:=eliminados+1;
                    i:=i-1;
                end;
        end;
end;

var
    v:vector;
    diml,pos,numero:integer;
    alumno:regalumno;


begin
    cargar(v,diml);
    escribir(v,diml);
    writeln('ingrese numero a buscar: ');
    readln(numero);
    writeln(buscar(v,diml,numero));
    leer(alumno);
    writeln('ingrese pos a insertar: ');
    readln(pos);
    insertar(v,diml,alumno,pos);
    escribir(v,diml);
    writeln('ingrese pos a eliminar: ');
    readln(pos);
    eliminarpos(v,diml,pos);
    escribir(v,diml);
    writeln('ingrese numero a eliminar: ');
    readln(numero);
    eliminarnro(v,diml,numero);
    escribir(v,diml);
    eliminar0asistencias(v,diml);
    escribir(v,diml);
end.