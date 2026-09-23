package ejercicio1;

public class Main {
    public static void main(String[] args) {
        Stack stack = new Stack();
        stack.push("String 1");
        stack.push("String 2");
        stack.push("String 3");
        stack.push("String 4");

        for (Object item: stack) {
            System.out.println(item);
        }
    }
}
