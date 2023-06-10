data BinTree a = Leaf a
				| Node (BinTree a) (BinTree a)

f (Leaf x) =
f (Node t1 t2) =
	f t1
	f t2

heightT :: BinTree a -> Int
heightT (Leaf x) = 0
heightT (Node t1 t2) =
	1 +
	heightT t1
	`max`
	heightT t2

countLeavesT :: BinTree a -> Int
countLeavesT (Leaf x) = 1
countLeavesT (Node t1 t2) =
	countLeavesT t1 +
	countLeavesT t2

sizeT :: BinTree a -> Int
sizeT (Leaf x) = 1
sizeT (Node t1 t2) =
	1 +
	sizeT t1 +
	sizeT t2 +
	sizeT q3 +
	sizeT q4

compress :: BinTree a -> BinTree a
compress (Leaf x) =
compress (Node t1 t2) =
	if t1 `equalQ` t2
	   then Leaf (elemQ t1)
	   else Node (compress t1)
	              (compress t2)

equalQ (Leaf x) (Leaf y) = x == y
equalQ (Node t11 t12) (Node t21 t22) =
	t11 `equalQ` t21 &&
	t12 `equalQ` t22 &&
equalQ _ _ = False

uncompress :: BinTree a -> BinTree a
uncompress (Leaf x) = Leaf x
uncompress (Node t1 t2 q3 q4) =
	where hm  = heightT tr1 `max` heightT tr2
		  tr1 =	uncompress t1
		  tr2 = uncompress t2
	      tr1' = if heightT tr1 < hm then expandir hm tr1 else tr1
	      tr2' = if heightT tr2 < hm then expandir hm tr2 else tr2

uncompress :: BinTree a -> BinTree a
uncompress (Leaf x) = Leaf x
uncompress (Node t1 t2 q3 q4) =
	Node (expandir 
		      (heightT (uncompress t1) `max` heightT (uncompress t2))
		      (uncompress t1))
 		 (expandir
		      (heightT (uncompress t1) `max` heightT (uncompress t2))
		      (uncompress t2))

-- para todo q.
-- heightT q <= heightT (expandir q)

-- para todo q.
-- Si heightT q = h
-- y heightT (expandir q) = h
-- entonces q = expandir q

expandir 0 q = q
expandir h (Leaf x) =
	Node (expandir (h-1) (Leaf x))
	     (expandir (h-1) (Leaf x))
expandir h (Node t1 t2) =
	Node (expandir (h-1) t1)
	      (expandir (h-1) t2)

---------------------------------------------

countLeavesQT (uncompress t) = 2 ^ heightQT t

-- voy a demostrar por ind sobre t

Caso base t = Leaf x

countLeavesQT (uncompress (Leaf x)) 
= -- def uncompress
countLeavesQT (Leaf x)
= -- def countLeavesQT
1

2 ^ heightQT (Leaf x)
= -- def heightQT
2 ^ 0
=
1

Caso ind t = NodeT t1 t2

HI) countLeavesQT (uncompress t1) = 2 ^ heightQT t1
    countLeavesQT (uncompress t2) = 2 ^ heightQT t2
TI) ¿ countLeavesQT (uncompress (NodeT t1 t2)) = 2 ^ heightQT (NodeT t1 t2) ?

-- lado izq
countLeavesQT (uncompress (NodeT t1 t2))
= -- def uncompress
countLeavesQT (Node tr1' tr2')
= -- def countLeavesQT
countLeavesQT (
	Node (expandir 
		      (heightT (uncompress t1) `max` heightT (uncompress t2))
		      (uncompress t1))
 		 (expandir
		      (heightT (uncompress t1) `max` heightT (uncompress t2))
		      (uncompress t2))
)
= -- def countLeavesQT
countLeavesQT (
				expandir 
		      		(heightT (uncompress t1) `max` heightT (uncompress t2))
		      		(uncompress t1)
		      )
+
countLeavesQT (
				expandir 
		      		(heightT (uncompress t1) `max` heightT (uncompress t2))
		      		(uncompress t2)
		      )
= 

-- dividir en casos

Caso 1: heightT (uncompress t1) >= heightT (uncompress t2)

countLeavesQT (
				expandir (heightT (uncompress t1))
		      	(uncompress t1)
		      )
+
countLeavesQT (
				expandir (heightT (uncompress t1)
		        (uncompress t2)
		      )
= -- lema 1

countLeavesQT (uncompress t1)
+
countLeavesQT (
				expandir (heightT (uncompress t1)
		        (uncompress t2)
		      )
= -- lema 2
countLeavesQT (uncompress t1)
+
countLeavesQT (uncompress t1)
= -- arit.
2 . countLeavesQT (uncompress t1)

-- lado der
2 ^ heightQT (NodeT t1 t2)
= -- def heightQT
2 ^ (1 + heightT t1 `max` heightT t2)
=
2 ^ (1 + heightT t1)
= -- HI)
2 ^ (1 + countLeavesQT (uncompress t1))
=
2 . countLeavesQT (uncompress t1)

Caso 2: heightT (uncompress t2) >= heightT (uncompress t1)

-- similar a lo anterior, pero con t2

-----------------------------------------------------

-- lema 1:
-- Prop. expandir (heighT t) t = t

-- lema 2:
-- Si heighT t1 >= heightT t2
   entonces countLeavesQT t1 + countLeavesQT (expandir (heighT t1) t2)
            = 2 . countLeavesQT t1
