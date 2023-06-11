// 5. La empresa Amazon Web Services (AWS) dispone de la información de sus 500 clientes monotributistas más
// grandes del país. De cada cliente conoce la fecha de firma del contrato con AWS, la categoría del
// monotributo (entre la A y la F), el código de la ciudad donde se encuentran las oficinales (entre 1 y 2400) y
// el monto mensual acordado en el contrato. La información se ingresa ordenada por fecha de firma de
// contrato (los más antiguos primero, los más recientes últimos).
// 1
// CADP – Práctica 4 (parte 2) – Vectores 2023
// Realizar un programa que lea y almacene la información de los clientes en una estructura de tipo vector.
// Una vez almacenados los datos, procesar dicha estructura para obtener:
// a. Cantidad de contratos por cada mes y cada año, y año en que se firmó la mayor cantidad de contratos
// b. Cantidad de clientes para cada categoría de monotributo
// c. Código de las 10 ciudades con mayor cantidad de clientes
// d. Cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes.
program aws;
const
    dimf=10;
type
    fecha=record
        mes:integer;
        anno:integer;
    end;



    vector = array [1..dimf] of fecha;

procedure leer (var reg:fecha);
begin
    writeln('||||||');
    writeln('Ingrese mes:');
    readln(reg.mes);
    writeln('Ingrese anno:');
    readln(reg.anno);
    writeln('||||||');
end;


procedure cargar (var v:vector);
var
    i:integer;
begin
    for i:=1 to dimF do
        leer(v[i]);
end;

procedure main (v:vector);
var
    annomax,maxcontratos,i:integer;
    anno,mes,contratosmes,contratosanno:integer;
begin
    i:=1;
    maxcontratos:=0;
    while (i<dimf) do
        begin
            contratosanno:=0;
            anno:=v[i].anno;
            while (i<dimf) and (anno=v[i].anno) do
                begin
                    mes:=v[i].mes;
                    contratosmes:=0;

                    while (i<dimf) and (anno=v[i].anno) and (mes=v[i].mes) do
                        begin
                            i:=i+1;
                            contratosanno:=contratosanno+1;
                            contratosmes:=contratosmes+1;
                        end;
                    writeln('Contratos en mes ',mes,' anno ',anno,' : ',contratosmes);
                end;
            if (contratosanno>maxcontratos) then
                annomax:=anno;
            writeln('Contratos en anno ',anno,' : ',contratosanno);
        end;
    writeln('El anno con mas contratos fue: ',annomax);
end;

var
    v:vector;

begin
    cargar(v);
    main(v);
end.