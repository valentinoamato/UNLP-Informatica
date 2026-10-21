package org.example;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.lang.annotation.ElementType;

// Permite consultar la anotacion mediante refexion durante la ejecucion
@Retention(RetentionPolicy.RUNTIME)

// Permite colocarla sobre metodos
@Target(ElementType.METHOD)

public @interface Invocar {
}
