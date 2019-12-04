package cuadrillas.trabajadores;

public class Datos 
{	
	public static final int NUM_CUADRILLAS	= 10;
	public static final int NUM_TURNOS		= 3;
	
	// matriz de coste de las 10 cuadrillas para cada uno de los 3 turnos
	public static final int[][] matrizCostes =
		{
				{1000,	1100,	1500,	2500,	3200,	2500,	2100,	2100,	1450,	2200},	// turno1
				{1400,	2100,	1900,	2400,	2050,	2000,	1850,	3050,	1600,	1500},	// turno2
				{2100,	3100,	2050,	2100,	2100,	1400,	1900,	2050,	2150,	1900}	// turno3	
		};	
	
	// matriz de productividad de las 10 cuadrillas para cada uno de los 3 turnos
	public static final int[][] matrizProductividad =
		{
				{50,	42,	42,	40,	50,	50,	40,	52,	50,	44},  // turno1
				{52,	50,	53,	40,	30,	50,	40,	50,	45,	50},  // turno2
				{45,	30,	35,	25,	50,	30,	30,	42,	35,	45}   // turno3
		};	
}