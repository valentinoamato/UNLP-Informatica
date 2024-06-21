program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    DIMF = 10;
type 
    tmaestro =  record 
        codCepa:integer;
        nombreCepa:string;
        codLocalidad:integer;
        nombreLocalidad:string;
        activos:integer;
        nuevos:integer; 
        recuperados:integer;
        fallecidos:integer;
    end;

    tdetalle =  record 
        codLocalidad:integer;
        codCepa:integer;
        activos:integer;
        nuevos:integer; 
        recuperados:integer;
        fallecidos:integer;
    end;

    tbin = file of tmaestro;

var 
    detalles: array [1..DIMF] of text;
    registros: array [1..DIMF] of tdetalle;


procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.codLocalidad:=VALORALTO
    else 
        begin
            readln(det,
                   regd.codLocalidad,
                   regd.codCepa,
                   regd.activos,
                   regd.nuevos,
                   regd.recuperados,
                   regd.fallecidos);
        end;
end;

procedure imprimirRegm(p:tmaestro);
begin 
    writeln('Localidad: ',p.codLocalidad,
            '-',p.nombreLocalidad,
            ', Cepa: ',p.codCepa,
            '-',p.nombreCepa,
            ', Activos: ',p.activos,
            ', Nuevos: ',p.nuevos,
            ', Recuperados: ',p.recuperados,
            ', Fallecidos: ',p.fallecidos);
end;

procedure imprimirBin(var bin:tbin);
var 
    producto:tmaestro;
begin 
    reset(bin);
    writeln;
    writeln('Los datos en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,producto);
            imprimirRegm(producto);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tmaestro;
    texto:string;
    indice:integer;
begin 
    assign(txt,'maestro.txt');
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,
                   reg.codLocalidad,
                   reg.codCepa,
                   reg.activos,
                   reg.nuevos,
                   reg.recuperados,
                   reg.fallecidos,
                   texto);
            texto:=trim(texto);
            indice:=pos('@',texto);
            reg.nombreLocalidad:=copy(texto,0,indice-1);
            reg.nombreCepa:=copy(texto,indice+1,length(texto));
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

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

procedure cargarRegistros();
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            leer(detalles[i],registros[i]);
        end;
end;

procedure minimo(var min:tdetalle);
type 
    tminimo =  record 
        indice:integer;
        localidad:integer;
        cepa:integer;
    end;
var 
    minimo:tminimo;
    i:integer;
begin
    minimo.localidad:=VALORALTO;
    minimo.indice:=1;
    for i:=1 to DIMF do 
        begin 
            if (registros[i].codLocalidad<minimo.localidad) or 
              ((registros[i].codLocalidad=minimo.localidad) and (registros[i].codCepa<minimo.cepa)) then
                begin 
                    minimo.localidad:=registros[i].codLocalidad;
                    minimo.cepa:=registros[i].codCepa;
                    minimo.indice:=i;
                end;
        end;
    min:=registros[minimo.indice];
    leer(detalles[minimo.indice],registros[minimo.indice]);
end;

procedure actualizar(var maestro:tbin);
var 
    regm:tmaestro;
    activos,cant:integer;
    min,actual:tdetalle;    
begin 
    cant:=0;
    activos:=0;

    reset(maestro);
    read(maestro,regm);

    cargarRegistros();
    minimo(min);
    while (min.codLocalidad<>VALORALTO) do 
        begin
            actual:=min;
            actual.activos:=0;
            actual.nuevos:=0;
            actual.recuperados:=0;
            actual.fallecidos:=0;


            while (actual.codLocalidad=min.codLocalidad) and (actual.codCepa=min.codCepa) do 
                begin 
                    actual.activos:=actual.activos+min.activos;
                    actual.nuevos:=actual.nuevos+min.nuevos;
                    actual.recuperados:=actual.recuperados+min.recuperados;
                    actual.fallecidos:=actual.fallecidos+min.fallecidos;
                    minimo(min);
                end;

            while (regm.codLocalidad<>actual.codLocalidad) or (regm.codCepa<>actual.codCepa) do 
                begin
                    read(maestro,regm);
                end;
            regm.activos:=regm.activos+actual.activos;
            regm.nuevos:=regm.nuevos+actual.nuevos;
            regm.recuperados:=regm.recuperados+actual.recuperados;
            regm.fallecidos:=regm.fallecidos+actual.fallecidos;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 

            activos:=activos+regm.activos;
            if (min.codLocalidad<>regm.codLocalidad) then
                begin
                    if (activos>400) then 
                        cant:=cant+1;
                    activos:=0;
                end;
            
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
    writeln('Hay ',cant,' localidades con mas de 400 casos activos.');
end;

var 
    maestro:Text;
    bin:tbin;
begin 
    textToBin(maestro,bin);
    imprimirBin(bin);
    inicializarDetalles();
    actualizar(bin);
    imprimirBin(bin);
    cerrarDetalles();
end.