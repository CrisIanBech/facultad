data QuadTree a = LeafQ a
				| NodeQ (QuadTree a) (QuadTree a)
						(QuadTree a) (QuadTree a)

data Color = RGB Int Int Int

type Image = QuadTree Color

f (LeafQ x) =
f (NodeQ q1 q2 q3 q4) =
	f q1
	f q2
	f q3
	f q4

heightQT :: QuadTree a -> Int
heightQT (LeafQ x) = 0
heightQT (NodeQ q1 q2 q3 q4) =
	1 +
	heightQT q1
	`max`
	heightQT q2
	`max`
	heightQT q3
	`max`
	heightQT q4

countLeavesQT :: QuadTree a -> Int
countLeavesQT (LeafQ x) = 1
countLeavesQT (NodeQ q1 q2 q3 q4) =
	countLeavesQT q1 +
	countLeavesQT q2 +
	countLeavesQT q3 +
	countLeavesQT q4

sizeQT :: QuadTree a -> Int
sizeQT (LeafQ x) = 1
sizeQT (NodeQ q1 q2 q3 q4) =
	1 +
	sizeQT q1 +
	sizeQT q2 +
	sizeQT q3 +
	sizeQT q4

compress :: QuadTree a -> QuadTree a
compress (LeafQ x) =
compress (NodeQ q1 q2 q3 q4) =
	if q1 `equalQ` q2 `equalQ` q3 `equalQ` q4
	   then Leaf (elemQ q1)
	   else NodeQ (compress q1)
	              (compress q2)
	              (compress q3)
	              (compress q4)

equalQ (Leaf x) (Leaf y) = x == y
equalQ (NodeQ q11 q12 q13 q14) (NodeQ q21 q22 q23 q24) =
	q11 `equalQ` q21 &&
	q12 `equalQ` q22 &&
	q13 `equalQ` q23 &&
	q14 `equalQ` q24
equalQ _ _ = False

uncompress :: QuadTree a -> QuadTree a
uncompress (LeafQ x) = LeafQ x
uncompress (NodeQ q1 q2 q3 q4) =
	where hm  = heightQT qr1 `max` heightQT qr2 `max` heightQT qr3 `max` heightQT qr4
		  qr1 =	uncompress q1
		  qr2 = uncompress q2
		  qr3 = uncompress q3
		  qr4 = uncompress q4
	      qr1' = if heightQT qr1 < hm then expandir hm qr1 else qr1
	      qr2' = if heightQT qr2 < hm then expandir hm qr2 else qr2
	      qr3' = if heightQT qr3 < hm then expandir hm qr3 else qr3
	      qr4' = if heightQT qr4 < hm then expandir hm qr4 else qr4

uncompress :: QuadTree a -> QuadTree a
uncompress (LeafQ x) = LeafQ x
uncompress (NodeQ q1 q2 q3 q4) =
	where hm  = heightQT qr1 `max` heightQT qr2 `max` heightQT qr3 `max` heightQT qr4
		  qr1 =	uncompress q1
		  qr2 = uncompress q2
		  qr3 = uncompress q3
		  qr4 = uncompress q4
	      qr1' = expandir hm qr1
	      qr2' = expandir hm qr2
	      qr3' = expandir hm qr3
	      qr4' = expandir hm qr4

-- para todo q.
-- heightQT q <= heightQT (expandir q)

-- para todo q.
-- Si heightQT q = h
-- y heightQT (expandir q) = h
-- entonces heightQT q = heightQT (expandir q)

expandir 0 q = q
expandir h (Leaf x) =
	NodeQ (expandir (h-1) (Leaf x))
	      (expandir (h-1) (Leaf x))
	      (expandir (h-1) (Leaf x))
	      (expandir (h-1) (Leaf x))
expandir h (NodeQ q1 q2 q3 q4) =
	NodeQ (expandir (h-1) q1)
	      (expandir (h-1) q2)
	      (expandir (h-1) q3)
	      (expandir (h-1) q4)

render :: Image -> Int -> Image
render q 0 = q
render (LeafQ x) n = 
	NodeQ
	  (render (LeafQ x) (n-1))
	  (render (LeafQ x) (n-1))
	  (render (LeafQ x) (n-1))
	  (render (LeafQ x) (n-1))
render (NodeQ q1 q2 q3 q4) n =
	NodeQ
	  (render q1 (n-1))
	  (render q2 (n-1))
	  (render q3 (n-1))
	  (render q4 (n-1))
