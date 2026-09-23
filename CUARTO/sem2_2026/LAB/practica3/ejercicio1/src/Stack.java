package ejercicio1;

public class Stack implements java.lang.Iterable {
    private java.util.ArrayList items;

    public Stack() {
       this.items = new java.util.ArrayList(); 
    }

    public void push(Object item) {
        items.add(item);
    }

    public Object pop() {
        return items.removeLast();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public java.util.Iterator iterator() {
        return new StackIterator();
    }

    private class StackIterator implements java.util.Iterator {
        private int i = 0;

        public boolean hasNext() {
            return items.size() > i;
        }

        public Object next() {
            Object item = items.get(i);
            i++;
            return item;
        }
    }
}
