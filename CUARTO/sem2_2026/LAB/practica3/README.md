# Practica 3
### Ejercicio 1
#### 1D, 1E)
Es posible crear objetos de la clase anidada desde una clase diferente a la contenedora, siempre y cuando la clase anidada tenga la visibilidad necesaria (no sea privada).

```java
Stack miPila = new Stack();
// Instanciación desde otra clase:
Stack.StackIterator it = miPila.new StackIterator();
```

### Ejercicio 2
#### 2D)
La inferencia de tipos de variables locales determina el tipo de la variable en tiempo de compilacion evaluando el tipo de la expresion a la derecha de la asignacion.

Se puede usar en cualquier variable local dentro de un metodo o bloque de codigo.
```java
var area = InnerStatic.Circulo.getArea();
```

### Ejercicio 4
- Las clases anonimas se declaran e instancian simultaneamente en una unica expresion en el mismo lugar donde se necesitan dentro del codigo. Como no poseen un nombre, es imposible invocar a un constructoir para crear nuevas instancias.
- Son ampliamente utilizadas para pasar comportamiento al vuelo, como la creacion de objetos funcion.
- El operador `instanceof` se puede utilizar con una instancia de una clase anonima, contra el tipo de la interfaz que implementa o la clase que extiende.
- Una clase anonima siempre extiende exactamente una unica clase o implementa una unica interfaz.

### Ejercicio 5
#### 1)
Las clases anonimas son utiles cuando la clase se necesita en un solo lugar especifico del codigo, por ejemplo para devolver un iterador o un comparador.

#### 2)
Hay tres formas de inicializar valores de una clase anonima:
1. Inicializacion directa del atributo.
2. Uso del constructor de la superclase.
3. Uso de las variables locales del entorno.
4. Uso de bloques de inicializacion.
