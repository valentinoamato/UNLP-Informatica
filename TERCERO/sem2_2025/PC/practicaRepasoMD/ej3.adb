with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej3 is
S: Integer:= 10; --Cant sucursales
P: Integer:=100; --Cant productos
type TCant is array(1..P) of Integer; --Cantidades de cada producto

task type Sucursal;

Sucursales: array(1..S) of Sucursal;

task Central is
    entry Next(Articulo: OUT Integer);
    entry Resultado(Cant: IN Integer);
    entry Continuar;
end Central;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return ((Random_Int.Random(Gen)-1) mod 100);
end RandomInt;

procedure RandomDelay is
begin
    delay Duration(RandomInt) / 20.0;
end RandomDelay;

task body Central is
    Cantidades: TCant;
    Cant: Integer;
    Actual: Integer;
begin
    --Inicializar Cantidades
    for i in 1..P loop
        Cantidades(i):=0;
    end loop;

    for i in 1..P loop
        --generarArticulo()
        Actual:=i;

        for j in 1..(S*2) loop
            select
                accept Next(Articulo: OUT Integer) do
                    Articulo:=Actual;
                end Next;
            or
                accept Resultado(Cant: IN Integer) do
                    Cantidades(i):=Cantidades(i)+Cant;
                end Resultado;
            end Select;
        end loop;

        --Informar
        Put_Line("");
        Put_Line("Cantidad Total de Producto " & Integer'Image(i)&": " & Integer'Image(Cantidades(i)));
        Put_Line("");

        delay 0.2; --Anti Spam

        for j in 1..S loop
            accept Continuar;
        end loop;
    end loop;
end Central;

task body Sucursal is
    Cantidades: TCant;
    Articulo: Integer;
    Cant: Integer;
begin
    --Cargar cantidades
    for i in 1..P loop
        Cantidades(i):=RandomInt;
    end loop;

    for i in 1..P loop
        RandomDelay;
        Central.Next(Articulo);

        --ObtenerVentas(ID)
        Cant:=Cantidades(Articulo);
        Put(Integer'Image(Cant)&" ");

        Central.Resultado(Cant);

        Central.Continuar;
    end loop;
end Sucursal;

begin
    null;
end Ej3;


