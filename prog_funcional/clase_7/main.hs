PIZZA:

data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Aceitunas Int | Jamón | Queso | Salsa | MezclaRara

f Prepizza = ...
f (Capa i pz) = ... f pz

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza    = 0
cantidadDeCapas (Capa i pz) = 1 + cantidadDeCapas pz

cantidadDeAceitunas :: Pizza -> Int
cantidadDeAceitunas Prepizza    = 0
cantidadDeAceitunas (Capa i pz) = aceitunas i + cantidadDeAceitunas pz

aceitunas (Aceitunas n) = n
aceitunas _             = 0

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza    = Prepizza
duplicarAceitunas (Capa i pz) = Capa (duplicarSiAceitunas i) (duplicarAceitunas pz)

duplicarSiAceitunas (Aceitunas n) = Aceitunas (n*2)
duplicarSiAceitunas i             = i

sinLactosa :: Pizza -> Pizza
sinLactosa Prepizza    = Prepizza
sinLactosa (Capa i pz) = 
    if tieneLactosa i
       then sinLactosa pz
       else Capa i (sinLactosa pz)

tieneLactosa Queso = True
tieneLactosa _     = False

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa Prepizza    = True
aptaIntolerantesLactosa (Capa i pz) = not (tieneLactosa i) && aptaIntolerantesLactosa pz

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada Prepizza    = Prepizza
conDescripcionMejorada (Capa i pz) = juntarAceitunas i (conDescripcionMejorada pz)

juntarAceitunas (Aceitunas n) (Capa (Aceitunas m) pz) = Capa (Aceituna (n+m)) pz
juntarAceitunas i             pz                      = Capa i pz


4 b)
Prop.:
¿cantidadDeAceitunas (Capa Queso Prepizza) = cantidadDeAceitunas (conDescripcionMejorada (Capa Queso Prepizza))?

LI:

cantidadDeAceitunas (Capa Queso Prepizza)
=
cantAceitunas Queso + cantidadDeAceitunas Prepizza
=
0 + cantidadDeAceitunas Prepizza
=
0 + 0
= 
0

LD:
cantidadDeAceitunas (conDescripcionMejorada (Capa Queso Prepizza))
=
cantidadDeAceitunas (duplicarAceitunas (duplicarCapasMenosAceitunas (Capa Queso Prepizza)))
=
cantidadDeAceitunas (duplicarAceitunas (Capa Queso (Capa Queso (duplicarCapasMenosAceitunas Prepizza))))
=
cantidadDeAceitunas (duplicarAceitunas (Capa Queso (Capa Queso Prepizza)))
=
cantidadDeAceitunas (Capa duplicarSiAceitunas Queso duplicarAceitunas (Capa Queso Prepizza))
=
cantidadDeAceitunas (Capa Queso duplicarAceitunas (Capa Queso Prepizza))
=
cantidadDeAceitunas (Capa Queso (Capa duplicarSiAceitunas Queso duplicarAceitunas Prepizza))
=
cantidadDeAceitunas (Capa Queso (Capa Queso duplicarSiAceitunas Prepizza))
=
cantidadDeAceitunas (Capa Queso (Capa Queso Prepizza))
=
 Queso + cantidadDeAceitunas (Capa Queso Prepizza)
=
0 + cantidadDeAceitunas (Capa Queso Prepizza)
=
0 + cantAceitunas Queso + cantidadDeAceitunas Prepizza
=
0 + 0 + 0
=
0 + 0
=
0


c)
PROP.:
¿cantidadDeAceitunas (Capa (Aceitunas 8) (Capa Queso Prepizza)) = cantidadDeAceitunas(conDescripcionMejorada (Capa (Aceitunas 8) (Capa Queso Prepizza)))?

LI:
cantidadDeAceitunas (Capa (Aceitunas 8) (Capa Queso Prepizza))
=
cantAceitunas (Aceitunas 8) + cantidadDeAceitunas (Capa Queso Prepizza)
=
8 + cantidadDeAceitunas (Capa Queso Prepizza))
=
8 + cantAceitunas Queso + cantidadDeAceitunas Prepizza
=
8 + 0 + cantidadDeAceitunas Prepizza
=
8 + 0 + 0
=
8 + 0
=
8

LD:
cantidadDeAceitunas (conDescripcionMejorada (Capa (Aceitunas 8) (Capa Queso Prepizza)))
=
cantidadDeAceitunas (duplicarAceitunas (duplicarCapasMenosAceitunas (Capa (Aceitunas 8) (Capa Queso Prepizza))))
=
cantidadDeAceitunas (duplicarAceitunas ((Capa (Aceitunas 8) (duplicarCapasMenosAceitunas (Capa Queso Prepizza)))))
=
cantidadDeAceitunas (duplicarAceitunas ((Capa (Aceitunas 8) ((Capa Queso (Capa Queso (duplicarCapasMenosAceitunas Prepizza)))))))
=
cantidadDeAceitunas (duplicarAceitunas (Capa (Aceitunas 8) ((Capa Queso (Capa Queso Prepizza)))))
=
cantidadDeAceitunas (duplicarAceitunas (Capa (Aceitunas 8) ((Capa Queso (Capa Queso Prepizza)))))
=
cantidadDeAceitunas (Capa duplicarSiAceitunas (Aceitunas 8) duplicarAceitunas ((Capa Queso (Capa Queso Prepizza))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) duplicarAceitunas ((Capa Queso (Capa Queso Prepizza))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) ((Capa duplicarSiAceitunas Queso (Capa Queso Prepizza))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) ((Capa duplicarSiAceitunas Queso (duplicarAceitunas (Capa Queso Prepizza)))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) ((Capa Queso (duplicarAceitunas (Capa Queso Prepizza)))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) (Capa Queso (Capa duplicarSiAceitunas Queso (duplicarAceitunas Prepizza))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) (Capa Queso (Capa Queso (duplicarAceitunas Prepizza))))
=
cantidadDeAceitunas (Capa (Aceitunas 16) (Capa Queso (Capa Queso Prepizza)))
=
cantAceitunas (Aceitunas 16) + cantidadDeAceitunas (Capa Queso (Capa Queso Prepizza))
=
16 + cantidadDeAceitunas (Capa Queso (Capa Queso Prepizza))
=
16 + cantAceitunas Queso + cantidadDeAceitunas (Capa Queso Prepizza)
=
16 + 0 + cantidadDeAceitunas (Capa Queso Prepizza)
=
16 + 0 + cantAceitunas Queso + cantidadDeAceitunas Prepizza
=
16 + 0 + 0 + cantidadDeAceitunas Prepizza
=
16 + 0 + 0 + 0
=
16 + 0 + 0
= 
16 + 0
= 
16


SECCION 2:
3)
    a)
    largoDePlanilla :: Planilla -> Int
    largoDePlanilla (Fin) = 0
    largoDePlanilla (Registro n p) = 1 + largoDePlanilla p

    b)
    esta :: Nombre -> Planilla -> Bool
    esta n (Fin) = False
    esta n (Registro n' p) = esElMismoNombre n n' || esta n p

    esElMismoNombre :: Nombre -> Nombre
    esElMismoNombre n1 n2 = n1 == n2

    c)
    juntarPlanillas :: Planilla -> Planilla -> Planilla
    juntarPlanillas (Fin) p = p
    juntarPlanillas (Planilla n p) p' = (Planilla n (juntarPlanillas p p'))

    d)
    nivelesJerarquicos :: Equipo -> Int
    nivelesJerarquicos (Becario _) = 0
    nivelesJerarquicos (Investigador _ e1 e2 e3) 1 + nivelesJerarquicos e1 + nivelesJerarquicos e2 + nivelesJerarquicos e3

    e)
    cantidadDeIntegrantes :: Integrantes -> Int
    cantidadDeIntegrantes (Becario n) = 1
    cantidadDeIntegrantes (Investigador n e1 e2 e3) = 1 + cantidadDeIntegrantes e1 + cantidadDeIntegrantes e2 + cantidadDeIntegrantes e3

    f)
    planillaDeIntegrantes :: Equipo -> Planilla
    planillaDeIntegrantes (Becario n) = (Registro n Fin)
    planillaDeIntegrantes (Investigador n e1 e2 e3) = Registro n (juntarPlanillas (planillaDeIntegrantes e1) (juntarPlanillas (planillaDeIntegrantes e2) (planillaDeIntegrantes e)))

    
4)

    a)
    para todo p :: Planilla .
    largoDePlanilla (juntarPlanillas Fin p) = largoDePlanilla Fin + largoDePlanilla p
    
    LI:
    largoDePlanilla (juntarPlanillas Fin p)
    =
    largoDePlanilla (juntarPlanillas Fin p)
    =
    largoDePlanilla p

    LD: 
    largoDePlanilla Fin + largoDePlanilla p
    =
    0 + largoDePlanilla p
    =
    largoDePlanilla p

    b)
     p :: Planilla .
    largoDePlanilla (juntarPlanillas (Registro "Edsger" Fin) p) = largoDePlanilla (Registro "Edsger" Fin) + largoDePlanilla p

    LI:
    largoDePlanilla (juntarPlanillas (Registro "Edsger" Fin) p)
    =
    largoDePlanilla (Registro "Edsger" (juntarPlanillas Fin p))
    =
    largoDePlanilla (Registro "Edsger" p)
    =
    1 + largoDePlanilla p

    LD:
    largoDePlanilla (Registro "Edsger" Fin) + largoDePlanilla p
    =
    1 + largoDePlanilla p

    c)
    para todo p :: Planilla .
    largoDePlanilla (juntarPlanillas (Registro "Alan" (Registro "Edsger" Fin)) p)
        = largoDePlanilla (Registro "Alan"(Registro "Edsger" Fin)) + largoDePlanilla p 
    
    LI:
    largoDePlanilla (juntarPlanillas (Registro "Alan" (Registro "Edsger" Fin)) p)
    =
    largoDePlanilla ((Registro "Alan" (juntarPlanillas (Registro "Edsger" Fin)) p))
    =
    largoDePlanilla ((Registro "Alan" (Registro "Edsger" (juntarPlanillas Fin p))))
    =
    largoDePlanilla ((Registro "Alan" (Registro "Edsger" p)))
    =
    1 + largoDePlanilla (Registro "Edsger" p)
    =
    1 + 1 + largoDePlanilla p
    =
    2 + largoDePlanilla p

    LD:
    largoDePlanilla (Registro "Alan"(Registro "Edsger" Fin)) + largoDePlanilla p
    =
    1 + largoDePlanilla (Registro "Edsger" Fin) + largoDePlanilla p
    =
    1 + 1 + largoDePlanilla Fin + largoDePlanilla p
    =
    1 + 1 + 0 + largoDePlanilla p
    =
    2 + 0 + largoDePlanilla p
    =
    2 + largoDePlanilla p

    d)
    para todo p :: Planilla .
    largoDePlanilla (juntarPlanillas (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" Fin))) p)
        = largoDePlanilla (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" Fin))) + largoDePlanilla p

    LI:
    largoDePlanilla (juntarPlanillas (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" Fin))) p)
    =
    largoDePlanilla (Registro "Alonzo" (juntarPlanillas (Registro "Alan" (Registro "Edsger" Fin)) p))
    =
    largoDePlanilla (Registro "Alonzo" (Registro "Alan" (juntarPlanillas (Registro "Edsger" Fin) p)))
    =
    largoDePlanilla (Registro "Alonzo" (Registro "Alan" (juntarPlanillas (Registro "Edsger" Fin) p)))
    =
    largoDePlanilla (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" (juntarPlanillas Fin p))))
    =
    largoDePlanilla (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" p)))
    =
    1 + largoDePlanilla (Registro "Alan" (Registro "Edsger" p))
    =
    1 + 1 + largoDePlanilla (Registro "Edsger" p)
    =
    1 + 1 + 1 + largoDePlanilla p
    =
    2 + 1 + largoDePlanilla p
    =
    3 + largoDePlanilla p

    LD:
    largoDePlanilla (Registro "Alonzo" (Registro "Alan" (Registro "Edsger" Fin))) + largoDePlanilla p
    =
    1 + largoDePlanilla (Registro "Alan" (Registro "Edsger" Fin)) + largoDePlanilla p
    =
    1 + 1 + largoDePlanilla (Registro "Edsger" Fin) + largoDePlanilla p
    =
    1 + 1 + 1 + largoDePlanilla Fin + largoDePlanilla p
    =
    1 + 1 + 1 + 0 + largoDePlanilla p
    =
    2 + 1 + 0 + largoDePlanilla p
    =
    3 + 0 + largoDePlanilla p 
    =
    3nria + largoDePlanilla p

5)

    a)
    largoDePlanilla (planillaDeIntegrantes (Becario "Alan")) = cantidadDeIntegrantes (Becario "Alan")

    LI:
    largoDePlanilla (planillaDeIntegrantes (Becario "Alan"))
    =
    largoDePlanilla (Registro "Alan" Fin)
    =
    1 + largoDePlanilla Fin
    =
    1 + 0
    =
    1

    LD:
    cantidadDeIntegrantes (Becario "Alan")
    =
    1

    d)
    largoDePlanilla
        (planillaDeIntegrantes
        (Investigador "Alonzo" (Becario "Alan")
        (Becario "Alfred")
        (Becario "Stephen")))
    = 
    cantidadDeIntegrantes
        (Investigador "Alonzo" (Becario "Alan")
        (Becario "Alfred")
        (Becario "Stephen"))

    LI:
    largoDePlanilla
        (planillaDeIntegrantes
        (Investigador "Alonzo" (Becario "Alan")
        (Becario "Alfred")
        (Becario "Stephen")))
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (planillaDeIntegrantes (Becario "Alan")) (juntarPlanillas (planillaDeIntegrantes (Becario "Alfred")) (planillaDeIntegrantes (Becario "Stephen")))))
        
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (Registro "Alan" Fin)) (juntarPlanillas (planillaDeIntegrantes (Becario "Alfred")) (planillaDeIntegrantes (Becario "Stephen"))))
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (Registro "Alan" Fin)) (juntarPlanillas (Registro "Alfred" Fin)) (planillaDeIntegrantes (Becario "Stephen")))
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (Registro "Alan" Fin)) (juntarPlanillas (Registro "Alfred" Fin)) (Registro "Stephen" Fin))
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (Registro "Alan" Fin)) (Planilla "Alfred" (juntarPlanillas Fin (Registro "Stephen" Fin))))
    =
        largoDePlanilla
        (Registro "Alonzo" (juntarPlanillas (Registro "Alan" Fin)) (Planilla "Alfred" (Registro "Stephen" Fin)))
    =
        largoDePlanilla
        (Registro "Alonzo" ((Registro "Alan" (juntarPlanillas Fin (Planilla "Alfred" (Registro "Stephen" Fin))))))
    =
        largoDePlanilla
        (Registro "Alonzo" (Registro "Alan" (Planilla "Alfred" (Registro "Stephen" Fin))))
    =
    1 + largoDePlanilla (Registro "Alan" (Planilla "Alfred" (Registro "Stephen" Fin)))
    =
    1 + 1 + largoDePlanilla (Planilla "Alfred" (Registro "Stephen" Fin))
    =
    1 + 1 + 1 + largoDePlanilla (Registro "Stephen" Fin)
    =
    1 + 1 + 1 + 1 + largoDePlanilla Fin
    =
    1 + 1 + 1  + 0
    =
    2 + 1 + 1  + 0
    =
    3 + 1 + 0
    =
    4 + 0
    = 
    4


    LD:
    cantidadDeIntegrantes
        (Investigador "Alonzo" (Becario "Alan")
        (Becario "Alfred")
        (Becario "Stephen"))
    =
    1 + cantidadDeIntegrantes (Becario "Alan") + cantidadDeIntegrantes (Becario "Alfred") + cantidadDeIntegrantes (Becario "Stephen")
    =
    1 + 1 + cantidadDeIntegrantes (Becario "Alfred") + cantidadDeIntegrantes (Becario "Stephen")
    =
    1 + 1 + 1 + cantidadDeIntegrantes (Becario "Stephen")
    =
    1 + 1 + 1 + 1
    =
    2 + 1 + 1
    =
    3 + 1
    =
    4


    c)
    para todo n :: Nombre .
    largoDePlanilla (planillaDeIntegrantes (Becario n))
    = 
    cantidadDeIntegrantes (Becario n)

    LI:
    largoDePlanilla (planillaDeIntegrantes (Becario n))
    =
    largoDePlanilla (Registro n Fin)
    =
    1 

    LD:
    cantidadDeIntegrantes (Becario n)
    =
    1
