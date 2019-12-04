package cuadrillas.trabajadores;

import java.util.ArrayList;

import org.opt4j.core.Objective.Sign;
import org.opt4j.core.Objectives;
import org.opt4j.core.problem.Evaluator;

public class CT_Evaluator implements Evaluator<ArrayList<turns>>{
	
	public Objectives evaluate (ArrayList<turns> phenotype) {
		int cost = 0, prod = 0;
		int t1 = 0,t2 = 0,t3 = 0;
		for(int i = 0; i < phenotype.size(); i++) {
			switch (phenotype.get(i)){
			case T1: 
				cost += Datos.matrizCostes[0][i];
				prod += Datos.matrizProductividad[0][i];	
				t1++; break;
			case T2: 
				cost += Datos.matrizCostes[1][i];
				prod += Datos.matrizProductividad[1][i];	
				t2++; break;
			case T3: 
				cost += Datos.matrizCostes[2][i];
				prod += Datos.matrizProductividad[2][i];	
				t3++; break;
			}
		}
		if(t1 < 3 | t2 < 3 | t3 < 3) {
			cost = 99999;
			prod = -99999;
		}
		Objectives objectives = new Objectives();
		objectives.add("Valor coste-MIN",Sign.MIN,cost);
		objectives.add("Valor productividad-MAX", Sign.MAX, prod);
		return objectives;
	}
}