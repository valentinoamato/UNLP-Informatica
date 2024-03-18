program pipipi;
type 
    tnovela = record 
        codigo:longint;
        nombre:string[40];
        genero:string[20];
        precio:real;
    end;

    tarch = file of tnovela;

procedure imprimirNovela(novela:tnovela);
begin 
    writeln('Codigo: ',novela.codigo,
            ', Nombre:',novela.nombre,
            ', Genero:',novela.genero,
            ', Stock precio:',novela.precio:0:2
            );
end;

procedure leerNovela(var novela:tnovela);
begin 
    writeln;
    write('Ingrese codigo: ');
    readln(novela.codigo);
    write('Ingrese nombre: ');
    readln(novela.nombre);
    write('Ingrese genero: ');
    readln(novela.genero);
    write('Ingrese precio: ');
    readln(novela.precio);
end;

procedure cargar(var arch:tarch);
var 
    nombre:string;
    txt:Text;
    novela:tnovela;
begin 
    writeln;
    writeln('Cargando datos desde "novelas.txt".');
    write('Ingrese el nombre del archivo binario: ');
    readln(nombre);
    assign(arch, nombre);
    rewrite(arch);
    assign(txt,'novelas.txt');
    reset(txt);

    while (not eof(txt)) do 
        begin 
            readln(txt,novela.codigo,novela.precio,novela.genero);
            readln(txt,novela.nombre);
            write(arch, novela);
        end;
    close(txt);
    close(arch);
end;

procedure agregar(var arch:tarch);
var 
    novela: tnovela;
    opcion: string;
begin
    reset(arch);
    seek(arch, filesize(arch));
    leerNovela(novela);
    while (True) do 
        begin 
            write(arch, novela);   
            writeln;
            write('Desea ingresar otra novela [s/n]?');
            readln(opcion);
            if (opcion = 'n') then 
                break
            else 
                leerNovela(novela);
        end;
    close(arch);
end;

procedure modificar(var arch:tarch);
var
    codigo:integer;
    novela: tnovela;
    found: boolean;
begin   
    reset(arch);
    found:=False;
    write('Ingrese el codigo del la novela: ');
    readln(codigo);
    while (not eof(arch)) do 
        begin 
            read(arch, novela);
            if (novela.codigo = codigo) then 
                begin 
                    found:=True;
                    break;
                end;
        end;
    if (found) then
        begin
            write('Ingrese los nuevos datos.');
            leerNovela(novela);
            seek(arch, filepos(arch)-1);
            write(arch, novela);
        end
    else 
        begin
            writeln;
            writeln('No existe la novela con codigo ',codigo,'.');
        end;
    close(arch);
end;

procedure mostrar(var arch:tarch);
var 
    novela:tnovela;
begin 
    reset(arch);
    writeln;
    writeln('Las novelas cargadas son: ');
    while (not eof(arch)) do 
        begin 
            read(arch,novela);
            imprimirNovela(novela);
        end;
    close(arch);
end;

procedure exportar(var arch:tarch);
var 
    txt:Text;
    novela:tnovela;
begin 
    assign(txt,'novelas.txt');
    rewrite(txt);
    reset(arch);
    while (not eof(arch)) do 
        begin 
            read(arch, novela);
            writeln(txt,novela.codigo,' ',novela.precio:0:2,' ',novela.genero);
            writeln(txt,novela.nombre);
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
            writeln('2 - Agregar novela.');
            writeln('3 - Modificar novela.');
            writeln('4 - Mostrar novelas cargadas.');
            writeln('5 - Exportar datos.');
            writeln('6 - Finalizar programa.');
            write('--> ');
            readln(opcion);
            case opcion of 
                '1': cargar(arch);
                '2': agregar(arch);
                '3': modificar(arch);
                '4': mostrar(arch);
                '5': exportar(arch);
                '6': break;
            else 
                writeln('La operacion ingresada es invalida.');
            end;
        end;
end;
var 
    arch:tarch;
begin 
    cargar(arch);
    runMenu(arch);
end.
