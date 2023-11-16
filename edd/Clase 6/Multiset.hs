module Multiset
    (Multiset, emptyMS, addMS, ocurrencesMS, unionMS, intersectionMS, multiSetToList)
    where

data Multiset a = MS [(a, Int)]
    deriving Show

emptyMS :: MultiSet a
-- Propósito: denota un multiconjunto vacío.
addMS :: Ord a => a -> MultiSet a -> MultiSet a
-- Propósito: dados un elemento y un multiconjunto, agrega una ocurrencia de ese elemento al
-- multiconjunto.
ocurrencesMS :: Ord a => a -> MultiSet a -> Int
-- Propósito: dados un elemento y un multiconjunto indica la cantidad de apariciones de ese
-- elemento en el multiconjunto.
unionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a (opcional)
-- Propósito: dados dos multiconjuntos devuelve un multiconjunto con todos los elementos de
-- ambos multiconjuntos.
intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a (opcional)
-- Propósito: dados dos multiconjuntos devuelve el multiconjunto de elementos que ambos
-- multiconjuntos tienen en común.
multiSetToList :: MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
-- su cantidad de ocurrencias

emptyM = []

addMS elemento multiSet = if perteneceAMS elemento multiset
                            then agregarOcurrencia elemento multiset
                            else agregarElementoMS elemento multiset

perteneceAMS :: a -> MultiSet a -> Bool
perteneceAMS a (MS xs) = perteneceALista a xs

perteneceALista :: a -> [a] -> Bool
perteneceALista a []        = False
perteneceALista a (x:xs)    = (a == x) || (perteneceALista a xs)

agregarOcurrencia :: a -> MultiSet a -> MultiSet a
agregarOcurrencia a (MS xs) = agregarOcurrencia' a xs

agregarOcurrencia' :: a -> [(a, Int)] -> [(a, Int)]
agregarOcurrencia' a []     = []
agregarOcurrencia' a (x:xs) = if (keyDeMP x) == a
                                then sumarUnoMP x : xs
                                else x : agregarOcurrencia' a xs

sumarUnoMP :: [(a, Int)] -> [(a, Int)]
sumarUnoMP (a, n) = (a, (n + 1))

agregarElementoMS :: a -> MultiSet a -> MultiSet a
agregarElementoMS a multiset = agregarElementoMS' (a, 1) multiset

agregarElementoMS' :: (a, Int) -> Multiset a -> MultiSet a
agregarElementoMS' a (MS xs) = (MS (a:xs))

ocurrencesMS :: a -> MultiSet a -> Int
ocurrencesMS a (MS xs) = ocurrencesMS' a xs

ocurrencesMS' :: a -> [(a, Int)] -> Int
ocurrencesMS' a []       = 0
ocurrencesMS' a (x:xs)   = if a == (elementoDe x)
                            then ocurrenciaDe x
                            else ocurrencesMS' a xs

elementoDe :: [(a, Int)] -> a
elementoDe (a, _) = a

ocurrenciaDe :: [(a, Int)] -> Int
ocurrenciaDe (_, n) = n

unionMS (MS els1) (MS els2) = (MS (unionMS' els1 els2))

unionMS' :: [(a, Int)] -> [(a, Int)] -> [(a, Int)]
unionMS' [] es      = es
unionMS' (x:xs) es  = agregarAElsSM x (unionMS' xs es)

agregarAElsSM :: (a, Int) -> [(a, Int)] -> [(a, Int)]
agregarAElsSM a []              = [a]
agregarAElsSM (a, n) (el:els)   = if a == (elementoDe el)
                                    then (a, (n + (ocurrenciaDe el))) : els
                                    else el : (agregarElementoMS (a, n) els)

intersectionMS :: Ord a => MultiSet a -> MultiSet a -> MultiSet a (opcional)
intersectionMS (MS els1) (MS els2) = (MS )

multiSetToList :: MultiSet a -> [(a, Int)]
-- Propósito: dado un multiconjunto devuelve una lista con todos los elementos del conjunto y
-- su cantidad de ocurrencias.
multiSetToList (MS es) = es