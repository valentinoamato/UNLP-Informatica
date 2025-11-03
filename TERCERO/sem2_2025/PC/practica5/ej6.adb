with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej6 is
    len: Integer := 100000; -- Debe ser multiplo de 10
    type NumsT is array (1..(len/10)) of Integer;

task type Worker is
    entry Iniciar;
end Worker;

Workers: array(1..10) of Worker;

task Coordinador is
    entry Resultado(Parcial: IN Float);
end Coordinador;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return Random_Int.Random(Gen) mod 111;
end RandomInt;

procedure RandomDelay is
begin
    delay Duration(RandomInt) / 3.0;
end RandomDelay;

function GetNums return NumsT is
    Nums: NumsT;
begin
    for i in 1..(len / 10) loop
        Nums(i):=RandomInt;
    end loop;
    return Nums;
end GetNums;




task body Coordinador is
    Promedio: Float:=0.0;
begin
    -- Iniciar
    for I in 1..10 loop
        Workers(I).iniciar;
    end loop;

    -- Recibir resultados parciales
    for I in 1..10 loop
        accept Resultado(Parcial: IN Float) do
            Promedio:=Promedio+Parcial;
        end Resultado;
    end loop;

    Put_Line("El promedio es: " & Float'Image(Promedio)); 
end Coordinador;

task body Worker is
    Parcial: Float:=0.0;
    Nums:NumsT;
begin
    -- Cargar nums
    Nums:=GetNums;

    -- Esperar a iniciar
    accept Iniciar;
    Put_Line("Worker Inicia");

    -- Generar resultado parcial
    for i in 1..(len / 10) loop
        Parcial:=Parcial + Float(Nums(i));
    end loop;
    Parcial:=Parcial / Float(len);

    -- Informo los resultados
    Coordinador.Resultado(Parcial);
end Worker;


begin
    null;
end Ej6;

