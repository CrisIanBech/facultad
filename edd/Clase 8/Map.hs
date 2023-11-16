module Map
    (Map, emptyM, assocM, lookupM, deleteM, keys)
    where

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

data Map k v = M (Tree (k, v))
    deriving Show
    -- * t cumple ser un BST
    -- * cada nodo de t tiene key única.


emptyM :: Map k v
-- Costo: O(1).

assocM :: Ord k => k -> v -> Map k v -> Map k v

assocM' :: Ord k => k -> v -> Tree (k, v) -> Tree (k, v)
-- Costo: O(log n).
-- Propósito: agrega una asociación clave-valor al map.

lookupM :: Ord k => k -> Map k v -> Maybe v

lookupM' :: Ord k => k -> Tree (k, v) -> Maybe v

deleteM :: Ord k => k -> Map k v -> Map k v
-- Costo: O(log n).

deleteM' :: Ord k => k -> Tree (k, v) -> Tree (k, v)
-- Costo: O(log n).

keys :: Map k v -> [k]
-- Costo: O(n).

emptyM = M EmptyT

assocM k v (M tree) = (M (assocM' k v tree))

assocM' k v EmptyT           = NodeT (k, v) EmptyT EmptyT
assocM' k v (NodeT kv ti td) =  let keyN = keyDe kv
                                in if k == keyN
                                    then (NodeT (k, v) ti td)
                                    else if k < keyN
                                        then (NodeT kv (assocM' k v ti) td) 
                                        else (NodeT kv ti (assocM' k v td))


keyDe :: (k, v) -> k
keyDe (k, v) = k

valueDe :: (k, v) -> v
valueDe (k, v) = v

lookupM k (M tree) = lookupM' k tree

lookupM' k EmptyT             = Nothing
lookupM' k (NodeT kv ti td)   = let keyN = keyDe kv
                                in if k == keyN
                                  then (Just (valueDe kv))
                                  else if keyN < k
                                      then lookupM' k td
                                      else lookupM' k ti


deleteM k (M tree) = (M (deleteM' k tree))

deleteM' k EmptyT           = EmptyT
deleteM' k (NodeT kv ti td) = let keyN = keyDe kv
                                in if k == keyN
                                    then rearmarBST ti td
                                    else if keyN < k
                                        then (NodeT kv ti (deleteM' k td))
                                        else (NodeT kv (deleteM' k ti) td)

rearmarBST :: Tree a -> Tree a -> Tree a
rearmarBST EmptyT td    = td
rearmarBST ti td        = NodeT (maxDeBST ti) (delMaxBST ti) td

maxDeBST :: Tree a -> a -- El árbol no está vacío y es un BST
maxDeBST (NodeT el _ EmptyT)    = el
maxDeBST (NodeT el ti td)       = maxDeBST td

delMaxBST :: Tree a -> Tree a -- El árbol no está vacío y es un BST
delMaxBST (NodeT el ti EmptyT)  = ti
delMaxBST (NodeT el ti td)      = (NodeT el ti (delMaxBST td)) 

keys (M tree) = keys' tree

keys' :: Tree (k, v) -> [k]
keys' EmptyT            = []
keys' (NodeT el ti td)  = (keyDe el) : (keys' ti) ++ (keys' td)