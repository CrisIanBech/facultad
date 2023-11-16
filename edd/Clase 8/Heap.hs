module Heap
    (Heap, emptyH, isEmptyH, findMin, insertH, deleteMinH)
    where

data Dir = Izq | Der
    deriving Show

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

data Heap a = H [Dir] (Tree a)
    deriving Show
 {- INV.REP.: en (PQ pos t)
 * t cumple ser un heap
 * t cumple ser un árbol lleno
 * pos indica el camino hasta la posición 
 de inserción en t -}

emptyH :: Heap a
isEmptyH :: Heap a -> Bool 
findMin :: Heap a -> a 
insertH :: Ord a => a -> Heap a -> Heap a 
deleteMinH :: Ord a => Heap a -> Heap a 

emptyH = H [] (EmptyT)

isEmptyH (H _ EmptyT) = True
isEmptyH _          = False

findMin (H _ tree) = findMin' tree

findMin' :: Tree a -> a 
findMin' (NodeT n _ _) = n
findMin' _             = error "El heap no tenía elementos"

insertH a (H pos elems) = H (nextPos pos) (insertIn (reverse pos) a elems)

insertIn :: Ord a => [Dir] -> a -> Tree a -> Tree a
insertIn [] a EmptyT                    = NodeT a EmptyT EmptyT
insertIn (Izq:pos) a (NodeT m ti td)    = flotarIzq m (insertIn pos a ti) td
insertIn (Der:pos) a (NodeT m ti td)    = flotarDer m ti (insertIn pos a td)

flotarIzq :: Ord a => a -> Tree a -> Tree a -> Tree a
flotarIzq a (NodeT m tii tdi) td = if a > m
                                    then NodeT m (NodeT a tii tdi) td
                                    else NodeT a (NodeT m tii tdi) td

flotarDer :: Ord a => a -> Tree a -> Tree a -> Tree a
flotarDer a ti (NodeT m tid tdd) = if a > m
                                    then NodeT m ti (NodeT a tid tdd)
                                    else NodeT a ti (NodeT m tid tdd)

nextPos :: [Dir] -> [Dir]
nextPos []          = [Izq]
nextPos (Izq:pos)   = Der:pos 
nextPos (Der:pos)   = Izq : (nextPos pos)

deleteMinH (H pos t) = H preP (deleteIn (reverse preP) t)
    where preP = prevPos pos

deleteIn :: Ord a => [Dir] -> Tree a -> Tree a
deleteIn [] (NodeT _ EmptyT EmptyT) = EmptyT
deleteIn pos t =
 let (m', NodeT _ ti' td') = splitAt' pos t
 in hundir m' ti' td'

hundir :: Ord a => a -> Tree a -> Tree a -> Tree a
hundir m EmptyT EmptyT = NodeT m EmptyT EmptyT
hundir m (NodeT mi tii tid) EmptyT =
    if m <= mi 
        then NodeT m (NodeT mi tii tid) EmptyT
        else NodeT mi (hundir m tii tid) EmptyT
hundir m (NodeT mi tii tid) (NodeT md tdi tdd) =
    if m <= mi && m <= md
        then NodeT m (NodeT mi tii tid) (NodeT md tdi tdd)
        else if mi <= md 
            then NodeT mi (hundir m tii tid) (NodeT md tdi tdd)
            else NodeT md (NodeT mi tii tid) (hundir m tdi tdd)


splitAt' :: [Dir] -> Tree a -> (a, Tree a)
-- splitAt' [] (NodeT el EmptyT EmptyT) = (el, EmptyT)
-- splitAt' (Izq:pos) (NodeT el ti td)  = let (el', ti') = splitAt' pos ti
--                                         in (el', (NodeT el ti' td))
-- splitAt' (Der:pos) (NodeT el ti td) = let (el', td') = splitAt' pos td
--                                         in (el', (NodeT el ti td'))

splitAt' [] (NodeT m EmptyT EmptyT) = (m, EmptyT)
splitAt' (Izq:pos) (NodeT m ti td) = 
                                        let (m', ti') = splitAt' pos ti
                                        in (m', NodeT m ti' td)
splitAt' (Der:pos) (NodeT m ti td) = 
                                    let (m', td') = splitAt' pos td
                                    in (m', NodeT m ti td')


prevPos :: [Dir] -> [Dir]
prevPos [Izq]       = []
prevPos (Der:pos)   = Izq : pos
prevPos (Izq:pos)   = Der : (prevPos pos)