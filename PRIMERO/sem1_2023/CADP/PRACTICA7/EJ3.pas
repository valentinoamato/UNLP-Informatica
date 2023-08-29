program test;

type 
  viaje = record
    numero: integer;
    codigoAuto: integer;
    direccionOrigen: string;
    direccionFinal: string;
    kilometros: real;
  end;

  viajes = ^nodo;
  nodo = record
    dato: viaje;
    siguiente: viajes;
  end;

  max = record
    totalKm: real;
    codigoAuto: integer;
  end;

procedure leer(var reg: viaje);
begin
    writeln('viaje:');
    readln(reg.numero);
    writeln('auto:');
    readln(reg.codigoAuto);
    writeln('km:');
    readln(reg.kilometros);
    // writeln('dir');
    // readln(reg.direccionOrigen);
    // writeln('dir');
    // readln(reg.direccionFinal);
end;

procedure agregar(var pri: viajes; reg: viaje);

var 
  nuevo: viajes;
begin
  new(nuevo);
  nuevo^.dato := reg;
  nuevo^.siguiente := pri;

  pri := nuevo;
end;

procedure cargar(var pri: viajes);

var 
  nuevo: viaje;
begin
  leer(nuevo);

  while (nuevo.codigoAuto <> 0) do
    begin
      agregar(pri,nuevo);
      leer(nuevo);
    end;
end;

procedure escribir(pri: viajes);
begin
  while (pri <> nil) do
    begin
        writeln('||||||||||||||||||||||||||||');
        writeln('viaje:');
        writeln(pri^.dato.numero);
        writeln('auto:');
        writeln(pri^.dato.codigoAuto);
        writeln('km:');
        writeln(pri^.dato.kilometros:0:2);
        pri := pri^.siguiente;
        writeln('||||||||||||||||||||||||||||');
        //   writeln(pri^.dato.direccionOrigen);
        //   writeln(pri^.dato.direccionFinal);
    end;
end;
procedure insertar (var lista:viajes;reg:viaje);
var
    anterior,actual,nuevo:viajes;

begin
    new(nuevo);
    nuevo^.dato:=reg;
    actual:=lista;
    anterior:=nil;
    while (actual<>nil) and (actual^.dato.numero<reg.kilometros) do
        begin
            anterior:=actual;
            actual:=actual^.siguiente;
        end;
    if (anterior<>nil) then
        begin
            anterior^.siguiente:=nuevo;
            nuevo^.siguiente:=actual;
        end
    else
        begin
            nuevo:=lista^.siguiente;
            lista:=nuevo;
        end;
    
procedure a(lista: viajes;var lista2:viajes);
var 
  max1, max2, actual: viaje;
  kmTotal: real;
begin
  max1.kilometros := 0;
  max2.kilometros := 0;

  while (lista <> nil) do
    begin
      kmTotal := 0;
      actual := lista^.dato;
      while ((lista <> nil) and (actual.codigoAuto = lista^.dato.codigoAuto)) do
        begin
          kmTotal := kmTotal + actual.kilometros;
          lista := lista^.siguiente;
        end;
      if (kmTotal > max1.kilometros) then
        begin
          max2 := max1;
          max1 := actual;
        end
      else
        if (kmTotal > max2.kilometros) then
            max2 := actual;
        if (lista^.dato.kilometros>5) then
            begin
                agregar(lista2,lista^.dato);




    end;

  writeln('Maximo 1 es: ', max1.codigoAuto);
  writeln('Maximo 2 es: ', max2.codigoAuto);
end;
// procedure b (pri:lista;var pri2:lista)
var 
    pri: viajes;
    pri2:viajes;
begin
    pri:=nil;
    cargar(pri);
    escribir(pri);
    a(pri,pri2);
    escribir(pri2);
end.