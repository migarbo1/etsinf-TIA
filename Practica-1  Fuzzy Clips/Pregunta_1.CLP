;;funcion fuzzify

(deffunction fuzzify (?fztemplate ?value ?delta)

        (bind ?low (get-u-from ?fztemplate))
        (bind ?hi  (get-u-to   ?fztemplate))

        (if (<= ?value ?low)
          then
            (assert-string
              (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
          else
            (if (>= ?value ?hi)
              then
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0))"
                               ?fztemplate (- ?hi ?delta) ?hi))
              else
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
                               ?fztemplate (max ?low (- ?value ?delta))
                               ?value (min ?hi (+ ?value ?delta)) ))
            )
        )
  )

;;definici�n de templates

(deftemplate carretera
	(slot identificador (type SYMBOL))
	(slot nivel_agrietamiento(type INTEGER))
	(slot tmax(type FLOAT))
	(slot tmin(type FLOAT))
	(slot d_trafico(type INTEGER))
	(slot prioridad(type FLOAT))

)

(deftemplate densidad_trafico
	0 300 coches
	(
	(baja(Z 20 80))
	(alta(S 120 250))
	)
)

(deftemplate temperatura
	-10 90 C
	(
		(fria(5 1)(10 0))
		(moderada(-5 0)(15 1)(40 1)(50 0))
		(calida(35 0)(45 1))
	)
)

(deftemplate agrietamiento
	0 100 %
	(
		(ligero (10 1)(20 0))
		(medio (5 0) (25 1)(45 1)(55 0))
		(fuerte(50 0)(60 1))
	)
)


(deftemplate necesidad_reasfaltado
	0 100 prob
	(
		(baja(Z 10 25))
		(media(PI 15 60))
		(urgente(S 55 90))
	)
)

;leemos nivel, fusificamos sober agrietamietno. leemos temperatura max i min y fusificamos(fuzzify) sobre temperatura
;con anchura 0.1

;9 reglas

;reglas
(defrule readFromConsole (declare (salience 10))

	=>
		(printout T "introduzca el identificador de la carretera " crlf)
		(bind ?Rid (read))
		(printout T "introduzca el nivel de agrietamiento con un entero en el rango 0 - 100 " crlf)
		(bind ?Rlvl (read))
		(printout T "introduzca la temperatura maxima registrada en 30 dias " crlf)
		(bind ?Tmax (read))
		(printout T "introduzca la temperatura minima registrada en 30 dias " crlf)
		(bind ?Tmin (read))
		(printout T "introduzca la densidad de tr�fico de la carretera " crlf)
		(bind ?Dtraf (read))
		;
		;
		(fuzzify agrietamiento ?Rlvl 0.1) ;assertlvl agrietamiento
		(fuzzify temperatura ?Tmax 0.1) ;assert temp
		(fuzzify temperatura ?Tmin 0.1) ;
		(fuzzify densidad_trafico ?Dtraf 0.1)

    (assert (carretera (identificador ?Rid) (nivel_agrietamiento ?Rlvl) (tmax ?Tmax) (tmin ?Tmin) (d_trafico ?Dtraf) (prioridad 0.0)))
)
(defrule fria_ligero
	(temperatura fria)
	(agrietamiento ligero)
	=>
	(assert (necesidad_reasfaltado media))
)

(defrule fria_medio
	(temperatura fria)
	(agrietamiento medio)
	=>
	(assert (necesidad_reasfaltado urgente))
)

(defrule fria_fuerte
	(temperatura fria)
	(agrietamiento fuerte)
	=>
	(assert (necesidad_reasfaltado extremely urgente))
)

(defrule moderada_ligero
	(temperatura moderada)
	(agrietamiento ligero)
	=>
	(assert (necesidad_reasfaltado very baja))
)

(defrule moderada_medio
	(temperatura moderada)
	(agrietamiento medio)
	=>
	(assert (necesidad_reasfaltado baja))
)

(defrule moderada_fuerte
	(temperatura moderada)
	(agrietamiento fuerte)
	=>
	(assert (necesidad_reasfaltado somewhat media))
)

(defrule calida_ligero
	(temperatura calida)
	(agrietamiento ligero)
	=>
	(assert (necesidad_reasfaltado media))
)

(defrule calida_medio
	(temperatura calida)
	(agrietamiento medio)
	=>
	(assert (necesidad_reasfaltado very urgente))
)

(defrule calida_fuerte
	(temperatura calida)
	(agrietamiento fuerte)
	=>
	(assert (necesidad_reasfaltado extremely urgente))
)

(defrule dens_alta
	(densidad_trafico alta)
	=>
	(assert (necesidad_reasfaltado very urgente))
)

(defrule dens_baja
	(densidad_trafico baja)
	=>
	(assert (necesidad_reasfaltado more-or-less baja))
)


(defrule defuzzify (declare (salience -1)) (necesidad_reasfaltado ?nec)
?c <- (carretera (identificador ?Rid) (nivel_agrietamiento ?Rlvl) (tmax ?Tmax) (tmin ?Tmin) (d_trafico ?Dtraf) (prioridad ?p))
=>
(bind ?p (moment-defuzzify ?nec))
(modify ?c (prioridad ?p))
(printout T "Necesidad de reasfaltado: " ?p crlf) ;;maximum-defuzzify
(halt)
)
