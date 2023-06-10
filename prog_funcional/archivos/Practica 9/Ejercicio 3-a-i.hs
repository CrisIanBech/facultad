data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT n t1 t2) = n + (sumarT t1) + (sumarT t2)

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT n t1 t2) = 1 + (sizeT t1) + (sizeT t2)

anyT :: (a -> Bool) -> Tree a -> Bool
anyT p EmptyT = False
anyT p (NodeT n t1 t2) = p n || anyT p (t1) || anyT p (t2)

countT :: (a -> Bool) -> Tree a -> Int
countT p EmptyT = 0
countT p (NodeT n t1 t2) = unoSiCumple (p n) + countT p t1 + countT p t2

            unoSiCumple :: Bool -> Int
            unoSiCumple True = 1
            unoSiCumple False = 0

countLeaves :: Tree a -> Int
countLeaves EmptyT = 1
countLeaves (NodeT n t1 t2) = countLeaves t1 + countLeaves t2

heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT n t1 t2) = 1 + max (heightT t1) (heightT t2)

inOrder :: Tree a -> [a]
inOrder  EmptyT = []
inOrder (NodeT x t1 t2) = inOrder t1 ++ [x] ++ inOrder t2

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = [[]]
listPerLevel (NodeT x t1 t2) = [x] : appendPerLevel (listPerLevel t1 listPerLevel t2))

        appendPerLevel :: [a] -> [a] -> [a]
        appendPerLevel [] ys = ys
        appendPerLevel xs [] = xs
        appendPerLevel (x:xs) (y:ys) = (x++y) : appendPerLevel xs ys

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = EmptyT
mirrorT (NodeT x t1 t2) = NodeT x (mirrorT t2) (mirrorT t1)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT = []
levelN 0 (NodeT x t1 t2) = [x]
levelN n (NodeT x t1 t2) = levelN (n-1) t1 ++ levelN (n-1) t2

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT x t1 t2) = x : mayorRama (ramaMasLarga t1) (ramaMasLarga t2)
            --(asi devuelvo ya la lista donde voy a appendear)

            mayorRama ::  [a] ->  [a] -> Tree a
            mayorRama a1 a2 = if length a1 > length a2
                                            then a1
                                            else a2


todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT x t1 t2) = map (x:) (x: todosLosCaminos t1 ++ todosLosCaminos t2) 





