package EJ8;

public class Ej8 {

	public static void main(String[] args) {
		Queue<Integer> queue = new Queue<Integer>();
		DoubleEndedQueue<Integer> dequeue = new DoubleEndedQueue<Integer>();
		int i;
		
		System.out.println("QUEUE");
		System.out.println("queue.isEmpty() = "+queue.isEmpty());
		for (i=1;i<=5;i++) {
			queue.enqueue(i);
		}
		System.out.println(queue.toString());
		System.out.println("dequeue = "+queue.dequeue());
		System.out.println("queue.head() = "+queue.head());
		System.out.println("queue.size() = "+queue.size());
		System.out.println(queue.toString());
		
		System.out.println("DEQUEUE");
		dequeue.enqueue(3);
		dequeue.enqueueFirst(2);
		dequeue.enqueueFirst(1);
		System.out.println(dequeue.toString());
		System.out.println("dequeue.dequeueLast() = "+dequeue.dequeueLast());
		System.out.println(dequeue.toString());

	}

}
