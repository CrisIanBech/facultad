-- primera versión (ya vimos que hace que se repita mucho código)
-- data LineChange = Add Int (Maybe NBin)
--                 | Remove Int
--                 | Replace Int (Maybe NBin)
--                 | Duplicate Int
--                 | Replicate Int Int (Maybe NBin)

data DigBin = O | I

type NBin = [DigBin]

-- segunda versión
data LineChange = LC Int Change

data Change = Add (Maybe NBin)
            | Remove
            | Replace (Maybe NBin)
            | Duplicate
            | Replicate Int (Maybe NBin)

data BinFile = Line NBin BinFile
             | ELine BinFile
             | End

construct :: [LineChange] -> BinFile
construct [] = End
construct (lc:lcs) = constructLC lc (construct lcs)

constructLC :: LineChange -> BinFile -> BinFile
constructLC (LC n c) bf = constructLCN n c bf

constructLCN :: Int -> Change -> BinFile -> BinFile
constructLCN 0 c bf  = applyChange c bf
constructLCN n c End =
	if addsEL c
	   then ELine (constructLCN (n-1) c End)
	   else End
constructLCN n c (ELine bf)    = ELine (constructLCN (n-1) c bf)
constructLCN n c (Line  nb bf) = Line nb (constructLCN (n-1) c bf)

addsEL :: Change -> Bool
addsEL (Add _) = True
addsEL (Replicate _ _) = True
addsEL _ = False

applyChange :: Change -> BinFile -> BinFile
applyChange (Add mnb)         bf = applyAdd mnb bf
applyChange Remove            bf = applyRemove bf
applyChange (Replace mnb)     bf = applyReplace mnb bf
applyChange Duplicate         bf = applyDuplicate bf
applyChange (Replicate n mnb) bf = applyReplicate n mnb bf

mToLine :: Maybe NBin -> BinFile -> BinFile
mToLine Nothing bf = ELine bf
mToLine (Just nb) bf = Line nb bf

applyAdd :: Maybe NBin -> BinFile -> BinFile
applyAdd mnb bf   = mToLine mnb bf

applyRemove :: BinFile -> BinFile
applyRemove End = End
applyRemove (Line nb bf) = bf
applyRemove (ELine bf) = bf

applyReplace :: Maybe NBin -> BinFile -> BinFile
applyReplace mnb End = End
applyReplace mnb (Line _ bf) = mToLine mnb bf
applyReplace mnb (ELine bf) = mToLine mnb bf

applyDuplicate :: BinFile -> BinFile
applyDuplicate End = End
applyDuplicate (Line nb bf) = Line nb (Line nb bf)
applyDuplicate (ELine bf) = ELine (ELine bf)

applyReplicate :: Int -> Maybe NBin -> BinFile -> BinFile
applyReplicate n mnb bf = many n (applyAdd mnb) bf

many :: Int -> (a -> a) -> (a -> a)
many 0 f = id
many n f = f . many (n - 1) f

unconstruct :: BinFile -> [LineChange]
unconstruct End          = []
unconstruct (Line nb bf) = LC 0 (Add (Just nb)) : unconstruct bf
unconstruct (ELine bf)   = LC 0 (Add Nothing) : unconstruct bf

-- versión cuadrádica
compress :: BinFile -> [(Int, NBin)]
compress End          = []
compress (Line nb bf) = (0, nb) : map (overFst (+1)) (compress bf)
compress (ELine bf)   = map (overFst (+1)) (compress bf)

overFst :: (a -> a) -> (a, b) -> (a , b)
overFst f (x, y) = (f x , y)

-- versión lineal, pero sin recursión en compress' sino sobre compress''
-- compress' :: BinFile -> [(Int, NBin)]
-- compress' bf = compress'' bf 0

-- compress'' :: BinFile -> Int -> [(Int, NBin)]
-- compress'' End          n = []
-- compress'' (Line nb bf) n = (n, nb) : compress'' bf (n+1)
-- compress'' (ELine bf)   n = compress'' bf (n+1)

-- precondición: los elementos están ordenados de menor a mayor
-- por la primera componente del par
uncompress :: [(Int, NBin)] -> BinFile
uncompress [] = End
uncompress ((n, nb) : nbs) = putLineAt n nb (uncompress nbs)

-- precondición: el BinFile tiene menos de n lineas o las primeras n lineas del BinFile están vacías
-- (puede tener lineas con NBin pero posteriores a n)
putLineAt :: Int -> NBin -> BinFile -> BinFile
putLineAt 0 nb End = Line nb End
putLineAt 0 nb (ELine bf) = Line nb bf
putLineAt n nb End = ELine (putLineAt (n-1) nb End)
putLineAt n nb (ELine bf) = ELine (putLineAt (n-1) nb bf)

---

data Tree a = EmptyT
            | NodeT a (Tree a) (Tree a)

data Dir = L | R

count :: [Dir] -> Tree Int -> Int
count _ EmptyT = 0
count [] (NodeT n ti td) = n
count (d:ds) (NodeT n ti td) =
	case d of
		L  -> count ds ti
		R -> count ds td

inc :: [Dir] -> Tree Int -> Tree Int
inc [] EmptyT = NodeT 1 EmptyT EmptyT
inc [] (NodeT n ti td) = NodeT (n+1) ti td
inc (d:ds) EmptyT =
	case d of
		L -> NodeT 1 (inc ds EmptyT) EmptyT
		R -> NodeT 1 EmptyT (inc ds EmptyT)
inc (d:ds) (NodeT n ti td) =
	case d of
		L -> NodeT n (inc ds ti) td
		R -> NodeT n ti (inc ds td)

dec :: [Dir] -> Tree Int -> Tree Int
dec _ EmptyT = EmptyT
dec [] (NodeT n ti td) = join (n-1) ti td
dec (d:ds) (NodeT n ti td) =
	case d of
		L -> join n (dec ds ti) td
		R -> join n ti (dec ds td)

join :: Int -> Tree Int -> Tree Int -> Tree Int
join 0 EmptyT EmptyT = EmptyT
join n ti td = NodeT n ti td

countFrom :: [Dir] -> Tree Int -> Int
countFrom _ EmptyT = 0
countFrom [] (NodeT n ti td) = n + sumT ti + sumT td
countFrom (d:ds) (NodeT n ti td) =
	case d of
		L -> countFrom ds ti
		R -> countFrom ds td

sumT :: Tree Int -> Int
sumT EmptyT = 0
sumT (NodeT n ti td) = n + sumT ti + sumT td

lineFrequencies :: BinFile -> Tree Int
lineFrequencies End = EmptyT
lineFrequencies (Line nb bf) = inc (nbToDirs nb) (lineFrequencies bf)
lineFrequencies (ELine bf) = inc [] (lineFrequencies bf)

nbToDirs :: NBin -> [Dir]
nbToDirs [] = [L]
nbToDirs nb = map dbToDir nb

dbToDir :: DigBin -> Dir
dbToDir I = L
dbToDir O = R

-------------------------------------------------------------

-- -- para todo bf. construct (unconstruct bf) = bf

-- -- Sea bf cualquier BinFile

-- -- Demostración por inducción estructural

-- -- Caso base bf = End

-- -- ¿ construct (unconstruct End) = End ?

-- -- trivial

-- Caso ind bf = Line nb bf'

-- HI) construct (unconstruct bf') = bf'
-- TI) ¿ construct (unconstruct (Line nb bf')) = Line nb bf' ?

-- construct (unconstruct (Line nb bf'))
-- = -- def unconstruct
-- construct (LC 0 (Add (Just nb)) : unconstruct bf')
-- = -- def construct
-- constructLC (LC 0 (Add (Just nb))) (construct (unconstruct bf'))
-- = -- HI)
-- constructLC (LC 0 (Add (Just nb))) bf'
-- = -- def constructLC
-- constructLCN 0 (Add (Just nb)) bf'
-- = -- def constructLCN
-- applyChange (Add (Just nb)) bf'
-- = -- def applyChange
-- applyAdd (Just nb) bf'
-- = -- def applyAdd
-- mToLine (Just nb) bf'
-- = -- def mToLine
-- Line nb bf'

-- Caso ind bf = ELine bf'

-- -- trivial, similar a Line pero con Nothing y Eline