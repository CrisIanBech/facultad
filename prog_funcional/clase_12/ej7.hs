data GTree a = GNode a [GTree a]
            deriving (Show)

treePrueba :: GTree Int
treePrueba = GNode 1 [(GNode 1 []), (GNode 2 [GNode 5 [GNode 5 []], GNode 7 []]), GNode 3 []]

foldGT0 :: (a->[b]->b) -> GTree a -> b
foldGT0 h (GNode x ts) = h x (map (foldGT0 h) ts)
-- Una función que recibe un elemento y una lista de elementos.

foldGT :: (a->c->b) -> ([b]->c) -> GTree a -> b
foldGT g k (GNode x ts) = g x (k (map (foldGT g k) ts))
-- Le paso una función que toma el elemento y la lista procesada
-- Le paso una función que toma una lista de los elementos y los convierte en el tipo que toma g
-- Es la mejor opción. Podemos hacer que k sea estructural.

recrGT :: (a -> c -> [GTree a] -> b) -> ([b] -> [GTree a] -> c) -> GTree a -> b
recrGT g k (GNode x ts) = g x (k (map (recrGT g k) ts) ts) ts

foldGT1 :: (a->c->b) -> (b->c->c) -> c -> GTree a -> b
foldGT1 g f z (GNode x ts) = g x (foldr f z (map (foldGT1 g f z) ts))
-- Una función que recibe un elemento, y un tipo c para devolver el tipo de la función.
-- Una función que recibe un elemento y el resultado de la recursión. También, un caso base.

-- sumGT0 = foldGT0 (\x ns -> x + sum ns)
-- sumGT' = foldGT (+) sum
-- sumGT1 = foldGT1 (+) (+) 0

-- foldGT0 f (GNode x ts) = f x (map (foldGT0 f) ts)
-- foldGT f h (GNode x ts) = f x (h (map (foldGT f h) ts))
-- foldGT1 f h z (GNode x ts) = f x (foldr h z (map (foldGT1 f h z) ts))

-- c :: (a -> b) -> [b]

-- foldGT :: (a->c->b) -> ([b]->c) -> GTree a -> b
-- c :: (a -> d)
-- k :: [b] -> (a -> d)

mapGT :: (a -> b) -> GTree a -> GTree b
mapGT j = (foldGT f const)
            where f x h  = GNode (j x) (h j)

sumGT :: GTree Int -> Int
sumGT = foldGT (+) sum

sizeGT :: GTree a -> Int
sizeGT = foldGT (const (+1)) (sum)

heightGT :: GTree a -> Int
heightGT = foldGT (const (+1)) g
            where g [] = 0
                  g xs = maximum xs

preOrderGT :: GTree a -> [a]
preOrderGT = foldGT (:) (concat)

postOrderGT :: GTree a -> [a]
postOrderGT = foldGT (\x xs -> xs ++ [x]) (concat)

mirrorGT :: GTree a -> GTree a
mirrorGT = foldGT (GNode) (reverse) 

apply :: (a -> b) -> a -> b
apply f x = f x

-- foldGT :: (a->c->b) -> ([b]->c) -> GTree a -> b
-- foldGT g k (GNode x ts) = g x (k (map (foldGT g k) ts))

-- b :: Int
-- c :: (a -> Bool) -> Int

-- countByGT :: (a -> Bool) -> GTree a -> Int
-- countByGT = flip (foldGT g j)
--                 where g x h p = (if(p x) then 1 else 0) + h p
--                       j       = foldr (\n acc j -> n + (acc j)) (const 0)
-- countByGT p = foldGT (\x acc -> (if(p x) then 1 else 0) + acc) (sum)

partitionGT :: (a -> Bool) -> GTree a -> ([a], [a])
partitionGT p = foldGT g h
                    where g e (y, n) = if p e then (e:y, n) else (y, e:n)
                          h = foldr (\t ts -> ((fst t) ++ (fst ts), (snd t) ++ (snd ts))) ([], [])

-- zipWithGT :: (a->b->c) -> GTree a -> GTree b -> GTree c
-- zipWithGT = flip (foldGT g h)
--                 where g 

todosLosCaminosGT :: GTree a -> [[a]]
todosLosCaminosGT = foldGT (\c css -> map (c:) css) h
                        where h [] = [[]]
                              h xs = concat xs

-- ([[a]]->)
-- b :: Int 

-- foldGT :: (a->c->b) -> ([b]->c) -> GTree a -> b
-- b :: (Int -> d)
-- foldGT g k (GNode x ts) = g x (k (map (foldGT g k) ts))

nivelNGT :: GTree a -> Int -> [a]
nivelNGT =  foldGT g j
                where g x h 0       = [x]
                      g x h n       = h (n - 1)
                      j             = foldr (\x xs n -> x n ++ xs n) (const [])