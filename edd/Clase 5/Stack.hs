module Stack
    (Stack, emptyS, isEmptyS, push, top, pop)
    where

data Stack a = S [a]
    deriving Show

emptyS :: Stack a
-- Crea una pila vacía.
emptyS = S []

isEmptyS :: Stack a -> Bool
-- Dada una pila indica si está vacía.
isEmptyS (S []) = True
isEmptyS _       = False

push :: a -> Stack a -> Stack a
-- Dados un elemento y una pila, agrega el elemento a la pila.
push x (S xs) = (S (x:xs))

top :: Stack a -> a
-- Dada un pila devuelve el elemento del tope de la pila. Debe de tener al menos un elemento.
top (S (x:xs)) = x 

pop :: Stack a -> Stack a
-- Dada una pila devuelve la pila sin el primer elemento.
pop (S (x:xs)) = (S xs)

