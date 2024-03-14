program test;
type 
    tarchivo = file of integer;

procedure asignar(var archivo:tarchivo);
var
    ruta:string;
begin
    write('Ingrese la ruta del archivo a leer:');
    readln(ruta);
    Assign(archivo, ruta);
end;

procedure cargar(var archivo:tarchivo);
var
    numero: integer;
begin   
    Rewrite(archivo);
    write('Ingrese un numero entero (3000 para finalizar):');
    readln(numero);
    while (numero<>3000) do 
        begin   
            write(archivo,numero);
            write('Ingrese un numero entero:');
            readln(numero);
        end;
    close(archivo);
end;

procedure procesar(var archivo:tarchivo;var cant:integer;var promedio:real);
var 
    numero,canttotal,menores,suma:integer;
    
begin
    canttotal:=0;
    suma:=0;
    cant:=0;
    promedio:=0;
    reset(archivo);
    writeln('Los numeros guardados son:');
    while (not eof(archivo)) do 
        begin 
            read(archivo,numero);
            writeln(' - ',numero);

            suma:=suma+numero;
            canttotal:=canttotal+1;

            if (numero<1500) then 
                cant:=cant+1;
        end;
    if canttotal>0 then
        promedio:=(suma/canttotal);
end;

var 
    arch: tarchivo;
    cant:integer;
    promedio:real;
begin 
    asignar(arch);
    procesar(arch,cant,promedio);
    writeln('La cantidad de numeros leidos, menores a 1500, es: ',cant);
    writeln('El promedio de los numeros leidos es: ',promedio:0:2);
end.