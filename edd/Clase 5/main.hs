-- import Set
import Queue
import Stack

{-
Dados una lista y un conjunto, devuelve una lista con todos los elementos que pertenecen
al conjunto
-- -}
-- losQuePertenecen :: Eq a => [a] -> Set a -> [a]
-- losQuePertenecen [] _       = []
-- losQuePertenecen (x:xs) set = if belongs x set
--                                 then x : losQuePertenecen xs set
--                                 else losQuePertenecen xs set


-- -- Quita todos los elementos repetidos de la lista dada utilizando un conjunto como estructura auxiliar.
-- sinRepetidos :: Eq a => [a] -> [a]
-- sinRepetidos lista = setToList (agregarASet emptyS lista)

-- agregarASet :: Eq a => Set a -> [a] -> Set a -- Devuelve un set con los elementos de la lista agregados
-- agregarASet set []      = set
-- agregarASet set (x:xs)  = agregarASet (addS x set) xs

-- data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
--     deriving Show

-- -- miTree :: Tree (Set Int)
-- -- miTree = NodeT (agregarASet emptyS [1,2,3,4,10,6,7]) (NodeT (agregarASet emptyS [1,2,3,4,5,6,100]) (NodeT (agregarASet emptyS [1,2,3,4,5,6,90]) EmptyT (NodeT (agregarASet emptyS [1,2,34,4,5,6,7]) EmptyT EmptyT)) EmptyT) (NodeT (agregarASet emptyS [1,2,3,4,5,69,7]) (EmptyT) (EmptyT))

-- unirTodos :: Eq a => Tree (Set a) -> Set a
-- unirTodos EmptyT            = emptyS
-- unirTodos (NodeT set t1 t2) = unionS set (unionS (unirTodos t1) (unirTodos t2))


-- Queue

lengthQ :: Queue a -> Int
-- Cuenta la cantidad de elementos de la cola.
lengthQ que = if isEmptyQ que
                    then 0
                    else 1 + (lengthQ (dequeue que))

queueToList :: Queue a -> [a]
-- Dada una cola devuelve la lista con los mismos elementos,
-- donde el orden de la lista es el de la cola.
-- Nota: chequear que los elementos queden en el orden correcto.
queueToList que = if isEmptyQ que
                        then []
                        else (firstQ que) : (queueToList (dequeue que))  

-- unionQ :: Queue a -> Queue a -> Queue a
-- -- Inserta todos los elementos de la segunda cola en la primera
-- unionQ primerQ segundoQ = agregarListaAQueue (queueToList segundoQ) primerQ

unionQ :: Queue a -> Queue a -> Queue a
unionQ primerQue segundoQue = if isEmptyQ segundoQue
                                            then primerQue
                                            else unionQ (queue (firstQ segundoQue) primerQue) (dequeue segundoQue)

agregarListaAQueue :: [a] -> Queue a -> Queue a
agregarListaAQueue [] que = que
agregarListaAQueue xs que = queue (ultimoElementoDe xs) (agregarListaAQueue (sinUltimoElemento xs) que)

ultimoElementoDe :: [a] -> a -- Devuelve el último elemento de la lista. Debe de haber al menos un elemento
ultimoElementoDe [a]    = a
ultimoElementoDe (x:xs) = ultimoElementoDe xs

sinUltimoElemento :: [a] -> [a] -- Devuelve la lista sin su último elemento. Debe de tener al menos un elemento.
sinUltimoElemento [a]       = []
sinUltimoElemento (x:xs)    = x : (sinUltimoElemento xs)



-- STACK

-- Dada una lista devuelve una pila sin alterar el orden de los elementos
apilar :: [a] -> Stack a
apilar []        = emptyS
apilar (a:as)    = push a (apilar as)

desapilar :: Stack a -> [a]
-- Dada una pila devuelve una lista sin alterar el orden de los elementos
desapilar stack = if (isEmptyS stack)
                    then []
                    else (top stack) : (desapilar (pop stack))

insertarEnPos :: Int -> a -> Stack a -> Stack a
-- Dada una posicion válida en la stack y un elemento, ubica dicho elemento en dicha
-- posición (se desapilan elementos hasta dicha posición y se inserta en ese lugar).
insertarEnPos 0 a stack = push a stack
insertarEnPos n a stack = push (top stack) (insertarEnPos (n - 1) a (pop stack))