import PriorityQueue
import Map

list2PQ :: Ord a => [a] -> PriorityQueue a
list2PQ []      = emptyPQ
list2PQ (x:xs)  = insertPQ x (list2PQ xs)

pQ2List :: Ord a => PriorityQueue a -> [a]
pQ2List pq = if isEmptyPQ pq
                then []
                else (findMinPQ pq) : (pQ2List (deleteMinPQ pq))

heapSort :: Ord a => [a] -> [a]
heapSort list = pQ2List (list2PQ list)

valueM :: Eq k => Map k v -> [Maybe v]
valueM map = valuesDeMap map (keys map)

valuesDeMap :: Eq k => Map k v -> [k] -> [Maybe v]
valuesDeMap map []      = []
valuesDeMap map (k:ks)  = (lookupM k map) : (valuesDeMap map ks)

todasAsociadas :: Eq k => [k] -> Map k v -> Bool
todasAsociadas ks map = tieneTodasLasKey ks (keys map)

tieneTodasLasKey :: Eq k => [k] -> [k] -> Bool
tieneTodasLasKey [] ks      = False
tieneTodasLasKey (c:cs) ks  = (elem c ks) || (tieneTodasLasKey cs ks)

listToMap :: Eq k => [(k, v)] -> Map k v
listToMap []        = emptyM
listToMap (kv:kvs)  = assocM (keyDe kv) (valueDe kv) (listToMap kvs) 

valueDe :: Eq k => (k, v) -> v
valueDe (_, v) = v

keyDe :: (k, v) -> k
keyDe (k, _) = k

mapToList :: Eq k => Map k v -> [(k, Maybe v)]
mapToList map = mapToList' map (keys map)

mapToList' :: Eq k => Map k v -> [k] -> [(k, Maybe v)]
mapToList' map []       = []
mapToList' map (k:ks)   = (k, lookupM k map) : (mapToList' map ks)

agruparEq :: Eq k => [(k, v)] -> Map k [v]
agruparEq kvs = agruparPorKeys (keysDeKV kvs) kvs

keysDeKV :: Eq k => [(k, v)] -> [k]
keysDeKV []         = []
keysDeKV (kv:kvs)   = agregarSiNoEsElem (keyDe kv) (keysDeKV kvs)

agregarSiNoEsElem :: Eq k => k -> [k] -> [k]
agregarSiNoEsElem k ks  = if elem k ks
                            then ks
                            else (k:ks)

agruparPorKeys :: Eq k => [k] -> [(k, v)] -> Map k [v]
agruparPorKeys [] _         = emptyM
agruparPorKeys (k:ks) kvs   = assocM k (valuesDeKey k kvs) (agruparPorKeys ks kvs)

valuesDeKey :: Eq k => k -> [(k, v)] -> [v]
valuesDeKey k []          = []
valuesDeKey k (kv:kvs)    = if k == keyDe kv
                                then valueDe kv : (valuesDeKey k kvs)
                                else valuesDeKey k kvs

incrementar :: Eq k => [k] -> Map k Int -> Map k Int
incrementar ks map = incrementar' ks (keys map) map

incrementar' :: Eq k => [k] -> [k] -> Map k Int -> Map k Int
incrementar' keys [] _       = emptyM
incrementar' keys (k:ks) map = assocM' (sumarUnoEnKeys (k, limpiarMaybe (lookupM k map)) keys) (incrementar' keys ks map)

assocM' :: Eq k => (k, v) -> Map k v -> Map k v
assocM' (k, v) map = assocM k v map

limpiarMaybe :: Eq k => Maybe k -> k
limpiarMaybe (Nothing)  = error "No puede ser nothing"
limpiarMaybe (Just e)   = e

sumarUnoEnKeys :: Eq k => (k, Int) -> [k] -> (k, Int)
sumarUnoEnKeys (k, v) ks = if elem k ks
                            then (k, (v + 1))
                            else (k, v)

mergeMaps:: Eq k => Map k (Maybe v) -> Map k v -> Map k (Maybe v)
mergeMaps mapUno mapDos = mergeMaps' mapUno (mapToList mapDos)

mergeMaps':: Eq k => Map k v -> [(k, v)] -> Map k v
mergeMaps' map []       = map
mergeMaps' map (kv:kvs) = mergeMaps' (assocM (keyDe kv) (valueDe kv) map) kvs

indexar :: [a] -> Map Int a
-- Propósito: dada una lista de elementos construye un map que relaciona cada elemento con
-- su posición en la lista.
indexar as = indexar' 0 as

indexar' :: Int -> [a] -> Map Int a
indexar' n []       = emptyM
indexar' n (a:as)   = assocM n a (indexar' (n+1) as)

ocurrencias :: String -> Map Char Int
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.
ocurrencias ss = ocurrencias' ss (sinRepetidos ss)

ocurrencias' :: String -> String -> Map Char Int
ocurrencias' ss []      = emptyM
ocurrencias' ss (x:xs)  = assocM x (aparicionesEn x ss) (ocurrencias' ss xs)

aparicionesEn :: Eq a => a -> [a] -> Int
aparicionesEn a []      = 0
aparicionesEn a (x:xs)  = (unoSiCeroSino (a == x)) + (aparicionesEn a xs) 
    
unoSiCeroSino :: Bool -> Int
unoSiCeroSino True  = 1
unoSiCeroSino _     = 0

sinRepetidos :: Eq a => [a] -> [a]
sinRepetidos []         = []
sinRepetidos (x:xs)     = agregarSiNoEsElemento x (sinRepetidos xs) 

agregarSiNoEsElemento :: Eq a => a -> [a] -> [a]
agregarSiNoEsElemento a as  = if elem a as
                            then as
                            else (a:as)