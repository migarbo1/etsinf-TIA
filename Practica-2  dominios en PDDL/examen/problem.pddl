(define (problem problema)
(:domain carretera_manager)
(:objects
    cuadrilla1 - cuadrilla
    cuadrilla2 - cuadrilla
    cuadrilla3 - cuadrilla
    cuadrilla4 - cuadrilla
    cisterna1 - cisterna
    cisterna2 - cisterna
    pavimentadora1 - pavimentadora
    pavimentadora2 - pavimentadora
    compactadora1 - compactadora
    tramo1 - tramo
    tramo2 - tramo
    tramo3 - tramo
    tramo4 - tramo
    tramo5 - tramo
    tramo6 - tramo ;; Pregunta 2 ;;
    )

(:init
    (at cuadrilla1 tramo1)
    (at cuadrilla2 tramo1)
    (at cuadrilla3 tramo5)
    (at cuadrilla4 tramo5)
    (at cisterna1 tramo1)
    (at cisterna2 tramo1)
    (at pavimentadora1 tramo2)
    (at pavimentadora2 tramo2)
    (at compactadora1 tramo5)

    (agrietado tramo1)
    (agrietado tramo2)

    (compactado tramo3)
    (compactado tramo4)
    (compactado tramo5)
    (compactado tramo6) ;; Pregunta 2 ;;


    (senalizado tramo1)
    (senalizado tramo1)

    (disponible cuadrilla1)
    (disponible cuadrilla2)
    (disponible cuadrilla3)
    (disponible cuadrilla4)
    (disponible tramo1)
    (disponible tramo2)
    (disponible tramo3)
    (disponible tramo4)
    (disponible tramo5)
    (disponible tramo6) ;; Pregunta 2 ;;
    (disponible cisterna1)
    (disponible cisterna2)
    (disponible pavimentadora1)
    (disponible pavimentadora2)
    (disponible compactadora1)

    (conectado tramo1 tramo2)
    (conectado tramo2 tramo1)

    (conectado tramo2 tramo3)
    (conectado tramo3 tramo2)

    (conectado tramo3 tramo5)
    (conectado tramo5 tramo3)

    (conectado tramo2 tramo4)
    (conectado tramo4 tramo2)

    (conectado tramo4 tramo5)
    (conectado tramo5 tramo4)

    (conectado tramo3 tramo6) ;;pregunta 2 ;;
    (conectado tramo6 tramo3) ;;pregunta 2 ;;

    (conectado tramo5 tramo6) ;;pregunta 2 ;;
    (conectado tramo6 tramo5) ;;pregunta 2 ;;

    (= (duracion_mover_maquinaria tramo1 tramo2) 10)
    (= (duracion_mover_maquinaria tramo2 tramo1) 10)
    (= (duracion_mover_maquinaria tramo2 tramo3) 12)
    (= (duracion_mover_maquinaria tramo3 tramo2) 12)
    (= (duracion_mover_maquinaria tramo2 tramo4) 8)
    (= (duracion_mover_maquinaria tramo4 tramo2) 8)
    (= (duracion_mover_maquinaria tramo3 tramo5) 14)
    (= (duracion_mover_maquinaria tramo5 tramo3) 14)
    (= (duracion_mover_maquinaria tramo4 tramo5) 12)
    (= (duracion_mover_maquinaria tramo5 tramo4) 12)

    (= (duracion_mover_maquinaria tramo3 tramo6) 8) ;;Pregunta 2 ;;
    (= (duracion_mover_maquinaria tramo6 tramo3) 8) ;;Pregunta 2 ;;
    (= (duracion_mover_maquinaria tramo5 tramo6) 6) ;;Pregunta 2 ;;
    (= (duracion_mover_maquinaria tramo6 tramo5) 6) ;;Pregunta 2 ;;

    (= (duracion_mover_cuadrilla tramo1 tramo2) 5)
    (= (duracion_mover_cuadrilla tramo2 tramo1) 5)
    (= (duracion_mover_cuadrilla tramo2 tramo3) 6)
    (= (duracion_mover_cuadrilla tramo3 tramo2) 6)
    (= (duracion_mover_cuadrilla tramo2 tramo4) 4)
    (= (duracion_mover_cuadrilla tramo4 tramo2) 4)
    (= (duracion_mover_cuadrilla tramo3 tramo5) 7)
    (= (duracion_mover_cuadrilla tramo5 tramo3) 7)
    (= (duracion_mover_cuadrilla tramo4 tramo5) 6)
    (= (duracion_mover_cuadrilla tramo5 tramo4) 6)

    (= (duracion_mover_cuadrilla tramo3 tramo6) 4) ;;Pregunta 2 ;;
    (= (duracion_mover_cuadrilla tramo6 tramo3) 4) ;;Pregunta 2 ;;
    (= (duracion_mover_cuadrilla tramo5 tramo6) 3) ;;Pregunta 2 ;;
    (= (duracion_mover_cuadrilla tramo6 tramo5) 3) ;;Pregunta 2 ;;

    (= (duracion_compactar) 250)
    (= (duracion_pavimentar) 190)
    (= (duracion_aplastar) 150)
    (= (duracion_pintar) 30)
    (= (duracion_vallas) 120)
    (= (duracion_senyales) 70)
    ( = (duracion_provar_asf) 20) ;; Pregunta 3 ;;

    (= (coste_total) 0)
    (= (coste_cis) 25)
    (= (coste_pav) 30)
    (= (coste_com) 35)

)

(:goal(and

    (at cuadrilla1 tramo1)
    (at cuadrilla2 tramo5)
    (at cuadrilla4 tramo5)
    (at cisterna1 tramo1)
    (at cisterna2 tramo3)
    (at compactadora1 tramo5)

    (aplastado tramo1)
    (aplastado tramo2)
    (aplastado tramo3)
    (aplastado tramo4)
    (aplastado tramo5)
    (aplastado tramo6) ;;Pregunta 2;;

    (pintado tramo1)
    (pintado tramo2)
    (pintado tramo3)
    (pintado tramo4)
    (pintado tramo5)
    (pintado tramo6) ;;Pregunta 2;;

    (vallado tramo1)
    (vallado tramo2)
    (vallado tramo3)
    (vallado tramo4)
    (vallado tramo5)
    (vallado tramo6) ;; Pregunta 2;;

    (senalizado tramo3)
    (senalizado tramo4)
    (senalizado tramo5)
    (senalizado tramo6) ;;Pregunta 2;;

    (probado tramo1) ;; Pregunta 3 ;;
    (probado tramo2) ;; Pregunta 3 ;;
    (probado tramo3) ;; Pregunta 3 ;;
    (probado tramo4) ;; Pregunta 3 ;;
    (probado tramo5) ;; Pregunta 3 ;;
    (probado tramo6) ;; Pregunta 3 ;;
))

(:metric minimize (coste_total))
)
