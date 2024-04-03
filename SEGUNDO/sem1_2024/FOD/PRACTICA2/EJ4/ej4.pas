program test;

Uses sysutils;
const 
    valoralto = 'ZZZZ';
type 
    tprovincia =  record 
        nombre:string[25];
        cant:integer;  //cantidad de alfabetizados
		total:integer; //total de encuestados
    end;

    tdetalle = record 
        nombre:string[25];
        cant:integer;  //cantidad de alfabetizados
		total:integer; //total de encuestados
        localidad:integer;
    end;

    tbin = file of tprovincia;

procedure leer(var det:Text;var regd:tdetalle);
begin
    if (eof (det)) then 
        regd.nombre:=valoralto
    else 
        begin
            readln(det,regd.localidad,regd.cant,regd.total,regd.nombre);
            regd.nombre:=trim(regd.nombre);
        end;
end;

procedure imprimirProvincia(p:tprovincia);
begin 
    writeln(' Nombre: ',p.nombre,' Alfabetizados: ',p.cant,' Encuestados: ',p.total);
end;

procedure imprimirBin(var bin:tbin);
var 
    provincia:tprovincia;
begin 
    reset(bin);
    writeln;
    writeln('Los provincias en el archivo maestro son:');
    while (not eof(bin)) do
        begin
            read(bin,provincia);
            imprimirProvincia(provincia);
        end;
    close(bin);
end;


procedure textToBin(var txt:Text;var bin:tbin);
var 
    reg:tprovincia;
begin 
    assign(bin,'maestro.dat');
    reset(txt);
    rewrite(bin);
    while (not eof(txt)) do 
        begin
            readln(txt,reg.cant,reg.total,reg.nombre);
            reg.nombre:=trim(reg.nombre);
            write(bin,reg);
        end;
    close(txt);
    close(bin);
end;

procedure minimo(var detalle1,detalle2:Text;var regd1,regd2,min:tdetalle);
begin
    if (regd1.nombre<=regd2.nombre) then 
        begin 
            min:=regd1;
            leer(detalle1,regd1);
        end
    else 
        begin 
            min:=regd2;
            leer(detalle2,regd2);
        end;
end;    

procedure actualizar(var maestro:tbin;var detalle1,detalle2:Text);
var 
    regm:tprovincia;
    regd1,regd2,min:tdetalle;
    cant,total:integer;
    nombre:string;
begin 
    reset(detalle1);
    reset(detalle2); 
    reset(maestro);

    leer(detalle1,regd1);
    leer(detalle2,regd2);
    minimo(detalle1,detalle2,regd1,regd2,min);
    read(maestro,regm);
    while (min.nombre<>valoralto) do 
        begin
            nombre:=min.nombre;
            cant:=0;
            total:=0;

            while (nombre=min.nombre) do 
                begin 
                    cant:=cant+min.cant;
                    total:=total+min.total;
                    minimo(detalle1,detalle2,regd1,regd2,min);
                end;
            while (regm.nombre<>nombre) do 
                begin
                    read(maestro,regm);
                end;
            regm.total:=regm.total+total;
            regm.cant:=regm.cant+cant;
            seek(maestro,filepos(maestro)-1);
            write(maestro,regm); 
            if (not eof(maestro)) then 
                read(maestro, regm);
        end;
    close(detalle1);
    close(detalle2);
    close(maestro);
    writeln;
    writeln('Actualizacion realizada con exito.');
end;

var 
    detalle1,detalle2,maestro:Text;
    bin:tbin;
begin 
    assign(maestro,'maestro.txt');
    textToBin(maestro,bin);
    imprimirBin(bin);
    assign(detalle1,'detalle1.txt');
    assign(detalle2,'detalle2.txt');
    actualizar(bin,detalle1,detalle2);
    imprimirBin(bin);
end.