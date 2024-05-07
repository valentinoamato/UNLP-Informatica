program test;
type 
    tdist = record 
        nombre:string[30];
        anno:integer;
        version:string[15];
        devs:integer;
        descripcion:string[45];
    end;
    tarch = file of tdist;

var 
    arch:tarch;

procedure leerDist(var dist:tdist);
begin 
    writeln;
    write('Ingrese nombre de dist (fin): ');
    readln(dist.nombre);
    if (dist.nombre<>'fin') then 
        begin
            write('Ingrese anno de dist: ');
            readln(dist.anno);
            write('Ingrese version de dist: ');
            readln(dist.version);
            write('Ingrese devs de dist: ');
            readln(dist.devs);
            write('Ingrese descripcion de dist: ');
            readln(dist.descripcion);
        end;
end;

procedure escribirDist(dist:tdist);
begin 
    writeln(' Nombre: ',dist.nombre,
            ' Anno: ',dist.anno,
            ' Version: ',dist.version,
            ' Devs: ',dist.devs,
            ' Descripcion: ',dist.descripcion
            );
end;

procedure cabecera();
var 
    dist:tdist;
begin 
    dist.anno:= 0;
    rewrite(arch);
    write(arch,dist);
    close(arch);
end;

procedure cargar();
var 
    dist:tdist;
begin 
    writeln('Iniciando carga...');
    cabecera();
    reset(arch);
    seek(arch, 1);
    leerDist(dist);
    while (dist.nombre<>'fin') do 
        begin 
            write(arch,dist);
            leerDist(dist);
        end;
    close(arch);
end;

procedure agregarAlFinal(dist:tdist);
begin 
    reset(arch);
    seek(arch,filesize(arch));
    write(arch,dist);
    close(arch);
end;

procedure agregar();
var 
    nuevo,aux:tdist;
    enlace:integer;
begin 
    reset(arch);
    leerDist(nuevo);
    if (eof(arch)) then 
        begin
            cabecera();
            reset(arch);
            agregarAlFinal(nuevo);
        end
    else 
        begin 
            read(arch,aux);
            enlace:=aux.anno;
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
    dist,aux:tdist;
    found:boolean;
begin 
    write('Ingrese el nombre de la dist a modificar: ');
    readln(dist.nombre);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.nombre=dist.nombre) then 
                begin 
                    write('Ingrese anno de dist: ');
                    readln(dist.anno);
                    write('Ingrese version de dist: ');
                    readln(dist.version);
                    write('Ingrese devs de dist: ');
                    readln(dist.devs);
                    write('Ingrese descripcion de dist: ');
                    readln(dist.descripcion);
                    seek(arch,filepos(arch)-1);
                    write(arch,dist);
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('No se encontro la dist con nombre ',dist.anno,'.');
    close(arch);
end;

procedure existe();
var 
    dist,aux:tdist;
    found:boolean;
begin 
    write('Ingrese el nombre de la dist a buscar: ');
    readln(dist.nombre);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.nombre=dist.nombre) then 
                begin 
                    writeln('La distribucion "',dist.anno,'" existe.');
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('La distribucion "',dist.anno,'" NO existe.');
    close(arch);
end;

procedure eliminar();
var 
    aux:tdist;
    i,j:integer;
    found:boolean;
    nombre:string;
begin 
    write('Ingrese el nombre de la dist a eliminar: ');
    readln(nombre);
    reset(arch);
    found:=False;
    while (not eof(arch)) and (not found) do 
        begin 
            read(arch,aux);
            if (aux.nombre=nombre) then 
                begin 
                    i:=filepos(arch)-1;
                    seek(arch,0);
                    read(arch,aux);
                    j:=aux.anno;
                    aux.anno:=i*-1;
                    seek(arch,0);
                    write(arch,aux);
                    seek(arch,i);
                    aux.anno:=j;
                    write(arch,aux);
                    found:=True;
                end;
        end;
    if (not found) then 
        writeln('No se encontro la dist con nombre ',nombre,'.');
end;

procedure imprimir();
var 
    dist:tdist;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,dist);
            if (dist.anno>0) then
                escribirDist(dist);
        end;
    close(arch);
end;

procedure debug();
var 
    dist:tdist;
begin 
    reset(arch);
    while (not eof(arch)) do 
        begin   
            read(arch,dist);
            escribirDist(dist);
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
            writeln('1 - Agregar Dist.');
            writeln('2 - Modificar Dist.');
            writeln('3 - Eliminar Dist.');
            writeln('4 - Imprimir Dists.');
            writeln('5 - Buscar Dist.');
            writeln('6 - Debug.');
            writeln('7 - Terminar Programa.');
            write('--> ');
            readln(input);
            case input of 
                1: agregar();
                2: modificar();
                3: eliminar();
                4: imprimir();
                5: existe();
                6: debug();
                7: break;
                else writeln('Operacion Invalida.');
            end;
        end;
end;

begin
    menu();
end.