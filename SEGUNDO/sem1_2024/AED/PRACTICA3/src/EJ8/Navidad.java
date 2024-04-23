package EJ8;

import EJ3.GeneralTree;

public class Navidad {
	private GeneralTree<Integer> tree;
	
	public void setTree(GeneralTree<Integer> tree) {
		this.tree = tree;
	}
	
	public boolean esAbetoNavidenio() {
		boolean abeto = true;
		if (!this.tree.isEmpty()) {
			if ((this.tree.hasChildren()) && (this.tree.getChildren().size()!=3)) {
				abeto = false;
			} else {
				for (GeneralTree<Integer> child:this.tree.getChildren()) {
					Navidad navidad = new Navidad();
					navidad.setTree(child);
					abeto = navidad.esAbetoNavidenio();
					if (!abeto) {
						break;
					}
				}
			}
		}
		return abeto;
	}
}
