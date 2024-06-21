program test;

Uses sysutils;
const 
    VALORALTO = 9999;
    DIMF = 10;
type 
    tmaestro =  record 
        codProv:integer;
        codLoc:integer;
        nombreProv:string;
        nombreLoc:string;
        luz:integer;
        gas:integer; 
        chapa:integer;
        agua:integer;
        sanitarios:integer;
    end;

    tdetalle =  record 
        codProv:integer;
        codLoc:integer;
        luz:integer;
        gas:integer; 
        chapa:integer;
        agua:integer;
        sanitarios:integer;
    end;

    tbin = file of tmaestro;

    tdetalles = array [1..DIMF] of text; 
    tregistros = array [1..DIMF] of tdetalle;

    tminimo =  record 
        indice:integer;
        provincia:integer;
        localidad:integer;
    end;


procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        begin
            regd.codLoc:=VALORALTO;
            regd.codProv:=VALORALTO;
        end
    else 
        begin
            readln(det,
                   regd.codProv,
                   regd.codLoc,
                   regd.luz,
                   regd.gas, 
                   regd.chapa,
                   regd.agua,
                   regd.sanitarios);
        end;
end;

procedure imprimirRegm(p:tmaestro);
begin 
    writeln('Provincia: ',p.codProv,
            '-',p.nombreProv,
            ', Localidad: ',p.codLoc,
            '-',p.nombreLoc,
            ', Sin Luz: ',p.luz,
            ', Sin Gas: ',p.gas,
            ', De Chapa: ',p.chapa,
            ', Sin Agua: ',p.agua,
            ', Sin Sanitarios: ',p.sanitarios);
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
                   reg.codProv,
                   reg.codLoc,
                   reg.luz,
                   reg.gas, 
                   reg.chapa,
                   reg.agua,
                   reg.sanitarios,
                   texto);
            texto:=trim(texto);
            indice:=pos('@',texto);
            reg.nombreProv:=copy(texto,0,indice-1);
            reg.nombreLoc:=copy(texto,indice+1,length(texto));
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure inicializarDetalles(var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            assign(detalles[i],'detalles/detalle'+i.tostring()+'.txt');
        end;
end;

procedure resetearDetalles(var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        reset(detalles[i]);
end;

procedure cerrarDetalles(var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        close(detalles[i]);
end;

procedure cargarRegistros(var registros:tregistros;var detalles:tdetalles);
var 
    i:integer;
begin 
    for i:=1 to DIMF do 
        begin
            leer(detalles[i],registros[i]);
        end;
end;

procedure minimo(var min:tdetalle;var registros:tregistros;var detalles:tdetalles);
var 
    minimo:tminimo;
    i:integer;
begin
    minimo.provincia:=VALORALTO;
    minimo.indice:=1;
    for i:=1 to DIMF do 
        begin 
            if (registros[i].codProv<minimo.provincia) or 
              ((registros[i].codProv=minimo.provincia) and (registros[i].codLoc<minimo.localidad)) then
                begin 
                    minimo.provincia:=registros[i].codProv;
                    minimo.localidad:=registros[i].codLoc;
                    minimo.indice:=i;
                end;
        end;
    min:=registros[minimo.indice];
    leer(detalles[minimo.indice],registros[minimo.indice]);
end;

procedure actualizar(var maestro:tbin;var registros:tregistros;var detalles:tdetalles);
var 
    regm:tmaestro;
    cant:integer;
    min,actual:tdetalle;    
begin 
    cant:=0;

    reset(maestro);
    resetearDetalles(detalles);
    read(maestro,regm);

    cargarRegistros(registros,detalles);
    minimo(min,registros,detalles);

    while (min.codProv<>VALORALTO) do 
        begin
            actual:=min;
            actual.luz:=0;
            actual.gas:=0;
            actual.chapa:=0;
            actual.agua:=0;
            actual.sanitarios:=0;


            while (actual.codProv=min.codProv) and (actual.codLoc=min.codLoc) do 
                begin 
                    actual.luz:=actual.luz+min.luz;
                    actual.gas:=actual.gas+min.gas;
                    actual.chapa:=actual.chapa+min.chapa;
                    actual.agua:=actual.agua+min.agua;
                    actual.sanitarios:=actual.sanitarios+min.sanitarios;
                    minimo(min,registros,detalles);
                end;

            while (regm.codProv<>actual.codProv) or (regm.codLoc<>actual.codLoc) do 
                begin
                    if (regm.chapa=0) then 
                        cant:=cant+1;
                    read(maestro,regm);
                end;
            regm.luz:=regm.luz-actual.luz;
            regm.gas:=regm.gas-actual.gas;
            regm.chapa:=regm.chapa-actual.chapa;
            regm.agua:=regm.agua-actual.agua;
            regm.sanitarios:=regm.sanitarios-actual.sanitarios;
            seek(maestro,filepos(maestro)-1);
            if (regm.chapa=0) then 
                cant:=cant+1;
            write(maestro,regm); 
            
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(maestro);
    cerrarDetalles(detalles);
    writeln;
    writeln('Actualizacion realizada con exito.');
    if (cant>0) then 
        writeln('Hay ',cant,' localidades sin casas de chapa.');
end;

var 
    maestro:Text;
    bin:tbin;
    registros:tregistros;
    detalles:tdetalles;
begin 
    textToBin(maestro,bin);
    imprimirBin(bin);
    inicializarDetalles(detalles);
    actualizar(bin,registros,detalles);
    imprimirBin(bin);
end.