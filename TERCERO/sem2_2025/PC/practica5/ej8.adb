with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics.Discrete_Random;

procedure Ej8 is
P: Integer:=10;
type IntP is array (1..P) of Integer;

task type Persona is
    entry SetId(Id: IN Integer);
    entry Atender;
end Persona;

Personas: array(1..P) of Persona;

task type Camion;

Camions: array(1..3) of Camion;

task Empresa is
    entry Reclamo(Persona: IN Integer);
    entry Next(Persona: OUT Integer);
end Empresa;

function RandomInt return Integer is
    package Random_Int is new Ada.Numerics.Discrete_Random(Integer);
    Gen  : Random_Int.Generator;
    Dato : Integer;
begin
    Random_Int.Reset(Gen);
    return Random_Int.Random(Gen) mod 101;
end RandomInt;

procedure RandomDelay is
begin
    delay Duration(RandomInt) / 50.0;
end RandomDelay;

function GetMax(Similitudes: IntP) return Integer is
    Max: Integer := -10;
    IdMax: Integer:= 0;
begin
    for I in 1..P loop
        if Similitudes(I) > Max then
            Max:=Similitudes(I);
            IdMax:=I;
        end if;
    end loop;

    return IdMax;
end GetMax;

task body Empresa is
    Test: Integer;
    Reclamos: IntP; --Reclamos de cada persona 
    Camion: Integer;
    MaxId: Integer;
begin
    for i in 1..P loop
        Reclamos(i):=0;
    end loop;

    loop
        --Acepto reclamos (al menos uno)
        accept Reclamo(Persona: IN Integer) do
            Reclamos(Persona):=Reclamos(Persona)+1;
            Put_Line("Reclamo de persona "&Integer'Image(Persona));
        end Reclamo;
        loop
            select
                accept Reclamo(Persona: IN Integer) do
                    Reclamos(Persona):=Reclamos(Persona)+1;
                    Put_Line("Reclamo de persona "&Integer'Image(Persona));
                end Reclamo;
            else
                exit;
            end select;
        end loop;

        -- Persona con mas reclamos
        MaxId:=GetMax(Reclamos);

        --Espero a un camion y le digo que atienda a la persona
        accept Next(Persona: OUT Integer) do
            Persona:=MaxId;
        end Next;

        --Borro los reclamos
        Reclamos(MaxId):=0;

        delay 0.5; --Anti Spam
    end loop;
end Empresa;

task body Persona is
    Id: Integer;
    Atendido: Boolean:=false;
begin
    -- Recibir Id
    accept SetId(Id: IN Integer) do
        Persona.Id:=Id;
    end SetId;

    RandomDelay;


    while (not Atendido) loop
        Empresa.Reclamo(Id);
        select
            accept Atender;
            Atendido:=true;
        or delay 5.0;
            null;
        end select;
    end loop;
end Persona;

task body Camion is
    Persona: Integer;
begin
    loop
        Empresa.Next(Persona);
        Personas(Persona).Atender;
        Put_Line("");
        Put_Line("---> Persona "&Integer'Image(Persona)&" atendida");
        Put_Line("");
        delay 3.0;

    end loop;
end Camion;

begin
    for I in 1..P loop
        Personas(I).SetId(I);
    end loop;
end Ej8;

