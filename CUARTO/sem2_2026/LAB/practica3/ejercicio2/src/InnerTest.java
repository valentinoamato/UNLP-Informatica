package ejercicio2;

public class InnerTest {
    public static void main(String[] args) {
        //InnerStatic innerStatic = new InnerStatic();
        System.out.println(InnerStatic.Circulo.getArea(2.0));
        System.out.println(InnerStatic.Circulo.getArea(3.0));
        System.out.println(InnerStatic.Circulo.getLongitudCircunferencia(2.0));
        System.out.println(InnerStatic.Circulo.getLongitudCircunferencia(3.0));
    }
}
