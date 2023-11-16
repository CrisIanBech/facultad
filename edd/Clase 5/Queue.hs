module Queue
    (Queue, emptyQ, isEmptyQ, queue, firstQ, dequeue)
    where

data Queue a = Q [a]
    deriving Show


emptyQ :: Queue a
-- Crea una cola vacía.
emptyQ = Q []

isEmptyQ :: Queue a -> Bool
-- Dada una cola indica si la cola está vacía.
isEmptyQ (Q []) = True
isEmptyQ _      = False

queue :: a -> Queue a -> Queue a
-- Dados un elemento y una cola, agrega ese elemento a la cola.
queue e (Q qs) = (Q (agregarAlFinal e qs))

agregarAlFinal :: a -> [a] -> [a]
agregarAlFinal a []     = [a]
agregarAlFinal a (x:xs) = x : (agregarAlFinal a xs)

firstQ :: Queue a -> a
-- Dada una cola devuelve el primer elemento de la cola.
firstQ (Q qs) = head qs

dequeue :: Queue a -> Queue a
-- Dada una cola la devuelve sin su primer elemento.
dequeue (Q qs) = (Q (tail qs))