package arbrelexicographique.gui;

import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JButton;
import java.awt.BorderLayout;
import javax.swing.SwingConstants;
import javax.swing.JTree;
import javax.swing.JTextField;
import javax.swing.JMenuBar;
import javax.swing.JLabel;
import javax.swing.JMenuItem;
import javax.swing.JMenu;

public class gui {

	private JFrame frame;
	private JTextField textField;
	private JTree tree;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
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
		
		JButton ajoutButton = new JButton("Ajouter");
		ajoutButton.setHorizontalAlignment(SwingConstants.LEFT);
		menuBar.add(ajoutButton);
		
		JButton supprButton = new JButton("Supprimer");
		menuBar.add(supprButton);
		
		JButton prefixeButton = new JButton("Prefixe");
		menuBar.add(prefixeButton);
		
		JButton contientButton = new JButton("Contient");
		menuBar.add(contientButton);
		
		JLabel lblMot = new JLabel("Mot ?");
		menuBar.add(lblMot);
		
		textField = new JTextField();
		menuBar.add(textField);
		textField.setColumns(10);
		frame.getContentPane().add(menuBar, BorderLayout.NORTH);
		
		tree = new JTree();
		
		frame.getContentPane().add(tree, BorderLayout.CENTER);
		
		JLabel lblinfo = new JLabel("info");
		frame.getContentPane().add(lblinfo, BorderLayout.SOUTH);
		
		JMenuBar menuBar_1 = new JMenuBar();
		frame.setJMenuBar(menuBar_1);
		
		JMenu mnfichier = new JMenu("fichier");
		menuBar_1.add(mnfichier);
		
		JMenuItem mntmNewMenuItem = new JMenuItem("Nouveau");
		mnfichier.add(mntmNewMenuItem);
		
		JMenuItem mntmNewMenuItem_2 = new JMenuItem("Enregistrer");
		mnfichier.add(mntmNewMenuItem_2);
		
		JMenu mnNewMenu = new JMenu("aide");
		menuBar_1.add(mnNewMenu);
		
		JMenuItem mntmNewMenuItem_1 = new JMenuItem("google it ? ");
		mnNewMenu.add(mntmNewMenuItem_1);
		
		JMenuItem mntmNewMenuItem_3 = new JMenuItem("call your mum ");
		mnNewMenu.add(mntmNewMenuItem_3);
	}
}
