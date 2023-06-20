type Record a b = [(a,b)]

type Table a b = [ Record a b ]

data GTree a = GNode a [GTree a]

foldGT0 :: (a->[b]->b) -> GTree a -> b
foldGT0 h (GNode x ts) = h x (map (foldGT0 h) ts)
-- Una función que recibe un elemento y una lista de elementos.

foldGT1 :: (a->c->b) -> (b->c->c) -> c -> GTree a -> b
foldGT1 g f z (GNode x ts) = g x (foldr f z (map (foldGT1 g f z) ts))
-- Una función que recibe un elemento, y un tipo c para devolver el tipo de la función.
-- Una función que recibe un elemento y el resultado de la recursión. También, un caso base.

foldGT :: (a->c->b) -> ([b]->c) -> GTree a -> b
foldGT g k (GNode x ts) = g x (k (map (foldGT g k) ts))
-- Le paso una función que toma el elemento y la lista procesada
-- Le paso una función que toma una lista de los elementos y los convierte en el tipo que toma g
-- Es la mejor opción. Podemos hacer que k sea estructural.

sumGT0 = foldGT0 (\x ns -> x + sum ns)
sumGT' = foldGT (+) sum
sumGT1 = foldGT1 (+) (+) 0

select :: (Record a b -> Bool) -> Table a b -> Table a b
select = flip (foldr fr (const []))
            where fr r h p = if(p r) then r : (h p) else h p

project :: (a -> Bool) -> Table a b -> Table a b
project = flip (foldr fr (const []))
                where fr r h p = case (recordsWhich p r) of
                                    []      -> h p
                                    r       -> r : (h p)

recordsWhich :: (a -> Bool) -> Record a b -> Record a b
recordsWhich = flip (foldr fc (const []))
                    where fc c h p = if(p (fst c)) then c : (h p) else h p

conjunct :: (a -> Bool) -> (a -> Bool) -> a -> Bool
conjunct p q e = p e && q e

crossWith :: (a -> b -> c) -> [a] -> [b] -> [c]
crossWith = flip (foldr fl (\_ _ -> []))
                where fl x h p ys = (map (p x) ys) ++ (h p ys)

-- product :: Table a b -> Table a b -> Table a b

similar :: (Eq a, Eq b) => Record a b -> Record a b
similar = foldr fc []
            where fc c cs = if(elem c cs) then cs else c : cs