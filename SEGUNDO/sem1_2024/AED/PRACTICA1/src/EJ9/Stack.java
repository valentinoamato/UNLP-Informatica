package EJ9;

public class Stack<E> {
	private int stackPointer;
	private int size;
	private E[] data;
	
	@SuppressWarnings("unchecked")
	public Stack(int size) {
		this.size = size;
		this.stackPointer = -1;
		this.data = (E[]) new Object[size];
	}
	
	public void push(E element) {
		stackPointer++;
		data[stackPointer] = element;
	}
	
	public E pop() {
		stackPointer--;
		return data[stackPointer+1];
	}
	
	public boolean isFull() {
		return size == (stackPointer+1);
	}
	
	public boolean isEmpty() {
		return stackPointer == -1;
	}
	
	@Override
	public String toString() {
		int i;
		String string = ("[");
		if (isEmpty()) {
			string += "]";
		} else {
			for (i=0;i<stackPointer;i++) {
				string += (data[i]+", ");
			}
			string += (data[stackPointer]+"]");
		}
		return string;
	}
}
