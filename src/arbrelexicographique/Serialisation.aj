package arbrelexicographique;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.io.Serializable;

public aspect Serialisation {
	
	declare parents: ArbreLexicographique implements Serializable;		

	public void  ArbreLexicographique.sauve(String nomFichier){
		
		try (PrintWriter out = new PrintWriter(nomFichier)){
			out.println(this.toString());
		} catch (Exception e ){
			System.out.print(e);
		}
	}
	
	public void ArbreLexicographique.charge(String nomFichier){
		
		File file = new File(nomFichier);
		if(file.exists()) {
			try (BufferedReader br = new BufferedReader(new FileReader(file))) {
			    String line;
			    while ((line = br.readLine()) != null) {
			       this.ajout(line);
			    }
			}catch (Exception e ){
				System.out.print(e);
			}
		}
		else {
			System.out.println("Ho Ho Ho ! The file doesn't exist ! (Santa Clause)");
		}
	}
}
