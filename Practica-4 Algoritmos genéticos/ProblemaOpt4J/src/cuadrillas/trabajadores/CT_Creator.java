package cuadrillas.trabajadores;

//zona de imports
import java.util.Random;
import org.opt4j.core.genotype.SelectGenotype;
import org.opt4j.core.problem.Creator;
//fin zona imports

public class CT_Creator implements Creator<SelectGenotype<turns>>
{
	public SelectGenotype<turns> create(){
		turns[] t = {turns.T1,turns.T2, turns.T3};
		SelectGenotype<turns> genotype = new SelectGenotype<turns>(t);
		genotype.init(new Random(), Datos.NUM_CUADRILLAS);
		return genotype;
	}
}