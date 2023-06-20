data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
            deriving (Show)

treePrueba :: Tree Int
treePrueba = NodeT 1 (EmptyT) (NodeT 5 (NodeT 4 (NodeT 3 EmptyT EmptyT) EmptyT) (NodeT 2 (NodeT 999 EmptyT EmptyT) (NodeT 5 EmptyT EmptyT)))

apply :: (a -> b) -> a -> b
apply f x = f x

twice :: (a -> a) -> a -> a
twice f x = f (f x)

foldT :: b
            -> (a -> b -> b -> b)
            -> Tree a
            -> b
foldT e fn (EmptyT)         = e
foldT e fn (NodeT h t1 t2)  = fn h (foldT e fn t1) (foldT e fn t2)

mapT :: (a -> b) -> Tree a -> Tree b
mapT = flip (foldT (const EmptyT) fn)
            where fn e t1 t2 fm = NodeT (fm e) (t1 fm) (t2 fm) 

sumT :: Tree Int -> Int
sumT = foldT 0 fn
        where fn n sm1 sm2 = n + sm1 + sm2

sizeT :: Tree a -> Int
sizeT = foldT 0 fn 
            where fn _ s1 s2 = 1 + s1 + s2

heightT :: Tree a -> Int
heightT = foldT 0 fn
            where fn _ s1 s2 = 1 + max s1 s2

preOrder :: Tree a -> [a]
preOrder = foldT [] fn
            where fn e els ers = e : els ++ ers

inOrder :: Tree a -> [a]
inOrder = foldT [] fn
            where fn e els ers = els ++ [e] ++ ers

postOrder :: Tree a -> [a]
postOrder = foldT [] fn
            where fn e els ers = els ++ ers ++ [e]

mirrorT :: Tree a -> Tree a
mirrorT = foldT EmptyT fn
            where fn e tl tr = NodeT e tr tl

countByT :: (a -> Bool) -> Tree a -> Int
countByT = flip (foldT (const 0) fn)
            where fn e sm1 sm2 p = (sm1 p) + (sm2 p) + if(p e) then 1 else 0

partitionT :: (a -> Bool) -> Tree a -> ([a], [a])
partitionT = flip (foldT (const ([], [])) fn)
                where fn e h g p = let (xsy, xsn) = h p
                                        in let (ysy, ysn) = g p
                                            in let (zy, zn) = (xsy ++ ysy, xsn ++ ysn)
                                                in if(p e) then (e : zy, zn)
                                                    else (zy, e : zn) 

zipWithT :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
zipWithT = flip (foldT (const (const EmptyT)) fn)
                where fn _ _  _  m EmptyT           = EmptyT
                      fn e t1 t2 m (NodeT e' tl tr) = NodeT (m e e') (t1 m tl) (t2 m tr)

caminoMasLargo :: Tree a -> [a]
caminoMasLargo = foldT [] fn
                    where fn e t1 t2 = if(length t1 > length t2) then e : t1 else e : t2

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos = foldT [[]] fn
                    where fn e csl csr = map (e:) (csl ++ csr) 

todosLosNiveles :: Tree a -> [[a]]
todosLosNiveles = foldT [[]] fn
                    where fn e lsl lsr = [e] : (appendLevels lsl lsr)

appendLevels :: [[a]] -> [[a]] -> [[a]]
appendLevels [] yss            = yss
appendLevels xss []            = xss
appendLevels (xs:xss) (ys:yss) = (xs ++ ys) : (appendLevels xss yss) 

nivelN :: Tree a -> Int -> [a]
nivelN = foldT (const []) fn
            where fn e hl hr n = if(n == 0) then [e] else hl (n - 1) ++ hr (n - 1)

-- c.

recT :: b 
        -> (a -> b -> b -> Tree a -> Tree a -> b)
        -> Tree a
        -> b
recT z fn EmptyT            = z
recT z fn (NodeT e tl tr)   = fn e (recT z fn tl) (recT z fn tr) tl tr

insertT :: Ord a => a -> Tree a -> Tree a 
-- que describe el árbol resultante de insertar el elemento dado en el árbol dado, teniendo en
-- cuenta invariantes de BST.
insertT e = recT (NodeT e EmptyT EmptyT) fn 
            where fn x tl tr tl' tr' = if(e < x) then NodeT x tl tr' 
                                                 else NodeT x tl' tr 

caminoHasta :: Eq a => a -> Tree a -> [a]
caminoHasta e = recT [] fn 
                    where fn x tl tr tl' tr' = if(x == e) then [e]
                                                else if(elemT e tl') then x : tl else x : tr

elemT :: Eq a => a -> Tree a -> Bool
elemT e = foldT False fn
                where fn el tl tr = (e == el) || tl || tr