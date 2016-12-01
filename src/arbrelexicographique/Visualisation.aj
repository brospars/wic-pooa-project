package arbrelexicographique;

import java.util.Enumeration;

import javax.swing.JTree;
import javax.swing.event.TreeModelListener;
import javax.swing.tree.*;

import arbrelexicographique.v3.ArbreLexicographiqueException;

public aspect Visualisation {
	declare parents: ArbreLexicographique implements TreeModel;
	declare parents: NoeudAbstrait implements TreeNode;

	private DefaultTreeModel ArbreLexicographique.defaultTreeModel;
	private DefaultMutableTreeNode NoeudAbstrait.defaultMutableTreeNode;
	private JTree ArbreLexicographique.vue;
	
	/*
	 *  Permet de modifier la valeur de l'attribut vue (peut être appelé depuis l'appli graphique)
	 *  Correspond à la "connexion" entre le Jtree de la GUI et le JTree de l'arbre lexicographique (appelé vue) 
	 */	
	public void ArbreLexicographique.setVue(JTree jt){
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
		arbre.defaultTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode());
	}
	
	/*
	 * Creating a new marque -> create new TreeNode (empty), a marque has no frere 
	 */
	pointcut newMarque(Marque m) : target(n) && execution(Marque.new(NoeudAbstrait));
	after(Marque m): newMarque(m){
		m.defaultMutableTreeNode = new DefaultMutableTreeNode();
	}
	
	/*
	 * Creating a new node -> create new TreeNode with a frere, a fils and a char
	 */
	pointcut newNoeud(Noeud n, NoeudAbstrait frere, NoeudAbstrait fils, char c) : target(n) && execution(NoeudAbstrait.new());
	after(Noeud n, NoeudAbstrait frere, NoeudAbstrait fils, char c): newNoeud(n, frere, fils, c){
		n.defaultMutableTreeNode = new DefaultMutableTreeNode(Character.toString(c));
	}

	/*
	 * Put the root entrie to the TreeNode (related to ArbreLexicographique.estVide()
	 */
	pointcut rootAL(ArbreLexicographique arbre) : this(arbre) && set(NoeudAbstrait ArbreLexicographique.entree);
	
	/*
	 * Update tree model adding nodes when a string is "ajout" (added) 
	 */
	pointcut ajoutStringAL(ArbreLexicographique arbre) : target(arbre) && execution(Boolean ArbreLexicographique.ajout(String));
	after(ArbreLexicographique arbre): ajoutStringAL(arbre){
		((DefaultMutableTreeNode)arbre.defaultMutableTreeNode.)
		((DefaultMutableTreeNode) n.model.getRoot()).insert(n.entree.treeNode, 0);
		((DefaultTreeModel)arbre.defaultTreeModel).reload();
	}
	
	/*
	 * Suppr tree model adding nodes when a string is "ajout" (added) 
	 */
	pointcut supprStringAL(ArbreLexicographique arbre) : target(arbre) && execution(Boolean ArbreLexicographique.suppr(String));
	after(ArbreLexicographique arbre): supprStringAL(arbre){
		
	}
	
	public boolean ajout(String s) {
		try {
			entree = entree.ajout(s);
		} catch (ArbreLexicographiqueException ale) {
			return false;
		}
		return true;
	}

	public boolean suppr(String s) {
		try {
			entree = entree.suppr(s);
		} catch (ArbreLexicographiqueException ale) {
			return false;
		}
		return true;
	}

	public boolean estVide() {
		return entree instanceof NoeudVide;
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
