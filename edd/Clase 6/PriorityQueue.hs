module PriorityQueue
    (PriorityQueue, emptyPQ, isEmptyPQ, insertPQ, findMinPQ, deleteMinPQ)
    where

data PriorityQueue a = P [a]
    deriving Show

emptyPQ :: PriorityQueue a
-- Propósito: devuelve una priority queue vacía.
emptyPQ = (P [])

isEmptyPQ :: PriorityQueue a -> Bool
-- Propósito: indica si la priority queue está vacía.
isEmptyPQ (P [])    = True
isEmptyPQ _         = False

insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
-- Propósito: inserta un elemento en la priority queue.
insertPQ a (P xs) = (P (aniadirPQ a xs))

aniadirPQ :: Ord a => a -> [a] -> [a]
aniadirPQ a []       = [a]
aniadirPQ a (x:xs)   = if a < x
                        then a : x : xs
                        else x : (aniadirPQ a xs)

findMinPQ :: Ord a => PriorityQueue a -> a
-- Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
-- Precondición: parcial en caso de priority queue vacía.
findMinPQ (P xs) = head xs

deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a
-- Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
-- Precondición: parcial en caso de priority queue vacía.
deleteMinPQ (P xs) = (P (tail xs))