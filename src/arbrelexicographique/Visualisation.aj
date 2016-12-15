package arbrelexicographique;

import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.*;

import arbrelexicographique.v3.ArbreLexicographiqueException;

public aspect Visualisation {
	declare parents: ArbreLexicographique implements TreeModel;
	declare parents: NoeudAbstrait implements TreeNode;

	public DefaultTreeModel ArbreLexicographique.defaultTreeModel;
	private DefaultMutableTreeNode NoeudAbstrait.defaultMutableTreeNode;
	private JTree ArbreLexicographique.vue;
	
	/*
	 *  Permet de modifier la valeur de l'attribut vue (peut être appelé depuis l'appli graphique)
	 *  Correspond à la "connexion" entre le Jtree de la GUI et le JTree de l'arbre lexicographique (appelé vue) 
	 */	
	public void ArbreLexicographique.setVue(JTree jt){
		System.out.println("Set vue");
		this.vue = jt;
	}
	
	
	/*
	 * ---------------------------- Pommes Cuts -------------------------------------------
	 */
	
	/* 
	 * Create new Tree model when a new ArbreLexicographique is instantiated 
	 */
	pointcut newAL(ArbreLexicographique arbre) : target(arbre) && execution(ArbreLexicographique.new());
	after(ArbreLexicographique arbre): newAL(arbre){
		System.out.println("Pointcut instanciation Arbre");
		arbre.defaultTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode("Arbre Lexicographique"));
	}
	
	/*
	 * Creating a new marque -> create new TreeNode (empty), a marque has no frere 
	 */
	pointcut newMarque(Marque m) : target(m) && execution(Marque.new(NoeudAbstrait));
	after(Marque m): newMarque(m){
		System.out.println("pointcut new marque");
		m.defaultMutableTreeNode = new DefaultMutableTreeNode("Marque");
	}
	
	/*
	 * Creating a new node -> create new TreeNode with a frere, a fils and a char
	 */
	pointcut newNoeud(Noeud n, NoeudAbstrait frere, NoeudAbstrait fils, char c) : target(n) && args(frere,fils,c) && execution(Noeud.new(NoeudAbstrait, NoeudAbstrait, char));
	after(Noeud n, NoeudAbstrait frere, NoeudAbstrait fils, char c): newNoeud(n, frere, fils, c){
		System.out.println("pointcut new noeud : "+c);
		n.defaultMutableTreeNode = new DefaultMutableTreeNode(Character.toString(c));
		n.defaultMutableTreeNode.add(fils.defaultMutableTreeNode);
	}

	/*
	 * Chaque fois que la racine de l'arbre est changée
	 */
	pointcut rootAL(ArbreLexicographique arbre) : this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);
	
	
	/*
	 * Chaque fois que la racine est changé lors de l'ajout
	 */
	pointcut updateRacineAjout(ArbreLexicographique arbre) : target(arbre) && rootAL(ArbreLexicographique) && withincode(boolean ArbreLexicographique.ajout(String));
	after(ArbreLexicographique arbre) : updateRacineAjout(arbre){
		System.out.println("pointcut update racine");
		if(arbre.entree.defaultMutableTreeNode != null){
			((DefaultMutableTreeNode) arbre.defaultTreeModel.getRoot()).insert(arbre.entree.defaultMutableTreeNode, 0);
			((DefaultTreeModel)arbre.defaultTreeModel).reload();
		}
	}
	
	/*
	 * Chaque fois qu'un fils ou un frere est changé
	 */
	pointcut updateFrere(NoeudAbstrait n) : target(n) && set(NoeudAbstrait NoeudAbstrait.frere);
	pointcut updateFils(Noeud n, NoeudAbstrait f) : this(n) && target(f) && set(NoeudAbstrait Noeud.fils);
	
	
	/*
	 * Chaque fois qu'un frere change lors de l'ajout
	 */
	pointcut updateFrereAjout(NoeudAbstrait n) : target(n) && updateFrere(NoeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String));
	after(NoeudAbstrait n) : updateFrereAjout(n){
		System.out.println("pointcut update frere");
		if(n.getParent() != null) ((MutableTreeNode) n.defaultMutableTreeNode.getParent()).insert(n.frere.defaultMutableTreeNode,0);
	}
	
	/*
	 * Chaque fois qu'un fils change lors de l'ajout
	 */
	pointcut updateFilsAjout(Noeud n) : target(n) &&  updateFils(Noeud, NoeudAbstrait) && withincode(NoeudAbstrait NoeudAbstrait.ajout(String));
	after(Noeud n) : updateFilsAjout(n){
		System.out.println("pointcut update fils");
		n.defaultMutableTreeNode.add(n.fils.defaultMutableTreeNode);
	}
	
	/*
	 * -------------------------  TreeModel Methods -------------------------------
	 * 
	 * 
	 */
	public Object ArbreLexicographique.getRoot() {	
		
		return this.defaultTreeModel.getRoot();
	}

	public Object ArbreLexicographique.getChild(Object parent, int index) {	
		return this.defaultTreeModel.getChild(parent, index);
	}

	public int ArbreLexicographique.getChildCount(Object parent) {
		return this.defaultTreeModel.getChildCount(parent);
	}

	public boolean ArbreLexicographique.isLeaf(Object node) {
		return this.defaultTreeModel.isLeaf(node);
	}

	public void ArbreLexicographique.valueForPathChanged(TreePath path, Object newValue) {
		this.defaultTreeModel.valueForPathChanged(path, newValue);
	}

	public int ArbreLexicographique.getIndexOfChild(Object parent, Object child) {
		return this.defaultTreeModel.getIndexOfChild(parent, child);
	}

	public void ArbreLexicographique.addTreeModelListener(TreeModelListener l) {
		this.defaultTreeModel.addTreeModelListener(l);
	}

	public void ArbreLexicographique.removeTreeModelListener(TreeModelListener l) {
		this.defaultTreeModel.removeTreeModelListener(l);
	}
	
	/* 
	 * ----------------------------- TreeNode Methods -----------------------------------------
	 */	
	public TreeNode NoeudAbstrait.getChildAt(int childIndex) {
		return this.defaultMutableTreeNode.getChildAt(childIndex);
	}

	public int NoeudAbstrait.getChildCount() {
		return this.defaultMutableTreeNode.getChildCount();
	}

	public TreeNode NoeudAbstrait.getParent() {
		return this.defaultMutableTreeNode.getParent();
	}

	public int NoeudAbstrait.getIndex(TreeNode node) {
		return this.defaultMutableTreeNode.getIndex(node);
	}
	
	public boolean NoeudAbstrait.getAllowsChildren() {
		return this.defaultMutableTreeNode.getAllowsChildren();
	}
	
	public boolean NoeudAbstrait.isLeaf() {
		return this.defaultMutableTreeNode.isLeaf();
	}
	
	public Enumeration NoeudAbstrait.children() {
		return this.defaultMutableTreeNode.children();
	}
}
