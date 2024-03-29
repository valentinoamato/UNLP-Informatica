package EJ8;

import java.util.*;

public class Queue<T> extends Sequence {
	protected List<T> data;
	
	public Queue() {
		data = new LinkedList<T>();
	}
	
	public void enqueue(T dato) {
		data.add(dato);
	}
	
	public T dequeue() {
		return data.remove(0);
	}
	
	public T head() {
		return data.get(0);
	}
	
	@Override
	public int size() {
		return data.size();
	}
	
	@Override
	public boolean isEmpty() {
		return data.isEmpty();
	}
	
	@Override
	public String toString() {
		String str = "[";
		for(T d: data)
			str = str + d +", ";
		str = str.substring(0, str.length()-2)+"]";
		return str;
		}
}

