a. cantidadCapasQueCumplen
:: (Ingrediente -> Bool) -> Pizza -> Int
b. conCapasTransformadas
:: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
c. soloLasCapasQue
:: (Ingrediente -> Bool) -> Pizza -> Pizza

data Pizza = Prepizza | Capa Ingrediente Pizza
data Ingrediente = Aceitunas Int | Anchoas | Cebolla
| Jamón | Queso | Salsa

cantidadCapasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen f (Prepizza) = 0
cantidadCapasQueCumplen f (Capa i p) = delta(f i) + cantidadCapasQueCumplen f p

conCapasTransformadas :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas f (Prepizza) = Prepizza
conCapasTransformadas f (Capa i p) = Capa f i (conCapasTransformadas f p)

soloLasCapasQue :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue f (Prepizza) = Prepizza
soloLasCapasQue f (Capa i p) = if f i
                                then Capa i (soloLasCapasQue f p)
                                else soloLasCapasQue f p

ej2:

sinLactosa :: Pizza -> Pizza
sinLactosa = soloLasCapasQue esQueso

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa p = cantidadCapasQueCumplen esQueso p == 0

cantidadDeQueso :: Pizza -> Int
cantidadDeQueso = cantidadCapasQueCumplen esQueso

esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso _     = False

conElDobleDeAceitunas :: Pizza -> Pizza
conElDobleDeAceitunas = conCapasTransformadas dobleAceitunas

dobleAceitunas :: Ingrediente -> Ingrediente
dobleAceitunas (Aceitunas n) = Aceitunas n * 2
dobleAceitunas idea          = i

ej3:

pizzaProcesada :: (Ingrediente -> b -> b) -> b -> Pizza -> b
pizzaProcesada f z Prepizza   = z
pizzaProcesada f z (Capa i p) = f i (pizzaProcesada f z p) 

ej4:

cantidadCapasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen g = pizzaProcesada f 0
                where f i acc = delta(g i) + acc

conCapasTransformadas :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas g = pizzaProcesada f Prepizza
                            where f i pp = Capa (g i) pp

soloLasCapasQue :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue g = pizzaProcesada f Prepizza
                        where f i pp = if g i
                                        then Capa i pp
                                        else pp

sinLactosa :: Pizza -> Pizza
sinLactosa = soloLasCapasQue esQueso

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa p = cantidadCapasQueCumplen esQueso p == 0

cantidadDeQueso :: Pizza -> Int
cantidadDeQueso = cantidadCapasQueCumplen esQueso

esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso _     = False

conElDobleDeAceitunas :: Pizza -> Pizza
conElDobleDeAceitunas = conCapasTransformadas dobleAceitunas

dobleAceitunas :: Ingrediente -> Ingrediente
dobleAceitunas (Aceitunas n) = Aceitunas n * 2
dobleAceitunas idea          = i

ej5:

cantidadAceitunas :: Pizza -> Int
cantidadAceitunas = pizzaProcesada f 0
                    where f (Aceitunas n) as = n + as
                          f _             as = as

capasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> [Ingrediente]
capasQueCumplen f = pizzaProcesada g []
                        where g i pz = if f i
                                        then i : pz
                                        else pz

capasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> [Ingrediente]
capasQueCumplen f Prepizza    = []
capasQueCumplen f (Capa i p)  = if(f i) 
                                    then i : (capasQueCumplen f p)
                                    else capasQueCumplen f p

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada = pizzaProcesada f Prepizza
                            where f (Aceitunas n) pz = Capa (Aceitunas n * 2) pz
                                  f i pz             = duplicarIng i pz

cantidadDe :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadDe f (Prepizza)  = 0
cantidadDe f (Capa i' p) = if f i' then 1 else 0 + cantidadDe f p

-- No acepta aceitunas
duplicarIng :: Ingrediente -> Pizza -> Pizza
duplicarIng i pz = Capa i (Capa i pz)

-- Rec ex
conCapasDe :: Pizza -> Pizza -> Pizza
conCapasDe (Prepizza) p  = p
conCapasDe (Capa i p) p2 = (Capa i (conCapasDe p p2))

conCapasDe :: Pizza -> Pizza -> Pizza -- que agrega las capas de la primera pizza sobre la segunda
conCapasDe = pizzaProcesada g (\p -> p)
                where g i pz = \p -> agregarCapa i p

agregarCapa :: Ingrediente -> Pizza -> Pizza
agregarCapa (Prepizza) pz = pz
agregarCapa i pz          = Capa i pz

primerasNCapas :: Int -> Pizza -> Pizza
primerasNCapas n    = \p -> Prepizza
primerasNCapas 0    = \p -> Prepizza
primerasNCapas n    = \p -> (Capa i (primerasNCapas (n - 1) p))

primerasNCapas :: Int -> Pizza -> Pizza
primerasNCapas = flip (pizzaProcesada f (\n -> Prepizza))
                    where f i h = \n -> if n == 0
                                            then Prepizza
                                            else agregarCapa i (h (n - 1))

ej 6:

      Prop.: para todo f. length . capasQueCumplen f = cantidadDe f
      f :: (Ingrediente -> Bool). p :: Pizza
      ¿para todo f. para todo p. ¿length . capasQueCumplen f p = cantidadDe f p?
      Dem.: ppio induccion, ppio. extensionalidad.

      Caso base: p = Prepizza
            ¿length . capasQueCumplen f Prepizza = cantidadDe f Prepizza?
      
      Caso inductivo: p = Capa i p
            HI) ¡length . capasQueCumplen f p = cantidadDe f p!
            TI) ¿length . capasQueCumplen f (Capa i p) = cantidadDe f (Capa i p)?

      Dem. caso base:
            LI:
            length . capasQueCumplen f Prepizza
            = def. op .
            length (capasQueCumplen f) Prepizza
            = def. capasQueCumplen
            length []
            = def. length
            0

            LD:
            cantidadDe f Prepizza
            = def. cantidadDe
            0

      Dem. caso inductivo:
            LI:
            length . capasQueCumplen f (Capa i p)
            = def. op. .
            length (capasQueCumplen f) (Capa i p)
            = def. capasQueCumplen 
            length (if(f i) 
                        then i : (capasQueCumplen f p)
                        else capasQueCumplen f p)
            
            -- Por análisis de casos:

            Caso: f i = True
                  length (i : (capasQueCumplen f p))
                  = def. length
                  1 + length (capasQueCumplen f p)

            Caso f i = False
                  length (capasQueCumplen f p)
                  = HI.
                  cantidadDe f p

            LD:

            Por análisis de casos:
            
            cantidadDe f (Capa i p)
            = def. cantidadDe
            if f i then 1 else 0 + cantidadDe f p

            -- Por análisis de casos:

            Caso f i = True
                  1 + cantidadDe f p

            Caso f i = False
                  0 + cantidadDe f p
                  = neutro sumar
                  cantidadDe f p

            Se llega a los mismos resultados en todos los casos. La propiedad es válida.

      b.
      Prop.: ¿para todo f. para todo p1. para todo p2.
                  cantidadCapasQueCumplen f (conCapasDe p1 p2)
                        = cantidadCapasQueCumplen f p1 + cantidadCapasQueCumplen f p2?
      Dem.: Por ppio. de inducción en la estructura de p1.

      Caso base: p1 = Prepizza
            ¿cantidadCapasQueCumplen f (conCapasDe Prepizza p2)
                        = cantidadCapasQueCumplen f Prepizza + cantidadCapasQueCumplen f p2?

      Caso inductivo: p1 = (Capa i p)
            HI) ¡cantidadCapasQueCumplen f (conCapasDe p p2)
                        = cantidadCapasQueCumplen f p + cantidadCapasQueCumplen f p2!
            TI) ¿cantidadCapasQueCumplen f (conCapasDe (Capa i p) p2)
                        = cantidadCapasQueCumplen f (Capa i p) + cantidadCapasQueCumplen f p2?

      Dem. caso base:
            LI:
            cantidadCapasQueCumplen f (conCapasDe Prepizza p2)
            = def. conCapasDe
            cantidadCapasQueCumplen f p2

            LD:
            cantidadCapasQueCumplen f Prepizza + cantidadCapasQueCumplen f p2
            = def. cantidadCapasQueCumplen
            0 + cantidadCapasQueCumplen f p2
            = neutro suma
            cantidadCapasQueCumplen f p2

            Se llega al mismo resultado. Vale para este caso.

      Dem. caso inductivo:
            LI:
            cantidadCapasQueCumplen f (conCapasDe (Capa i p) p2)
            = def. conCapasDe
            cantidadCapasQueCumplen f (Capa i (conCapasDe p p2))
            = def. cantidadCapasQueCumplen.2
            if(f i)
                  then 1 + cantidadCapasQueCumplen f (conCapasDe p p2)
                  else 0 + cantidadCapasQueCumplen f (conCapasDe p p2)

            Análisis de casos:
                  f i = True
                  1 + cantidadCapasQueCumplen f (conCapasDe p p2)

                  f i = False
                  0 + cantidadCapasQueCumplen f (conCapasDe p p2)
            
            LD:
            cantidadCapasQueCumplen f (Capa i p) + cantidadCapasQueCumplen f p2
            = def. cantidadCapasQueCumplen
            (if(f i)
                  then 1 + cantidadCapasQueCumplen f p
                  else 0 + cantidadCapasQueCumplen f p) + cantidadCapasQueCumplen f p2
            
            Análisis de casos:
                  f i = True
                  1 + cantidadCapasQueCumplen f p

                  f i = False
                  0 + cantidadCapasQueCumplen f p + cantidadCapasQueCumplen f p2
                  = HI
                  0 + cantidadCapasQueCumplen f (conCapasDe p p2)

            Se llega al mismo valor. Vale este caso. Por lo tanto, se cumple la propiedad.

      c.
      
      Prop.: para todo f. para todo p1. para todo p2.
            conCapasTransformadas f (conCapasDe p1 p2) = 
                  conCapasDe (conCapasTransformadas f p1) (conCapasTransformadas f p2)
      Dem.: Ppio. de induccion sobre la estructura de p1.

            Caso base: p1 = Prepizza
                  ¿conCapasTransformadas f (conCapasDe Prepizza p2) = 
                        conCapasDe (conCapasTransformadas f Prepizza) (conCapasTransformadas f p2)?
                  
            Caso inductivo: p1 = Capa i p
                  HI) ¡conCapasTransformadas f (conCapasDe p p2) = 
                        conCapasDe (conCapasTransformadas f p) (conCapasTransformadas f p2)!
                  TI) ¿conCapasTransformadas f (conCapasDe (Capa i p) p2) = 
                        conCapasDe (conCapasTransformadas f (Capa i p)) (conCapasTransformadas f p2)?
            
            Dem. caso base:
                  LI:
                  conCapasTransformadas f (conCapasDe Prepizza p2)
                  = def. conCapasDe
                  conCapasTransformadas f p2

                  LD:
                  conCapasDe (conCapasTransformadas f Prepizza) (conCapasTransformadas f p2)
                  = def. conCapasTransformadas
                  conCapasDe Prepizza (conCapasTransformadas f p2)
                  = def. conCapasDe
                  conCapasTransformadas f p2

                  Se llega al mismo resultado. Vale para este caso.

            Dem. caso inductivo:
                  LI:
                  conCapasTransformadas f (conCapasDe (Capa i p) p2)
                  = def. conCapasDe
                  conCapasTransformadas f (Capa i (conCapasDe p p2))
                  = def. 
                  Capa f i (conCapasTransformadas f (conCapasDe p p2))
                  = HI
                  Capa f i (conCapasDe (conCapasTransformadas f p) (conCapasTransformadas f p2))

                  LD:
                  conCapasDe (conCapasTransformadas f (Capa i p)) (conCapasTransformadas f p2)
                  = def. conCapasTransformadas
                  conCapasDe (Capa f i (conCapasTransformadas f p)) (conCapasTransformadas f p2)
                  = def. conCapasDe
                  Capa f i (conCapasDe (conCapasTransformadas f p) (conCapasTransformadas f p2))
                  
                  Se llega al mismo resultado. Vale para este caso, y por ende, la propiedad es válida.

            d.

            Prop.: ¿para todo f. cantidadCapasQueCumplen f . soloLasCapasQue f
                              = cantidadCapasQueCumplen f?
            Dem.: Ppio de extensionalidad. Por ppio de induccion en la estructura de p.

            ¿para todo f. cantidadCapasQueCumplen f . soloLasCapasQue f p
                              = cantidadCapasQueCumplen f p?

            Caso base: p = Prepizza
                  ¿cantidadCapasQueCumplen f . soloLasCapasQue f Prepizza
                              = cantidadCapasQueCumplen f Prepizza?
            
            Caso inductivo: p = (Capa i p')
                  HI) ¡cantidadCapasQueCumplen f . soloLasCapasQue f p'
                              = cantidadCapasQueCumplen f p'!
                  TI) ¿cantidadCapasQueCumplen f . soloLasCapasQue f (Capa i p')
                              = cantidadCapasQueCumplen f (Capa i p')?

            Dem. caso base:
                  LI:
                  cantidadCapasQueCumplen f . soloLasCapasQue f Prepizza
                  = def. op. .
                  cantidadCapasQueCumplen f (soloLasCapasQue f Prepizza)
                  = def. soloLasCapasQue
                  cantidadCapasQueCumplen f Prepizza
                  = def. cantidadCapasQueCumplen 
                  0

                  LD:
                  cantidadCapasQueCumplen f Prepizza
                  = def. cantidadCapasQueCumplen
                  0

                  Se llega al mismo resultado. Se cumple para este caso la propieda.

            Dem. caso inductivo:
                  LI:
                  cantidadCapasQueCumplen f . soloLasCapasQue f (Capa i p')
                  = def. op .
                  cantidadCapasQueCumplen f (soloLasCapasQue f (Capa i p'))
                  = def. soloLasCapasQue
                  cantidadCapasQueCumplen f (
                                                if f i
                                                      then Capa i (soloLasCapasQue f p')
                                                      else soloLasCapasQue f p'
                                            )

                  -- Análisis de casos
                  f i = True
                        cantidadCapasQueCumplen f (Capa i (soloLasCapasQue f p'))
                        = def. cantidadCapasQueCumplen (el if es true)
                        1 + cantidadCapasQueCumplen f (soloLasCapasQue f p')
                        = HI
                        1 + cantidadCapasQueCumplen f p'


                  f i = False
                        cantidadCapasQueCumplen f (soloLasCapasQue f p')
                        = def. cantidadCapasQueCumplen (el if es false)
                        0 + cantidadCapasQueCumplen f (soloLasCapasQue f p')
                        = HI
                        0 + cantidadCapasQueCumplen f p'

                  LD:
                  cantidadCapasQueCumplen f (Capa i p')
                  = def. cantidadCapasQueCumplen
                  if(f i) then 1 + cantidadCapasQueCumplen f p'
                          else 0 + cantidadCapasQueCumplen f p'

                  -- Análisis de casos:
                  f i = True
                        1 + cantidadCapasQueCumplen f p'

                  f i = False
                        0 + cantidadCapasQueCumplen f p'

            Se llega al mismo resultado en todos los casos. Se cumple la propiedad.