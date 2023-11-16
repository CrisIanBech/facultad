module Set
    (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)
    where

data Set a = S [a] Int
    deriving Show

emptyS :: Set a -- Crea un conjunto vacío.
emptyS = S [] 0

addS :: Eq a => a -> Set a -> Set a --Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS a set = if belongs a set
                then set
                else agregar a set

agregar :: Eq a => a -> Set a -> Set a
agregar a (S as n) = (S (a:as) (n + 1))

belongs :: Eq a => a -> Set a -> Bool --Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.
belongs a (S xs _) = pertenece a xs 

pertenece :: Eq a => a -> [a] -> Bool
pertenece a []      = False
pertenece a (x:xs)  = (a == x) || pertenece a xs

sizeS :: Eq a => Set a -> Int --Devuelve la cantidad de elementos distintos de un conjunto.
sizeS (S _ n) = n

removeS :: Eq a => a -> Set a -> Set a
removeS a set = if belongs a set
                    then removerDeSet a set
                    else set

removerDeSet :: Eq a => a -> Set a -> Set a --Saca el elemento del set. Debe de existir ese elemento en el set
removerDeSet a (S xs n) = (S (removerDeLista a xs) (n - 1))


removerDeLista :: Eq a => a -> [a] -> [a] --Borra un elemento del conjunto.
removerDeLista a [] = []
removerDeLista a (x:xs) = if (a == x)
                            then xs
                            else x : (removerDeLista a xs)

unionS :: Eq a => Set a -> Set a -> Set a --Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.
unionS (S xs n) set = agregarASet xs set

agregarASet :: Eq a => [a] -> Set a -> Set a
agregarASet [] set      = set
agregarASet (x:xs) set  = agregarASet xs (addS x set)

setToList :: Eq a => Set a -> [a] --Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.
setToList (S xs n) = xs