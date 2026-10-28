package org.example;

import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.Class;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.charset.StandardCharsets;

public class Procesador {

    public static void procesar(Object object) {
        try {
            System.out.println("Procesando...");
            Class<?> c = object.getClass();
            String contenido = "<nombreClase>"+c.getName()+"</nombreClase>\n";
            Archivo archivo = c.getAnnotation(Archivo.class);

            if (archivo == null) {
                throw new IllegalArgumentException(
                    "La clase del objeto debe tener @Archivo"
                );
            }

            Field[] campos = c.getDeclaredFields();
            for (Field f : campos) {
                if (f.getAnnotation(AlmacenarAtributo.class) == null) {
                    throw new IllegalArgumentException(
                        "El atributo debe tener @AlmacenarAtributo"
                    );
                }
                String nombreAtributo = f.getName();
                nombreAtributo = nombreAtributo.substring(0, 1).toUpperCase() + nombreAtributo.substring(1);
                contenido += "<nombreAtributo>"+f.getName()+"</nombreAtributo>\n";
                Object value = f.get(o);
                contenido += "<nombreValor>"+value.toString()+"</nombrenombreValor>\n";
            }

            escribir(archivo, contenido);
        } catch (Exception e) {
            System.out.println(e.getClass().getName());
            System.out.println(e.getMessage());
        }
    }

    private static void escribir(Archivo archivo, String contenido) {
        try {
            Files.write(
                Path.of(archivo.nombre()),
                contenido.getBytes(StandardCharsets.UTF_8)
            );
        } catch (IOException e) {
            System.err.println("Error al escribir " + archivo.nombre()+": "+e.getMessage());
        }
    }
}
