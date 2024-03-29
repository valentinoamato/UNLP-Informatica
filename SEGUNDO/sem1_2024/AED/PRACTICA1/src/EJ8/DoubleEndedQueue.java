package EJ8;

public class DoubleEndedQueue<T> extends Queue<T> {
	
	public void enqueueFirst(T dato) {
		this.data.add(0, dato);
	}
	
	public T dequeueLast() {
		return this.data.remove(size()-1);
	}
}
