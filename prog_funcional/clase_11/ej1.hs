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
                        where g i is = if f i
                                        then i : is
                                        else is

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada = pizzaProcesada f Prepizza
                            where f (Aceitunas n) pz = Capa (Aceitunas n * 2) pz
                                  f i pz             = duplicarIng i pz

-- No acepta aceitunas
duplicarIng :: Ingrediente -> Pizza -> Pizza
duplicarIng i pz = Capa i (Capa i pz)

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
                    where f i p = \n -> if n == 0
                                            then Prepizza
                                            else agregarCapa i (h n - 1)
