program test;

uses sysutils;

const 
    VALORALTO=9999;

type 
    tmaestro =  record 
        departamento:integer;
        division:integer;
        empleado:integer;
        categoria:integer;
        horas:integer;
    end;

    tvalores = array [1..15] of real;

    tacum = record 
        horasDiv:integer;
        montoDiv:real;
        horasDep:integer;
        montoDep:real;
    end;

procedure leer(var maestro:Text;var reg:tmaestro);
begin 
    if (not eof(maestro)) then 
        begin 
            readln(maestro,
                   reg.departamento,
                   reg.division,
                   reg.empleado,
                   reg.categoria,
                   reg.horas);
        end
    else 
        begin
            reg.departamento:=VALORALTO;
        end;
end;

procedure cargarValores(var archivoValores:Text;var valores:tvalores);
var 
    indice:integer;
    valor:real;
begin 
    reset(archivoValores);
    while (not eof(archivoValores)) do 
        begin 
            readln(archivoValores,indice,valor);
            valores[indice]:=valor;
        end;
    close(archivoValores);
end; 

procedure reportar(var maestro:Text;valores:tvalores);
var 
    aux,actual:tmaestro;
    acum:tacum; //acumulador
    monto:real;
begin 
    reset(maestro);
    leer(maestro,aux);
    
    acum.horasDep:=0;
    acum.horasDiv:=0;
    acum.montoDep:=0;
    acum.montoDiv:=0;
    actual.division:=aux.division;
    actual.departamento:=aux.departamento;

    while (aux.departamento<>VALORALTO) do 
        begin 
            writeln;
            writeln('Departamento ',aux.departamento,'.');
            while (actual.departamento=aux.departamento) do 
                begin 
                    writeln('   Division ',aux.division,'.');
                    while (actual.departamento=aux.departamento) and (actual.division=aux.division) do 
                        begin 
                            monto:=(valores[aux.categoria]*aux.horas);
                            writeln('       - Empleado=',aux.empleado,', Horas=',aux.horas,', Monto=',monto:0:2,'.');
                            acum.horasDiv:=acum.horasDiv+aux.horas;
                            acum.montoDiv:=acum.montoDiv+monto;
                            leer(maestro,aux);
                        end;
                    writeln('   Horas Division=',acum.horasDiv,', Monto Division=',acum.montoDiv:0:2,'.');
                    acum.horasDep:=acum.horasDep+acum.horasDiv;
                    acum.montoDep:=acum.montoDep+acum.montoDiv;
                    acum.horasDiv:=0;
                    acum.montoDiv:=0;
                    actual.division:=aux.division;
                end;
            writeln('Horas Departamento=',acum.horasDep,', Monto Departamento=',acum.montoDep:0:2,'.');
            acum.horasDep:=0;
            acum.montoDep:=0;
            actual.departamento:=aux.departamento;
        end;
    writeln;
    close(maestro);
end;

var 
    maestro:Text;
    archivoValores:Text;
    valores:tvalores;
begin 
    assign(archivoValores,'valores.txt');
    cargarValores(archivoValores,valores);

    assign(maestro,'maestro.txt');
    reportar(maestro,valores);
end.
