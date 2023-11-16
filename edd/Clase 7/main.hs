-- Ejercicio 1
-- Indicar el costo de heapsort :: Ord a => [a] -> [a] (de la práctica anterior) suponiendo que
-- el usuario utiliza una priority queue con costos logarítmicos de inserción y borrado.

-- El costo sería lineal, ya que:

-- PQ2List = O(n)
-- List2PQ = 0(n)

-- heapsort :: Ord a => [a] -> [a]
-- heapsort list = PQ2List (List2PQ list)

-- Costo de heapsort = O(n + n) = O(n)



-- Ejercicio 2
-- Implementar las siguientes funciones suponiendo que reciben un árbol binario que cumple los
-- invariantes de BST y sin elementos repetidos (despreocuparse por el hecho de que el árbol puede
-- desbalancearse al insertar o borrar elementos).

belongsBST :: Ord a => a -> Tree a -> Bool
-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
insertBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
deleteBST :: Ord a => a -> Tree a -> Tree a
-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
splitMinBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST :: Ord a => Tree a -> (a, Tree a)
-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
esBST :: Ord a => Tree a -> Bool -- ME TIRABA ERROR POR EL ORD
-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N2)
elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(log N)
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(log N)

balanceado :: Tree a -> Bool
-- Propósito: indica si el árbol está balanceado. Un árbol está balanceado cuando para cada
-- nodo la diferencia de alturas entre el subarbol izquierdo y el derecho es menor o igual a 1.
-- Costo: O(N2)

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

belongsBST el EmptyT            = False
belongsBST el (NodeT n t1 t2)   = if el == n
                                    then True
                                    else if el < n 
                                        then belongsBST el t1
                                        else belongsBST el t2

insertBST el EmptyT             = NodeT el EmptyT EmptyT
insertBST el (NodeT n t1 t2)    = if el == n
                                    then NodeT el t1 t2
                                    else if el < n
                                        then (NodeT n (insertBST el t1) t2)
                                        else (NodeT n t1 (insertBST el t2))

deleteBST _ EmptyT             = EmptyT
deleteBST el (NodeT n t1 t2)   = if el == n
                                    then rearmarBST t1 t2
                                    else if el < n
                                        then (NodeT n (deleteBST el t1) t2)
                                        else (NodeT n t1 (deleteBST el t2)) 

rearmarBST :: Tree a -> Tree a -> Tree a
rearmarBST EmptyT td    = td
rearmarBST ti td        = NodeT (maxDeBST ti) (delMaxBST ti) td

maxDeBST :: Tree a -> a -- El árbol no está vacío y es un BST
maxDeBST (NodeT el _ EmptyT)    = el
maxDeBST (NodeT el ti td)       = maxDeBST td

delMaxBST :: Tree a -> Tree a -- El árbol no está vacío y es un BST
delMaxBST (NodeT el ti EmptyT)  = ti
delMaxBST (NodeT el ti td)      = (NodeT el ti (delMaxBST td)) 

-- splitMinBST EmptyT               = EmptyT
splitMinBST (NodeT el EmptyT td) = (el, td)
splitMinBST (NodeT el ti td)     = let (min, tii) = splitMinBST ti
                                    in (min, (NodeT el tii td))

-- splitMaxBST EmptyT               = EmptyT
splitMaxBST (NodeT el ti EmptyT) = (el, ti)
splitMaxBST (NodeT el ti td)     = let (max, tdd) = splitMaxBST td
                                    in (max, (NodeT el ti tdd))

esMayorANI :: Ord a => a -> Tree a -> Bool
esMayorANI el EmptyT        = True
esMayorANI el (NodeT n _ _) = el > n


esMenorAND :: Ord a => a -> Tree a -> Bool
esMenorAND el EmptyT        = True
esMenorAND el (NodeT n _ _) = el < n

esBST EmptyT            = True
esBST (NodeT el ti td)  = ((esMayorANI el ti) && (esMenorAND el td)) && (esBST ti) && (esBST td)

balanceado EmptyT           = True     
balanceado (NodeT el ti td) = abs ((height ti) - (height td)) == 1 || ((height ti) - (height td)) == 0

elMaximoMenorA el EmptyT            = Nothing
elMaximoMenorA el (NodeT n ti td)   = if n < el
                                        then case elMaximoMenorA el td of
                                            Just m -> Just m
                                            Nothing -> Just n
                                        else elMaximoMenorA el ti

elMinimoMayorA el EmptyT            = Nothing
elMinimoMayorA el (NodeT n ti td)   = if n > el
                                        then case elMinimoMayorA el ti of
                                            Just m -> Just m
                                            Nothing -> Just n
                                        else elMinimoMayorA el td

height :: Tree a -> Int
height EmptyT           = 0
height (NodeT el ti td) = 1 + mayorEntre (height ti) (height td)

mayorEntre :: Int -> Int -> Int
mayorEntre a b = if a > b
                    then a 
                    else b

list2BST :: Ord a => [a] -> Tree a
list2BST []     = EmptyT
list2BST (x:xs) = insertBST x (list2BST xs)


-- Ejercicio 4