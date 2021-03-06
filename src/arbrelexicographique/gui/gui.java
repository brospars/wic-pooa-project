package arbrelexicographique.gui;

import java.awt.EventQueue;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFileChooser;

import java.awt.BorderLayout;
import javax.swing.SwingConstants;
import javax.swing.Timer;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.tree.DefaultTreeModel;

import arbrelexicographique.ArbreLexicographique;

import javax.swing.JTree;
import javax.swing.JTextField;
import javax.swing.JMenuBar;
import javax.swing.JLabel;
import javax.swing.JMenuItem;
import javax.swing.JMenu;
import javax.swing.JTabbedPane;
import javax.swing.JTextPane;
import javax.swing.JScrollBar;
import javax.swing.JScrollPane;

public class gui {

	private JFrame frame;
	private JTextField textField;
	private JTree tree;
	private JLabel lblinfo;
	static private ArbreLexicographique arbre;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		
		arbre = new ArbreLexicographique();
		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					gui window = new gui();
					window.frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}

	/**
	 * Create the application.
	 */
	public gui() {
		initialize();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initialize() {
		frame = new JFrame();
		frame.setBounds(100, 100, 647, 474);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.getContentPane().setLayout(new BorderLayout(0, 0));
		
		JMenuBar menuBar = new JMenuBar();
		
		JLabel lblMot = new JLabel("Mot ?");
		menuBar.add(lblMot);
		
		textField = new JTextField();
		menuBar.add(textField);
		textField.setColumns(10);
		
		JButton ajoutButton = new JButton("Ajouter");
		ajoutButton.setHorizontalAlignment(SwingConstants.LEFT);
		menuBar.add(ajoutButton);
		
		JButton supprButton = new JButton("Supprimer");
		menuBar.add(supprButton);
		
		JButton prefixeButton = new JButton("Prefixe");
		menuBar.add(prefixeButton);
		
		JButton contientButton = new JButton("Contient");
		menuBar.add(contientButton);
		
		
		frame.getContentPane().add(menuBar, BorderLayout.NORTH);		
		
		JTabbedPane tabbedPane = new JTabbedPane(JTabbedPane.TOP);
		frame.getContentPane().add(tabbedPane, BorderLayout.CENTER);
		
		

		JTextPane listVue = new JTextPane();
		listVue.setEditable(false);
		JScrollPane scrollPane = new JScrollPane(listVue);
		tabbedPane.addTab("List", null, scrollPane, null);
		
		tree = new JTree(arbre.defaultTreeModel);
		arbre.setVue(tree);
		
		JScrollPane scrollPane2 = new JScrollPane(tree);
		
		tabbedPane.addTab("Tree", null, scrollPane2, null);
		
		lblinfo = new JLabel("info");
		frame.getContentPane().add(lblinfo, BorderLayout.SOUTH);
		
		JMenuBar menuBar_1 = new JMenuBar();
		frame.setJMenuBar(menuBar_1);
		
		JMenu mnfichier = new JMenu("fichier");
		menuBar_1.add(mnfichier);
		
		JMenuItem menuNouveau = new JMenuItem("Nouveau");
		mnfichier.add(menuNouveau);
		
		JMenuItem menuCharger = new JMenuItem("Charger");
		mnfichier.add(menuCharger);
		
		JMenuItem menuEnregistrer = new JMenuItem("Enregistrer");
		mnfichier.add(menuEnregistrer);
		
		JMenu mnNewMenu = new JMenu("aide");
		menuBar_1.add(mnNewMenu);
		
		JMenuItem mntmNewMenuItem_1 = new JMenuItem("google it ? ");
		mnNewMenu.add(mntmNewMenuItem_1);
		
		JMenuItem menuTest = new JMenuItem("Test automatique");
		mnNewMenu.add(menuTest);
		
		lblinfo.setText("L'arbre contient "+arbre.nbMots()+" mots");
		
		tabbedPane.addChangeListener(new ChangeListener() {
	        public void stateChanged(ChangeEvent e) {
	        	listVue.setText(arbre.toString());
	        }
	    });

		/*
		* Create a new tree
		* Not working properly → only works with the list view
		*/
		menuNouveau.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
		    arbre = new ArbreLexicographique();
		    listVue.setText(arbre.toString());
		    lblinfo.setText("L'arbre contient "+arbre.nbMots()+" mots");
		  }
		});
		
		/*
		* Save the tree in a file
		*/
		menuEnregistrer.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			  System.out.println("sauvegarder");
			  JFileChooser choix = new JFileChooser();
			  int retour=choix.showOpenDialog(frame);
			  if(retour==JFileChooser.APPROVE_OPTION){
				 String filepath = choix.getSelectedFile().getAbsolutePath();
			     arbre.sauve(filepath);
			  }else{
				  
			  }
		  }
		});


		/*
		* Load a file and add it to the current tree
		*/
		menuCharger.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			  System.out.println("charger");
			  JFileChooser choix = new JFileChooser();
			  int retour=choix.showOpenDialog(frame);
			  if(retour==JFileChooser.APPROVE_OPTION){
			     String filepath = choix.getSelectedFile().getAbsolutePath();
			     arbre.charge(filepath);
			     listVue.setText(arbre.toString());
			     lblinfo.setText("L'arbre contient "+arbre.nbMots()+" mots");
			  }else{
				  
			  }
		  }
		});
		
		/*
		* Add some testing words
		*/
		menuTest.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			 arbre.ajout("ab");
			 arbre.ajout("abc");
			 arbre.ajout("bca");
			 arbre.ajout("a");
			 arbre.ajout("bac");
			 arbre.ajout("b");
		  }
		});

		/*
		* Display in the bottom label if the tree containe the word
		*/
		contientButton.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			  if(arbre.contient(textField.getText())){
		    	setInfo("OUI l'arbre contient le mot : "+textField.getText());
			  }else{
				setInfo("NON l'arbre ne contient pas le mot : "+textField.getText());
			  }
		  }
		});
		
		/*
		* Add the word to the tree and tells you if the add was succesful
		*/
		ajoutButton.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			  if(arbre.ajout(textField.getText())){
				  setInfo("Ajout réussi");
				  listVue.setText(arbre.toString());
			  }else{
				  setInfo("Ajout impossible");
			  }
		  }
		});
		
		/*
		* Display in the bottom label if the word is prefix of another word in the tree
		*/
		prefixeButton.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			  if(arbre.prefixe(textField.getText())){
		    	setInfo("OUI le mot "+textField.getText()+" est préfixe d'un mot");
			  }else{
				setInfo("NON le mot "+textField.getText()+" n'est préfixe pas d'un mot");
			  }
		  }
		});
		
		/*
		* Delete the word in the tree and tells you if the delete was succesful
		*/
		supprButton.addActionListener(new ActionListener(){
		  public void actionPerformed(ActionEvent e){
		    if(arbre.suppr(textField.getText())){
		    	setInfo("Suppression réussi");
			    listVue.setText(arbre.toString());
		    }else{
		    	setInfo("Suppression impossible");
		    }
		  }
		});
	}
	
	/*
	* Set an Info in the bottom label for 3 seconds and then redisplay the number of words
	*/
	public void setInfo(String info){
		lblinfo.setText(info+" | L'arbre contient "+arbre.nbMots()+" mots");
		Timer timer = new Timer(3000,new ActionListener(){
		  public void actionPerformed(ActionEvent e){
			 lblinfo.setText("L'arbre contient "+arbre.nbMots()+" mots");
		  }
		});
		timer.start();
	}
}
