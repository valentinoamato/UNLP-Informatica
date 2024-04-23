package EJ3;

import java.util.List;
import java.util.ArrayList;

public class Queue<T> {
	
	protected List<T> data; 
	
	public Queue() {
		this.data = new ArrayList<T>();
	}

	public void enqueue(T element) {
		data.add(element);
	}
	
	public T dequeue() {
		return data.remove(0);
	}
	
	public boolean isEmpty() {
		return data.isEmpty();
	}
	
}
