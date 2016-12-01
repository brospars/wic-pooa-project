package arbrelexicographique;

public aspect SingletonSurNoeudVide {
	private NoeudVide instance = new NoeudVide();

	//pointcut
	private pointcut appelConstructeur() : call(NoeudVide.new()) && ! within(SingletonSurNoeudVide);
	
	//advice qui renvoit sur le noeud de l'instance de cette classe (SingletonSurNoeudVide)
	NoeudVide around() : appelConstructeur() {
		return instance;
	}
}
