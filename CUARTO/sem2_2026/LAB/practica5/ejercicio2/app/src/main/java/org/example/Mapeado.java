package org.example;

@Archivo(nombre="AchivoMapeado.txt")
public class Mapeado {
    @AlmacenarAtributo
    private String valor = "Default1";

    @AlmacenarAtributo
    private Integer valor2=20;

    @AlmacenarAtributo
    private Float valor3=30.20f;

    private Float valor4=30.20f;
    //agregar: Metodos getters y setters
}
