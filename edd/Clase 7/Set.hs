module Set
    (Set, emptyS, addS, belongs, sizeS, removeS, unionS, setToList)
    where
        
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

data Set a = S (Tree a)
    deriving Show

emptyS :: Set a
-- Crea un conjunto vacío.

addS :: Ord a => a -> Set a -> Set a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.
addS' :: Ord a => a -> Tree a -> Tree a
-- Dados un elemento y un conjunto, agrega el elemento al conjunto.

belongs :: Ord a => a -> Set a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.

belongs' :: Ord a => a -> Tree a -> Bool
-- Dados un elemento y un conjunto indica si el elemento pertenece al conjunto.

sizeS :: Ord a => Set a -> Int
-- Devuelve la cantidad de elementos distintos de un conjunto.

sizeS' :: Ord a => Tree a -> Int
-- Devuelve la cantidad de elementos distintos de un árbol.

removeS :: Ord a => a -> Set a -> Set a
-- Borra un elemento del conjunto.

removeS' :: Ord a => a -> Tree a -> Tree a
-- Borra un elemento de un tree set.

unionS :: Ord a => Set a -> Set a -> Set a
-- Dados dos conjuntos devuelve un conjunto con todos los elementos de ambos conjuntos.

setToList :: Ord a => Set a -> [a]
-- Dado un conjunto devuelve una lista con todos los elementos distintos del conjunto.

emptyS = S EmptyT

addS el (S tree) = (S (addS' el tree))

addS' el EmptyT          = (NodeT el EmptyT EmptyT)
addS' el (NodeT n ti td) = if el == n
                                then NodeT n ti td
                                else if el < n 
                                    then (NodeT n (addS' el ti) td)
                                    else (NodeT n ti (addS' el td))


belongs el (S tree) = belongs' el tree

belongs' el EmptyT          = False
belongs' el (NodeT n ti td) = if el == n
                                then True
                                else if el < n 
                                    then belongs' el ti
                                    else belongs' el td


sizeS (S tree) = sizeS' tree

sizeS' EmptyT           = 0
sizeS' (NodeT n ti td)  = 1 + (sizeS' ti) + (sizeS' td)


removeS el (S tree) = S (removeS' el tree)

removeS' el EmptyT          = EmptyT
removeS' el (NodeT n ti td) = if el == n 
                                then rearmarBST ti td
                                else if el < n
                                    then (NodeT n (removeS' el ti) td)
                                    else (NodeT n ti (removeS' el td))


rearmarBST :: Tree a -> Tree a -> Tree a
rearmarBST EmptyT td    = td
rearmarBST ti td        = let (min, tii) = splitMinBST ti
                            in (NodeT min tii td)

splitMinBST :: Tree a -> (a, Tree a)
splitMinBST (NodeT n EmptyT td) = (n, td)
splitMinBST (NodeT n ti td)     = let (min, tii) = splitMinBST ti
                                    in (min, (NodeT n tii td))

unionS setUno (S EmptyT)    = setUno
unionS setUno setDos        = unionS' setUno (setToList setDos)

unionS' :: Ord a => Set a -> [a] -> Set a
unionS' set []         = set
unionS' set (x:xs)     = addS x (unionS' set xs)

setToList (S tree) = setToList' tree

setToList' :: Ord a => Tree a -> [a]
setToList' EmptyT            = []
setToList' (NodeT n ti td)   = n : (setToList' ti) ++ (setToList' td)