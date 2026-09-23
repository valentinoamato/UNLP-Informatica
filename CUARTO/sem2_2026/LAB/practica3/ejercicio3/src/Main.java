package ejercicio3;

import java.util.Iterator;

import ejercicio3.StringConverterSet;

public class Main {
    public static void main(String[] args) {

        StringConverterSet set = new StringConverterSet();
        set.add(100);
        set.add("Hola Mundo");
        set.add(3.1416);

        for (Object elemento : set) {
            System.out.println(elemento);
        }
    }
}
