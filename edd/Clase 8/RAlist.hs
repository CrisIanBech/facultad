module RAlist
    (RAList, emptyRAL, isEmptyRAL, lengthRAL, get, minRAL, elems, remove, set, addAt)
    where
    
import Heap
import Map

data Lero a = L (Map Int a) 
    deriving Show

data RAList a = MkR Int (Map Int a) (Heap a)
    deriving Show

emptyRAL :: RAList a
-- Propósito: devuelve una lista vacía.
-- Eficiencia: O(1).
isEmptyRAL :: RAList a -> Bool
-- Propósito: indica si la lista está vacía.
-- Eficiencia: O(1).
lengthRAL :: RAList a -> Int
-- Propósito: devuelve la cantidad de elementos.
-- Eficiencia: O(1).
get :: Int -> RAList a -> a
-- Propósito: devuelve el elemento en el índice dado.
-- Precondición: el índice debe existir.
-- Eficiencia: O(log N).
minRAL :: Ord a => RAList a -> a
-- Propósito: devuelve el mínimo elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(1).
add :: Ord a => a -> RAList a -> RAList a
-- Propósito: agrega un elemento al final de la lista.
-- Eficiencia: O(log N)
elems :: Ord a => RAList a -> [a]
-- Propósito: transforma una RAList en una lista, respetando el orden de los elementos.
-- Eficiencia: O(N log N).
remove :: Ord a => RAList a -> RAList a
-- Propósito: elimina el último elemento de la lista.
-- Precondición: la lista no está vacía.
-- Eficiencia: O(N log N).
set :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: reemplaza el elemento en la posición dada.
-- Precondición: el índice debe existir.
-- Eficiencia: O(N log N).
addAt :: Ord a => Int -> a -> RAList a -> RAList a
-- Propósito: agrega un elemento en la posición dada.
-- Precondición: el índice debe estar entre 0 y la longitud de la lista.
-- Observación: cada elemento en una posición posterior a la dada pasa a estar en su posición siguiente.
-- Eficiencia: O(N log N).
-- Sugerencia: definir una subtarea que corra los elementos del Map en una posición a partir de una posición dada. Pasar
-- también como argumento la máxima posición posible.

emptyRAL = MkR 0 (emptyM) (emptyH)

isEmptyRAL (MkR 0 _ _)  = True
isEmptyRAL _            = False

lengthRAL (MkR n _ _) = n

get n (MkR _ indVal _) = case lookupM n indVal of
                            (Just m) -> m
                            Nothing -> error "No existe elemento en tal índice"

minRAL (MkR _ _ valuesOMin) = findMin valuesOMin

add el (MkR n map heap) = MkR (n + 1) (assocM n el map) (insertH el heap)

elems (MkR n indVal _) = elems' (n - 1) indVal

elems' :: Int -> Map Int a -> [a]
elems' (-1) _      = []
elems' n map    = case lookupM n map of 
                    Just m -> m : (elems' (n - 1) map)
                    Nothing -> error "No deberia de pasar"

remove (MkR n indVal valuesOMin) =  let el2Remove = cleanMaybe (lookupM (n - 1) indVal)
                                    in MkR (n - 1) (deleteM (n - 1) indVal) (removeFromHeap el2Remove valuesOMin)

cleanMaybe :: Maybe a -> a
cleanMaybe (Just n)  = n
cleanMaybe (Nothing) = error "No había elemento a limpiar"

removeFromHeap :: Ord a => a -> Heap a -> Heap a
removeFromHeap el heap = if el == (findMin heap)
                            then deleteMinH heap
                            else insertH (findMin heap) (removeFromHeap el (deleteMinH heap))

set indxEl2Replace m (MkR idx map heap) = let el2Replace = cleanMaybe (lookupM indxEl2Replace map) in
                                                MkR idx 
                                                    (assocM indxEl2Replace m map) 
                                                    (insertH m (removeFromHeap el2Replace heap))

addAt indx el (MkR n map heap) = MkR (n + 1) (setInIndxMap indx el map n) (insertH el heap)


setInIndxMap :: Int -> a -> Map Int a -> Int -> Map Int a
setInIndxMap index el map maxIndex = if maxIndex > index
                                            then setInIndxMap
                                                index
                                                el
                                                (assocM maxIndex (cleanMaybe (lookupM (maxIndex -1) map)) map)
                                                (maxIndex - 1)
                                            else assocM index el map