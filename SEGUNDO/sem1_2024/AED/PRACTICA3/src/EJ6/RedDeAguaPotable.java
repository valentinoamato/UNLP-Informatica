package EJ6;

import EJ3.GeneralTree;

public class RedDeAguaPotable {
	private GeneralTree<Integer> tree;
	
	
	
	public RedDeAguaPotable(GeneralTree<Integer> tree) {
		this.tree = tree;
	}

	private int minimo(int min) {
		if (!this.tree.isEmpty()) {
			if (this.tree.getData()<min) {
				min = this.tree.getData();
			} else {
				for (GeneralTree<Integer> child:this.tree.getChildren()) {
					RedDeAguaPotable redDeAguaPotable = new RedDeAguaPotable(child);
					int response = redDeAguaPotable.minimo(min);
					if (response<min) {
						min = response;
					}
				}
			}
		}
		return min;
	}

	public int minimo() {
		return minimo(this.tree.getData());
	}
	
}
