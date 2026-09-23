package ejercicio3;

import java.util.AbstractSet;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

public class StringConverterSet extends AbstractSet {
    private final Set<Object> elementos;

    public StringConverterSet() {
        this.elementos = new HashSet<>();
    }

    @Override
    public boolean add(Object element) {
        return elementos.add(element);
    }

    @Override
    public Iterator iterator() {
        return new IteratorStringAdapter(elementos.iterator());
    }

    @Override
    public int size() {
        return elementos.size();
    }

    private class IteratorStringAdapter implements Iterator<String> {
        private final Iterator iteratorOriginal;

        public IteratorStringAdapter(Iterator iterator) {
            this.iteratorOriginal = iterator;
        }

        @Override
        public boolean hasNext() {
            return iteratorOriginal.hasNext();
        }

        @Override
        public String next() {
            return (this.hasNext()) ? iteratorOriginal.next().toString() : null;
        }
    }
}
