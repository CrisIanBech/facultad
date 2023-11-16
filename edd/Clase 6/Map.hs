module Map
    (Map, emptyM, assocM, lookupM, deleteM, keys)
    where

data Map k v = M [(k, v)]
    deriving Show


emptyM :: Map k v
-- Propósito: devuelve un map vacío
emptyM = M []

assocM :: Eq k => k -> v -> Map k v -> Map k v
-- Propósito: agrega una asociación clave-valor al map.
assocM k v map = aniadirAMap (k, v) map

aniadirAMap :: Eq k => (k, v) -> Map k v -> Map k v
aniadirAMap (k, m) (M kvs) = if contieneK' k kvs
                                then (M kvs)
                                else (M ((k, m) : kvs))


contieneK :: Eq k => k -> Map k v -> Bool
contieneK k (M kvs) = contieneK' k kvs

contieneK' :: Eq k => k -> [(k, v)] -> Bool
contieneK' k []          = False
contieneK' k (kv:kvs)    = (esIgualK k kv) || (contieneK' k kvs)

esIgualK :: Eq k => k -> (k, v) -> Bool
esIgualK k (key, value) = k == key

-- lookupM :: Eq k => k -> Map k v -> Maybe v
-- -- Propósito: encuentra un valor dado una clave.
-- lookupM key map = if contieneK key map
--                         then Just (findValueByKey key map)
--                         else Nothing

lookupM :: Eq k => k -> Map k v -> Maybe v
-- Propósito: encuentra un valor dado una clave.
lookupM key (M kvs) = findValueByKey key kvs


findValueByKey :: Eq k => k -> [(k, v)] -> Maybe v
findValueByKey k []         = Nothing 
findValueByKey k (kv:kvs)   = if k == (keyDe kv)
                                then Just (valueDe kv)
                                else findValueByKey k kvs


valueDe :: Eq k => (k, v) -> v
valueDe (_, v) = v

deleteM :: Eq k => k -> Map k v -> Map k v
-- Propósito: borra una asociación dada una clave.
deleteM key map = if contieneK key map
                    then delValueByKey key map
                    else map

delValueByKey :: Eq k => k -> Map k v -> Map k v
delValueByKey k (M kvs) = (M (delValueByKey' k kvs))

delValueByKey' :: Eq k => k -> [(k, v)] -> [(k, v)] --Elimina el value en una lista de tupla de Key Value. Debe de existir el par según el key dado.
delValueByKey' k []        = error "no se cumple la precondición"
delValueByKey' k (kv:kvs)  = if esIgualK k kv
                                then kvs
                                else kv : (delValueByKey' k kvs)

keys :: Map k v -> [k]
-- Propósito: devuelve las claves del map.
keys (M kvs) = elementosDeLista kvs

elementosDeLista :: [(k, v)] -> [k]
elementosDeLista []         = []
elementosDeLista (kv:kvs)   = keyDe kv : (elementosDeLista kvs)

keyDe :: (k, v) -> k
keyDe (k, _) = k

