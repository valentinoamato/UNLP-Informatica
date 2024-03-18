program test;
type 
    tcelular = record
        codigo:integer;
        precio:real;
        marca:string[15];
        disponible:integer; //stock disponible
        minimo:integer;   //stock minimo
        descripcion:string[30];
        nombre:string[20];
    end;

    tarch = file of tcelular;

procedure imprimirCelular(celular:tcelular);
begin 
    writeln('Codigo: ',celular.codigo,
            ', Precio:',celular.precio:0:2,
            ', Marca:',celular.marca,
            ', Stock disponible:',celular.disponible,
            ', Stock minimo:',celular.minimo,
            ', Descripcion:',celular.descripcion,
            ', Nombre: ',celular.nombre
            );
end;

procedure leerCelular(var celular:tcelular);
begin 
    writeln;
    write('Ingrese codigo: ');
    readln(celular.codigo);
    write('Ingrese precio: ');
    readln(celular.precio);
    write('Ingrese marca: ');
    readln(celular.marca);
    write('Ingrese stock disponible: ');
    readln(celular.disponible);
    write('Ingrese stock minimo: ');
    readln(celular.minimo);
    write('Ingrese descripcion: ');
    readln(celular.descripcion);
    write('Ingrese nombre: ');
    readln(celular.nombre);
end;

procedure cargar(var arch:tarch);
var 
    nombre:string;
    txt:Text;
    celular:tcelular;
begin 
    writeln;
    writeln('Cargando datos desde "celulares.txt".');
    write('Ingrese el nombre del archivo binario: ');
    readln(nombre);
    assign(arch, nombre);
    rewrite(arch);
    assign(txt,'celulares.txt');
    reset(txt);

    while (not eof(txt)) do 
        begin 
            readln(txt,celular.codigo,celular.precio,celular.marca);
            readln(txt,celular.disponible,celular.minimo,celular.descripcion);
            readln(txt,celular.nombre);
            write(arch, celular);
        end;
    close(txt);
    close(arch);
end;

procedure agregar(var arch:tarch);
var 
    celular: tcelular;
    opcion: string;
begin
    reset(arch);
    seek(arch, filesize(arch));
    leerCelular(celular);
    while (True) do 
        begin 
            write(arch, celular);   
            writeln;
            write('Desea ingresar otro celular [s/n]?');
            readln(opcion);
            if (opcion = 'n') then 
                break
            else 
                leerCelular(celular);
        end;
    close(arch);
end;

procedure modificar(var arch:tarch);
var
    nombre:string;
    stock:integer;
    celular: tcelular;
    found: boolean;
begin   
    reset(arch);
    found:=False;
    write('Ingrese el nombre del celular: ');
    readln(nombre);
    while (not eof(arch)) do 
        begin 
            read(arch, celular);
            if (celular.nombre = nombre) then 
                begin 
                    found:=True;
                    break;
                end;
        end;
    if (found) then
        begin
            write('Ingrese el nuevo stock:');
            readln(stock);
            seek(arch, filepos(arch)-1);
            celular.disponible:=stock;
            write(arch, celular);
        end
    else 
        begin
            writeln;
            writeln('No existe el celular ',nombre,'.');
        end;
    close(arch);
end;

procedure mostrar(var arch:tarch);
var 
    celular:tcelular;
begin 
    reset(arch);
    writeln;
    writeln('Los celulares cargados son: ');
    while (not eof(arch)) do 
        begin 
            read(arch,celular);
            imprimirCelular(celular);
        end;
    close(arch);
end;

procedure mostrarStockCrit(var arch:tarch);
var 
    celular:tcelular;
    found:boolean;
begin 
    found:=False;
    reset(arch);
    writeln;
    while (not eof(arch)) do 
        begin 
            read(arch,celular);
            if (celular.disponible<celular.minimo) then
                begin
                    if (not found) then
                        begin
                            writeln('Los celulares con stock menor al minimo son: ');
                            found:=True;
                        end;
                    imprimirCelular(celular);
                end;
        end;
    if (not found) then 
        writeln('No se encontraron coincidencias.');
    close(arch);
end;

procedure buscar(var arch:tarch);
var 
    query: string;
    found:boolean;
    celular:tcelular;
begin 
    found:=False;
    writeln;
    write('Ingrese la descripcion a buscar: ');
    readln(query);
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch,celular);
            if (pos(query,celular.descripcion)<>0) then 
                begin 
                    if (not found) then 
                        begin 
                            writeln('Las coincidencias encontradas son: ');
                            found:=True;
                        end;
                    imprimirCelular(celular);
                end;
        end;
    if (not found) then 
        writeln('No se encontraron coincidencias.');
    close(arch);
end;

procedure exportar(var arch:tarch);
var 
    txt:Text;
    celular:tcelular;
begin 
    assign(txt,'celulares.txt');
    rewrite(txt);
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch, celular);
            writeln(txt,celular.codigo,' ',celular.precio:0:2,' ',celular.marca);
            writeln(txt,celular.disponible,' ',celular.minimo,' ',celular.descripcion);
            writeln(txt,celular.nombre);
        end;
    close(arch);
    close(txt);
end;

procedure exportarSinStock(var arch:tarch);
var 
    txt:Text;
    celular:tcelular;
begin 
    assign(txt,'SinStock.txt');
    rewrite(txt);
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch, celular);
            if (celular.disponible = 0) then 
                begin
                    writeln(txt,celular.codigo,' ',celular.precio:0:2,' ',celular.marca);
                    writeln(txt,celular.disponible,' ',celular.minimo,' ',celular.descripcion);
                    writeln(txt,celular.nombre);
                end;
        end;
    close(arch);
    close(txt);
end;

procedure runMenu(var arch:tarch);
var 
    opcion:string;
begin 
    while (True) do     
        begin 
            writeln;
            writeln('Ingrese la operacion deseada:');
            writeln('1 - Cargar datos.');
            writeln('2 - Agregar celular.');
            writeln('3 - Modificar stock.');
            writeln('4 - Mostrar celulares cargados.');
            writeln('5 - Mostrar celulares con stock menor al minimo.');
            writeln('6 - Buscar por descripcion.');
            writeln('7 - Exportar datos.');
            writeln('8 - Exportar celulares sin stock.');
            writeln('9 - Finalizar programa.');
            write('--> ');
            readln(opcion);
            case opcion of 
                '1': cargar(arch);
                '2': agregar(arch);
                '3': modificar(arch);
                '4': mostrar(arch);
                '5': mostrarStockCrit(arch);
                '6': buscar(arch);
                '7': exportar(arch);
                '8': exportarSinStock(arch);
                '9': break;
            else 
                writeln('La operacion ingresada es invalida.');
            end;
        end;
end;

var 
    archivo:tarch;
begin 
    cargar(archivo);
    runMenu(archivo);
end.