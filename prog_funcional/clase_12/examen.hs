data Dir = LeftM | RightM | StraightM
        deriving (Show)
data Mapa a = Cofre [a] | Nada (Mapa a) | Bifurcacion [a] (Mapa a) (Mapa a)
        deriving (Show)

mapaPrueba = Nada  (
                    (Bifurcacion
                        [8,9,10]
                        (Cofre [1, 2, 3])
                        (Nada
                            (Cofre [4,5,6])
                        )
                    )
                    )

objects :: Mapa a -> [a]
objects (Cofre os)              = os
objects (Nada m)                = objects m
objects (Bifurcacion os ml mr)  = os ++ (objects ml) ++ (objects mr)

mapMp :: (a -> b) -> Mapa a -> Mapa b
mapMp f (Cofre os)              = Cofre (map f os)
mapMp f (Nada m)                = Nada (mapMp f m)
mapMp f (Bifurcacion os ml mr)  = Bifurcacion (map f os) (mapMp f ml) (mapMp f mr)

hasObjectAt :: (a -> Bool) -> Mapa a -> [Dir] -> Bool
hasObjectAt p (Cofre os)             []              = any p os 
hasObjectAt p (Nada m)               (StraightM:xs)  = hasObjectAt p m xs
hasObjectAt p (Bifurcacion os ml mr) []              = any p os
hasObjectAt p (Bifurcacion os ml mr) (LeftM:xs)      = hasObjectAt p ml xs 
hasObjectAt p (Bifurcacion os ml mr) (RightM:xs)     = hasObjectAt p mr xs
hasObjectAt _ _                      _               = False

longestPath :: Mapa a -> [Dir]
longestPath (Cofre os)              = []
longestPath (Nada m)                = StraightM: (longestPath m)
longestPath (Bifurcacion os ml mr)  = let (lPath, rPath) = ((longestPath ml), (longestPath mr))
                                        in if(length lPath > length rPath)
                                            then LeftM: lPath
                                            else RightM : rPath

objectsOfLongestPath :: Mapa a -> [a]
objectsOfLongestPath (Cofre os)             = os
objectsOfLongestPath (Nada m)               = objectsOfLongestPath m
objectsOfLongestPath (Bifurcacion os ml mr) = os ++ if heightM ml > heightM mr 
                                                        then objectsOfLongestPath ml
                                                        else objectsOfLongestPath mr

heightM :: Mapa a -> Int
heightM (Cofre _)               = 1
heightM (Nada m)                = 1 + (heightM m)
heightM (Bifurcacion _ ml mr)   = 1 + (max (heightM ml) (heightM mr))

allPaths :: Mapa a -> [[Dir]]
allPaths (Cofre _)              = [[]]
allPaths (Nada m)               = map (StraightM:) (allPaths m) 
allPaths (Bifurcacion _ ml mr)  = (allPaths ml) ++ (allPaths mr)

foldM :: ([a] -> b) 
            -> (b -> b)
            -> ([a] -> b -> b -> b)
            -> Mapa a
            -> b
foldM fc fn fb (Cofre os)               = fc os
foldM fc fn fb (Nada m)                 = fn (foldM fc fn fb m)
foldM fc fn fb (Bifurcacion os ml mr)   = fb os (foldM fc fn fb ml) (foldM fc fn fb mr)

recM :: ([a] -> b) 
            -> (b -> Mapa a -> b)
            -> ([a] -> b -> b -> Mapa a -> Mapa a -> b)
            -> Mapa a
            -> b
recM fc fn fb (Cofre os)               = fc os
recM fc fn fb (Nada m)                 = fn (recM fc fn fb m) m
recM fc fn fb (Bifurcacion os ml mr)   = fb os (recM fc fn fb ml) (recM fc fn fb mr) ml mr

-- 2.

objects' :: Mapa a -> [a]
objects' = foldM (id) (id) fb
            where fb os osl osr = os ++ osl ++ osr

mapMp' :: (a -> b) -> Mapa a -> Mapa b
mapMp' f = foldM (Cofre . map f) (Nada) fb
            where fb os = Bifurcacion (map f os)

hasObjectAt' :: (a -> Bool) -> Mapa a -> [Dir] -> Bool
hasObjectAt' p = foldM fc fn fb
                    where fc os []                  = any p os
                          fn h  (StraightM:ds)      = h ds
                          fn h  _                   = False
                          fb os ml mr []            = any p os
                          fb os ml mr (LeftM:ds)    = ml ds
                          fb os ml mr (RightM:ds)   = mr ds
                          fb os _  _  _             = False


longestPath' :: Mapa a -> [Dir]
longestPath' = foldM (const []) (StraightM:) fb
                where fb _ dsl dsr = if(length dsl > length dsr)
                                        then LeftM: dsl
                                        else RightM: dsr

objectsOfLongestPath' :: Mapa a -> [a]
objectsOfLongestPath' = recM (id) (const) fb
                            where fb os osl osr ml mr = if(heightM ml > heightM mr)
                                                            then os ++ osl
                                                            else os ++ osr

allPaths' :: Mapa a -> [[Dir]]
allPaths' = foldM (const [[]]) (map (StraightM:)) fb
                where fb _ psl psr = (map (LeftM:) psl) ++ (map (RightM:) psr) 

-- 4.

Prop.: ¿length . objects = countObjects?
Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿para todo m' :: Mapa a. length . objects m' = countObjects m'?
    Sea m un Mapa a cualquiera, por ppio de inducción en la estructura de Mapa a, es
    equivalente demostrar que:
    ¿length . objects m = countObjects m?
    
    Caso base: m = (Cofre os)
        ¿length . objects (Cofre os) = countObjects (Cofre os)?

    Caso inductivo.1: m = (Nada n)
        HI) ¡length . objects n = countObjects n!
        TI) ¿length . objects (Nada n) = countObjects (Nada n)?

    Caso inductivo.2: m = (Bifurcacion os ml mr)
        HI.1) ¡length . objects ml = countObjects ml!
        HI.2) ¡length . objects mr = countObjects mr!
        TI) ¿length . objects (Bifurcacion os ml mr) = countObjects (Bifurcacion os ml mr)?

    Dem. caso base:
        LI:
        length . objects (Cofre os)
        = def. op. .
        length (objects (Cofre os))
        = def. objects.1
        length os

        LD:
        countObjects (Cofre os)
        = def. countObjects
        length os

    Se llega a la misma expresión. Vale para este caso

    Dem. caso inductivo.1:
        LI:
        length . objects (Nada n)
        = def. op. .
        length (objects (Nada n))
        = def. 
        length (objects n)
        = def. op. .
        length . objects n
        = HI
        countObjects n

        LD:
        countObjects (Nada n)
        = def. countObjects.2
        countObjects n

    Dem. caso inductivo 2:
        LI:
        length . objects (Bifurcacion os ml mr)
        = def. op. .
        length (objects (Bifurcacion os ml mr))
        = def. objects.3
        length (os ++ (objects ml) ++ (objects mr))
        = asociatividad operador ++
        length (os ++ ((objects ml) ++ objects mr))
        = Practica 8, ej 2.a
        length os + length ((objects ml) ++ objects mr)
        = Practica 8, ej 2.a
        length os + length (objects ml) + length (objects mr)
        = def. op. .
        length os + length . objects ml + length . objects mr
        = HI.1 e HI.2
        length os + countObjects ml + countObjects mr

        LD:
        countObjects (Bifurcacion os ml mr)
        = def. countObjects.3
        length os + countObjects m1 + countObjects m2

        Se llega al mismo resultado. Se cumple la propiedad para este caso, y por ende, es válida.

    
    Prop.: ¿elem x . objects = hasObject (==x)?
    Dem.: Por ppio. de extensionalidad.
        ¿para todo m :: Mapa a. elem x . objects m = hasObject (==x) m?

    Por ppio de induccion:

    Dem. caso base: m = (Cofre os)
        ¿elem x . objects (Cofre os) = hasObject (==x) (Cofre os)?

    Dem. caso inductivo.1: m = (Nada n)
        HI) ¡elem x . objects n = hasObject (==x) n!
        TI) ¿elem x . objects (Nada n) = hasObject (==x) (Nada n)?

    Dem. caso inductivo.2: m = (Bifurcacion os ml mr)
        HI.1) ¡elem x . objects ml = hasObject (==x) ml!
        HI.2) ¡elem x . objects mr = hasObject (==x) mr!
        TI) ¿elem x . objects (Bifurcacion os ml mr) = hasObject (==x) (Bifurcacion os ml mr)?

    Dem. caso base:
        LI:
        elem x . objects (Cofre os)
        = def. op. .
        elem x (objects (Cofre os))
        = def. objects.1
        elem x os
        = Practica 8, ejercicio 2.c
        any . (==) x os
        = def. op. ., aplicación parcial (==) con x <- x
        any (==x) os

        LD:
        hasObject (==x) (Cofre os)
        = def. hasObject
        any (==x) os

    Dem. caso inductivo.1:
        LI:
        elem x . objects (Nada n)
        = def. op. .
        elem x (objects (Nada n))
        = def. objects.2
        elem x (objects n)
        = def. op. .
        elem x . objects n
        = HI
        hasObject (==x) n

        LD:
        hasObject (==x) (Nada n)
        = def. hasObject.2
        hasObject (==x) n

    Dem. caso inductivo.2:
        LI:
        elem x . objects (Bifurcacion os ml mr)
        = def. op. .
        elem x (objects (Bifurcacion os ml mr))
        = def. objects.3
        elem x (os ++ (objects ml) ++ (objects mr))
        = asociatividad de ++
        elem x (os ++ ((objects ml) ++ (objects mr)))
        = propiedad provista
        elem x os || elem x ((objects ml) ++ (objects mr))
        = propiedad propiedad
        elem x os || elem x (objects ml) || elem x (objects mr)
        = def. op. .
        elem x os || elem x . objects ml || elem x . objects mr
        = HI.1 e HI.2
        elem x os || hasObject (==x) ml || hasObject (==x) mr

        LD:
        hasObject (==x) (Bifurcacion os ml mr)
        = def. hasObject.3
        any (==x) os || hasObject (==x) ml || hasObject (==X) mr
        = Practica 8, ej 2.c
        elem x os || hasObject (==x) ml || hasObject (==X) mr 



-- Para todo x, as, bs: elem x (as ++ bs) = elem x as || elem x bs