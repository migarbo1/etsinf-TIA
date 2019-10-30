;; carretera

(define (domain carretera_manager)

  (:requirements :durative-actions :typing :fluents)

  (:types tramo cuadrilla cisterna pavimentadora compactadora - object)

  (:predicates
    ;;localizacion
    (at ?x - (either cuadrilla cisterna pavimentadora compactadora) ?t - tramo)

    ;;estado del tramo
    (agrietado ?c1 - tramo) ;; si esta aqui es que necesita  compactado
    (compactado ?nnc - tramo)
    (pavimentado_ok ?po - tramo)
    (aplastado ?ta - tramo)
    (pintado ?s - tramo)
    (vallado ?t - tramo)
    (senalizado ?t - tramo)

    ;;utiles
    (conectado ?t1 - tramo ?t2 - tramo)
    (disponible ?d - (either cuadrilla cisterna pavimentadora compactadora tramo))
    )

  (:functions
     ;;trasporte
     (duracion_mover_maquinaria ?t1 - tramo ?t2 - tramo)
     (duracion_mover_cuadrilla ?t1 - tramo ?t2 - tramo)

     ;; duraciones de acciones
     (duracion_compactar)
     (duracion_pavimentar)
     (duracion_aplastar)
     (duracion_pintar)
     (duracion_vallas)
     (duracion_senyales)

     ;;coste monetario
     (coste_total)
     (coste_cis)
     (coste_com)
     (coste_pav)
     ;; mas
   )

   ;;acciones de mantenimiento
   (:durative-action compactar
    :parameters( ?t - tramo)
    :duration(= ?duration (duracion_compactar))
    :condition(
                and
                    (at start(disponible ?t))
                    (at start(agrietado ?t))

              )
    :effect(
            and
                (at start (not(disponible ?t)))
                (at end (disponible ?t))
                (at end(not(agrietado ?t)))
                (at end(compactado ?t))

           )
   )

   (:durative-action pavimentar
    :parameters(?t - tramo ?c - cisterna ?p - pavimentadora)
    :duration(= ?duration (duracion_pavimentar))
    :condition(
                and
                    (at start(compactado ?t))
                    (at start(disponible ?t))
                    (at start(disponible ?c))
                    (at start(disponible ?p))
                    (over all(at ?p ?t))
                    (over all(at ?c ?t))

              )
    :effect(
            and
                 (at start(not(disponible ?t)))
                 (at start(not(disponible ?c)))
                 (at start(not(disponible ?p)))

                 (at end(disponible ?t))
                 (at end(disponible ?c))
                 (at end(disponible ?p))
                 (at end(pavimentado_ok ?t))
                 (at end(increase (coste_total) (coste_pav)))
                 (at end(increase (coste_total) (coste_cis)))

           )
   )

   (:durative-action aplastar
    :parameters(?t - tramo ?c - compactadora)
    :duration(= ?duration (duracion_aplastar))
    :condition(
                and
                    (at start(pavimentado_ok ?t))
                    (at start(disponible ?t))
                    (at start(disponible ?c))
                    (over all(at ?c ?t))

              )
    :effect(
              and
                  (at start(not(disponible ?t)))
                  (at start(not(disponible ?c)))

                  (at end(aplastado ?t))
                  (at end(disponible ?t))
                  (at end(disponible ?c))
                  (at end(increase (coste_total) (coste_com)))

           )
   )

   ;;acciones Finales
   (:durative-action pintar
    :parameters(?c - cuadrilla ?t - tramo)
    :duration(= ?duration (duracion_pintar))
    :condition(
                and
                    (over all(at ?c ?t))
                    (at start(aplastado ?t))
                    (at start(disponible ?c))
                    (at start(disponible ?t))

              )
    :effect(
            and
                (at start(not(disponible ?t)))
                (at start(not(disponible ?c)))

                (at end(disponible ?t))
                (at end(disponible ?c))
                (at end(pintado ?t))

           )
   )

   (:durative-action vallar
    :parameters(?c - cuadrilla ?t - tramo)
    :duration(= ?duration (duracion_vallas))
    :condition(
                and
                    (at start(disponible ?t))
                    (at start(disponible ?c))
                    (at start(aplastado ?t))
                    (over all(at ?c ?t))

              )
    :effect(
            and
                (at start(not(disponible ?t)))
                (at start(not(disponible ?c)))

                (at end(vallado ?t))
                (at end(disponible ?t))
                (at end(disponible ?c))

           )
   )

   (:durative-action senalizar
    :parameters(?c - cuadrilla ?t - tramo)
    :duration(= ?duration (duracion_vallas))
    :condition(
                and
                    (at start(disponible ?t))
                    (at start(disponible ?c))
                    (at start(aplastado ?t))
                    (over all(at ?c ?t))

              )
    :effect(
            and
                (at start(not(disponible ?t)))
                (at start(not(disponible ?c)))

                (at end(disponible ?t))
                (at end(disponible ?c))
                (at end (senalizado ?t))

           )
   )

   ;;acciones complementarias
   (:durative-action transportar_maquinaria
    :parameters(?o - (either pavimentadora compactadora cisterna) ?t1 ?t2 - tramo)
    :duration(= ?duration (duracion_mover_maquinaria ?t1 ?t2))
    :condition(
                and
                    (over all(disponible ?t1))
                    (over all(disponible ?t2))
                    (at start(disponible ?o))
                    (at start(at ?o ?t1))
                    (at start(conectado ?t1 ?t2))

              )
    :effect(
            and
                (at start(not(disponible ?o)))
                (at start(not(at ?o ?t1)))
                (at end(disponible ?o))
                (at end(at ?o ?t2))

           )
   )

   (:durative-action transportar_cuadrilla
    :parameters(?o - cuadrilla ?t1 ?t2 - tramo)
    :duration(= ?duration (duracion_mover_cuadrilla ?t1 ?t2))
    :condition(
                and
                    (over all(disponible ?t1))
                    (over all(disponible ?t2))
                    (at start(disponible ?o))
                    (at start(at ?o ?t1))
                    (at start(conectado ?t1 ?t2))

              )
    :effect(
            and
                (at start(not(disponible ?o)))
                (at start(not(at ?o ?t1)))
                (at end(disponible ?o))
                (at end(at ?o ?t2))

           )
   )
)
