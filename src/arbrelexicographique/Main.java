package arbrelexicographique;

public class Main {

	public static void main(String[] args) {
		ArbreLexicographique arbre = new ArbreLexicographique();
		
//		arbre.sauve("coucou.txt");
		
		arbre.charge("perenoel.txt");
		arbre.ajout("estuneordure");
		
		System.out.println(arbre.toString());
		arbre.sauve("papanoelnouveau.txt");

	}

}
