package cuadrillas.trabajadores;

//zona de imports
import java.util.*;
import org.opt4j.core.genotype.SelectGenotype;
import org.opt4j.core.problem.Decoder;
//fin zona de impots

public class CT_Decoder implements Decoder<SelectGenotype<turns>,ArrayList<turns>>
{
	public ArrayList<turns> decode (SelectGenotype<turns> genotype){
		ArrayList<turns> phenotype = new ArrayList<turns>();
		
		for (int i = 0; i < genotype.size(); i++) {
			phenotype.add(genotype.getValue(i));
		}
		return phenotype;
	}
}