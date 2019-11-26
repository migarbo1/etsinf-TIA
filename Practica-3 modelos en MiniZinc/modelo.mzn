%Modelado de la superpasición de capas de una carretera
%vector de 18 elementos en los que cada indice corresponde a un tipo de capa(E1A..E9A) las 9 primeras y (E1B..E9B)las 9 ultimas
array [1..18] of var 1..18: capas;
include "alldifferent.mzn";

%----------------------------

%restricción a)
constraint abs(capas[2] - capas[1]) != 1;
constraint abs(capas[2] - capas[5]) != 1;
constraint abs(capas[2] - capas[9]) != 1;
constraint abs(capas[2] - capas[13]) != 1;

 %restricción b)
constraint  forall(i in 1..9 where i!=7) (abs(capas[7] - capas[i]) != 1);

%restricción c)
constraint abs(capas[4] - capas[13]) >= 5;

%restricción d)
constraint abs(capas[8] - capas[17]) = 2;

%restricción e) (en esta hay contradicción con la h)
constraint abs(capas[5] - capas[14]) = 1;

%restricción f)
constraint abs(capas[4] - capas[1]) = 1 \/ abs(capas[4] - capas[10]) = 1 \/ abs(capas[4] - capas[9]) = 1 \/ abs(capas[4] - capas[18]) = 1;

%restricción g)
constraint abs(capas[6] - capas[7]) != 1;

%restricción h) la ultima parte contradice a la restricción e)
constraint (abs(capas[5] - capas[13]) = 1 \/ abs(capas[5] - capas[17]) = 1 \/ abs(capas[5] - capas[2]) = 1 \/ abs(capas[5] - capas[3]) = 1 \/ abs(capas[5] - capas[7]) = 1) /\ abs(capas[6] - capas[14]) != 1;

%restricción i)
constraint forall(i,j in 1..9 where i > j) (capas[i] > capas[j]);

%restricción j)
constraint forall(i,j in 10..15 where i > j) (capas[i] < capas[j]);

%restricción de validez, todas las capas son diferentes
constraint alldifferent (i in 1..18) (capas[i]);

%----------------------------

solve satisfy;
%solve minimize (abs(capas[8] - capas[9]) + abs(capas[10] - capas[11]));
%solve minimize abs(capas[7] - capas[16]) / abs(capas[3] - capas[18]);

%----------------------------
output["E1A en capa : ", show(capas[1]), "\n",
       "E2A en capa : ", show(capas[2]), "\n",
       "E3A en capa : ", show(capas[3]), "\n",
       "E4A en capa : ", show(capas[4]), "\n",
       "E5A en capa : ", show(capas[5]), "\n",
       "E6A en capa : ", show(capas[6]), "\n",
       "E7A en capa : ", show(capas[7]), "\n",
       "E8A en capa : ", show(capas[8]), "\n",
       "E9A en capa : ", show(capas[9]), "\n",
       "E1B en capa : ", show(capas[10]), "\n",
       "E2B en capa : ", show(capas[11]), "\n",
       "E3B en capa : ", show(capas[12]), "\n",
       "E4B en capa : ", show(capas[13]), "\n",
       "E5B en capa : ", show(capas[14]), "\n",
       "E6B en capa : ", show(capas[15]), "\n",
       "E7B en capa : ", show(capas[16]), "\n",
       "E8B en capa : ", show(capas[17]), "\n",
       "E9B en capa : ", show(capas[18]), "\n"];
