package cuadrillas.trabajadores;

import org.opt4j.core.problem.ProblemModule;

public class CT_Module extends ProblemModule{
	protected void config() {
		bindProblem(CT_Creator.class,CT_Decoder.class, CT_Evaluator.class);
	}
}