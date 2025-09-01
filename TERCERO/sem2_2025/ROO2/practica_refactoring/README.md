# Refactoring

### Ejercicio 1.1
Los nombres son poco descriptivos, aplico Rename Method (Cual es el bad smell?):
- lmtCrdt -> getLimiteDeCredito
- mtFcE -> getMontoFacturado
- mtCbE -> getMontoCobrado

Los nombres de los argumentos son pocos descriptivos, aplico Rename Variable (En el libro dice que se deben renombrar variables y clases, pero que no se agregaron como refactoring por ser simples. Hago de cuenta que existe el refactoring Rename Variable/Rename parameter? cual seria el bad smell?).

LocalDate f1, LocalDate f2 -> LocalDate desde, LocalDate hasta

### Ejercicio 1.2
El diseño inicial tiene el bad smell de Feature Envy ya que en el metodo participaEnProyecto de Persona se le pide a la clase Proyecto los participantes, cuando seria mas eficiente que la busqueda se de directamente en la clase Proyecto que conoce los participantes. Para solucionarlo entonces se aplica el refactoring Move Method y ademas se aplica Rename Method para cambiar el nombre a uno mas corto e igualmente descriptivo.

### Ejercicio 1.3
1. El loop se puede remplazar con el uso de pipelines para mejorar la legibilidad. Replace Loop with Pipeline. Cual es el bad smell?
2. El metodo no solo imprime valores sino que tambien los calcula. Long Method -> Extract Method. Extraigo la funcionalidad del calculo a un nuevo metodo llamado calcularValores().

### Ejercicio 2
