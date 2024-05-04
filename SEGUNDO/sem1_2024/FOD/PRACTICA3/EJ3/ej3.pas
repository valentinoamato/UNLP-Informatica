program test;
type 
    tnovela = record 
        codigo:integer;
        genero:string[15];
        nombre:string[30];
        duracion:real;
        director:string[15];
        precio:real;
    end;
    tarch = file of tnovela;

var 
    arch:tarch;

procedure leerNovela(var novela:tnovela);
begin 
    writeln;
    write('Ingrese codigo de novela (-1): ');
    readln(novela.codigo);
    if (novela.codigo<>-1) then 
        begin
            write('Ingrese genero de novela: ');
            readln(novela.genero);
            write('Ingrese nombre de novela: ');
            readln(novela.nombre);
            write('Ingrese duracion de novela: ');
            readln(novela.duracion);
            write('Ingrese director de novela: ');
            readln(novela.director);
            write('Ingrese precio de novela: ');
            readln(novela.precio);
        end;
end;

procedure escribirNovela(novela:tnovela);
begin 
    writeln(' Codigo: ',novela.codigo,
            ' Genero: ',novela.genero,
            ' Nombre: ',novela.nombre,
            ' Duracion: ',novela.duracion:0:2,
            ' Director: ',novela.director,
            ' Precio: ',novela.precio:0:2
            );
end;

procedure cabecera();
var 
    novela:tnovela;
begin 
    novela.codigo:= 0;
    rewrite(arch);
    write(arch,novela);
    close(arch);
end;

procedure cargar();
var 
    novela:tnovela;
begin 
    writeln('Iniciando carga...');
    cabecera();
    reset(arch);
    seek(arch, 1);
    leerNovela(novela);
    while (novela.codigo<>-1) do 
        begin 
            write(arch,novela);
            leerNovela(novela);
        end;
    close(arch);
end;

procedure agregarAlFinal(novela:tnovela);
begin 
    reset(arch);
    seek(arch,filesize(arch));
    write(arch,novela);
    close(arch);
end;


procedure agregar();
var 
    nuevo,aux:tnovela;
    enlace:integer;
begin 
    reset(arch);
    leerNovela(nuevo);
    if (eof(arch)) then 
        begin
            cabecera();
            reset(arch);
            agregarAlFinal(nuevo);
        end
    else 
        begin 
            read(arch,aux);
            enlace:=aux.codigo;
            if (enlace=0) then 
                agregarAlFinal(nuevo)
            else 
                begin 
                    seek(arch,abs(enlace));
                    read(arch,aux);
                    seek(arch,abs(enlace));
                    write(arch,nuevo);
                    seek(arch,0);
                    write(arch,aux);
                end;
        end;
end;

procedure modificar();
var 
    novela,aux:tnovela;
    found:boolean;
begin 
    write('Ingrese el codigo de la novela a modificar: ');
    readln(novela.codigo);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.codigo=novela.codigo) then 
                begin 
                    write('Ingrese genero de novela: ');
                    readln(novela.genero);
                    write('Ingrese nombre de novela: ');
                    readln(novela.nombre);
                    write('Ingrese duracion de novela: ');
                    readln(novela.duracion);
                    write('Ingrese director de novela: ');
                    readln(novela.director);
                    write('Ingrese precio de novela: ');
                    readln(novela.precio);
                    seek(arch,filepos(arch)-1);
                    write(arch,novela);
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('No se encontro la novela con codigo ',novela.codigo,'.');
end;

procedure eliminar();
var 
    aux:tnovela;
    i,j,codigo:integer;
    found:boolean;
begin 
    write('Ingrese el codigo de la novela a eliminar: ');
    readln(codigo);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.codigo=codigo) then 
                begin 
                    i:=filepos(arch)-1;
                    seek(arch,0);
                    read(arch,aux);
                    j:=aux.codigo;
                    aux.codigo:=i*-1;
                    seek(arch,0);
                    write(arch,aux);
                    seek(arch,i);
                    aux.codigo:=j;
                    write(arch,aux);
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('No se encontro la novela con codigo ',codigo,'.');
end;

procedure imprimir();
var 
    novela:tnovela;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,novela);
            if (novela.codigo>0) then
                escribirNovela(novela);
        end;
    close(arch);
end;

procedure exportar();
var 
    txt:Text;
    novela:tnovela;
begin 
    assign(txt,'novelas.txt');
    rewrite(txt);
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,novela);
            if (novela.codigo>0) then 
                begin
                    writeln(txt,' Codigo: ',novela.codigo,
                            ' Genero: ',novela.genero,
                            ' Nombre: ',novela.nombre,
                            ' Duracion: ',novela.duracion:0:2,
                            ' Director: ',novela.director,
                            ' Precio: ',novela.precio:0:2
                            );
                end;
        end;
    close(arch);
    close(txt);
end;

procedure debug();
var 
    novela:tnovela;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,novela);
            escribirNovela(novela);
        end;
    close(arch);
end;

procedure menu();
var 
    input:integer;
    ruta:string;
begin  
    write('Desea leer un archivo (1) o crear uno nuevo (2): ');
    readln(input);
    write('Ingrese la ruta del archivo: ');
    readln(ruta);
    assign(arch,ruta);
    if (input=2) then 
        cargar();

    while (true) do 
        begin 
            writeln;
            writeln;
            writeln('Ingrese la opcion deseada:');
            writeln('1 - Agregar Novela.');
            writeln('2 - Modificar Novela.');
            writeln('3 - Eliminar Novela.');
            writeln('4 - Imprimir Novelas.');
            writeln('5 - Exportar Novelas.');
            writeln('6 - Debug.');
            writeln('7 - Terminar Programa.');
            write('--> ');
            readln(input);
            case input of 
                1: agregar();
                2: modificar();
                3: eliminar();
                4: imprimir();
                5: exportar();
                6: debug;
                7: break;
                else writeln('Operacion Invalida.');
            end;
        end;
end;

begin
    menu();
end.