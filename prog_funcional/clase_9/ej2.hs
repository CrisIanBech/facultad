data Arbol a b = Hoja b | Nodo a (Arbol a b) (Arbol a b)

cantidadDeHojas :: Arbol a b -> Int
cantidadDeHojas (Hoja h) = 1
cantidadDeHojas (Nodo n arb1 arb2) = cantidadDeHojas arb1 + cantidadDeHojas arb2

cantidadDeNodos :: Arbol a b -> Int
cantidadDeNodos (Hoja h) = 0
cantidadDeNodos (Nodo n arb1 arb2) = 1 + cantidadDeNodos arb1 + cantidadDeNodos arb2

cantidadDeConstructores :: Arbol a b -> Int
cantidadDeConstructores (Hoja h) = 1
cantidadDeConstructores (Nodo n arb1 arb2) = 1 + cantidadDeConstructores arb1 + cantidadDeConstructores arb2

data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum | Mul

ea2Arbol :: EA -> Arbol BinOp Int
ea2Arbol (Const n) = Hoja n
ea2Arbol (BOp binOp exp1 exp2) = Nodo binOp ea2Arbol exp1 binOp exp2

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT n t1 t2) = 1 + sizeT t1 + sizeT t2

anyT :: (a -> Bool) -> Tree a -> Bool
anyT p (EmptyT) = False
anyT p (NodeT n t1 t2) = p n || anyT p t1 || anyT p t2

countT :: (a -> Bool) -> Tree a -> Int
countT p EmptyT = 0
countT p (NodeT n t1 t2) = unoSiCeroSino p n + countT p t1 + countT p t2

unoSiCeroSino :: Bool -> Int
unoSiCeroSino True = 1
unoSiCeroSino False = 0

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT n t1 t2) = 1 + countLeaves t1 + countLeaves t2

heightT :: Tree a -> Int 
heightT EmptyT = 0
heightT (NodeT n t1 t2) = 1 + max heightT t1 heightT t2

inOrder :: Tree a -> [a]
inOrder EmptyT = []
inOrder EmptyT = (NodeT h t1 t2) = inOrder t1 ++ [h] ++ inOrder t2

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = []
listPerLevel (NodeT h t1 t2) = [h] ++ mergeFirstElement listPerLevel t1 listPerLevel t2

mergeFirstElement :: [[a]] -> [[a]] -> [[a]]
mergeFirstElement [] xs = xs
mergeFirstElement xs [] = xs
mergeFirstElement (x:xs) (y:ys) = [x, y] : [xs ++ ys]

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = EmptyT
mirrorT (NodeT h t1 t2) = (NodeT h mirrorT t2 mirrorT t1)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT = []
levelN 0 tree = tree
levelN n (NodeT h t1 t2) = levelN n - 1 t1 ++ levelN n - 1 t2

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT h t1 t2) = [h] ++ ramaMasLarga' ramaMasLarga t1 ramaMasLarga t2

ramaMasLarga' :: [a] -> [a] -> [a]
ramaMasLarga' t1 t2 = if(length t1 > length t2) 
                            then t1
                            else t2


todosLosCaminos :: Tree a -> [[a]] 
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT h t1 t2) = addToEveryList h t1 ++ addToEveryList h t2

addToEveryList :: a -> [[a]] -> [[a]]
addToEveryList e [] = [e]
addToEveryList e (xs:xss) = (e:xs) ++ addToEveryList e xss








