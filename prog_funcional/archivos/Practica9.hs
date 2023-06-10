
data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

f EmptyT = ...
f (NodeT x ti td) =
	...
	... f ti
	... f td

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT x ti td) =
	x
	+ sumarT ti
	+ sumarT td

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT x ti td) =
	1
	+ sizeT ti
	+ sizeT td

anyT :: (a -> Bool) -> Tree a -> Bool
anyT p EmptyT = False
anyT p (NodeT x ti td) =
	   p x
	|| anyT p ti
	|| anyT p td

allT :: (a -> Bool) -> Tree a -> Bool
allT p EmptyT = True
allT p (NodeT x ti td) =
	   p x
	&& allT p ti
	&& allT p td

countT :: (a -> Bool) -> Tree a -> Int
countT p EmptyT = 0
countT p (NodeT x ti td) =
	   	  contarSi (p x)
		+ countT p ti
		+ countT p td

contarSi True  = 1
contarSi False = 0

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT x EmptyT EmptyT) = 1
countLeaves (NodeT x ti td) =
	countLeaves ti + countLeaves td

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT x ti td) =
	if isEmptyT ti && isEmptyT td
	   then 1
	   else countLeaves ti + countLeaves td

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT x ti td) =
	case (ti, td) of
		(EmptyT, EmptyT) -> 1
		_                -> countLeaves ti + countLeaves td

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT x ti td) =
	contarLeave x ti td (countLeaves ti) (countLeaves td)

contarLeave x EmptyT EmptyT ri rd = 1
contarLeave x ti td ri rd = ri + rd

heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT x ti td) =
	if heightT ti > heightT td
	   then 1 + heightT ti
	   else 1 + heightT td

heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT x ti td) =
	1 + max (heightT ti) (heightT td)

max x y =
	if x > y
	   then x
	   else y

inOrder :: Tree a -> [a]
inOrder EmptyT = []
inOrder (NodeT x ti td) =
	inOrder ti ++ [x] ++ inOrder td

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = ...
mirrorT (NodeT x ti td) =
	NodeT (mirrorT td) (mirrorT ti)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT = []
levelN 0 (NodeT x ti td) = [x]
levelN n (NodeT x ti td) =
	levelN (n-1) ti ++ levelN (n-1) td

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = []
listPerLevel (NodeT x ti td) =
	[x] :
	concatPerLevel (listPerLevel ti) (listPerLevel td)

concatPerLevel :: [[a]] -> [[a]] -> [[a]]
concatPerLevel [] [] = []
concatPerLevel [] ys = ys
concatPerLevel xs [] = xs
concatPerLevel (x:xs) (y:ys) =
	(x ++ y) : (concatPerLevel xs ys)

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT x ti td) =
	if heightT ti > heightT td
	   then x : ramaMasLarga ti
	   else x : ramaMasLarga td

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT x ti td) =
	if length (ramaMasLarga ti) > length (ramaMasLarga td)
	   then x : ramaMasLarga ti
	   else x : ramaMasLarga td

todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT x EmptyT EmptyT) = [[x]]
todosLosCaminos (NodeT x ti td) =
	agregarRaiz x (todosLosCaminos ti ++ todosLosCaminos td)

agregarRaiz x []     = []
agregarRaiz x (y:ys) =
	(x:y) : agregarRaiz x ys


--------------------------------------------------------

-- demo 1
-- para todo t .
countT (const True) t = sizeT t

-- voy a demostrar por inducción sobre t

Caso base t = EmptyT

countT (const True) EmptyT
= -- def countT
0

sizeT EmptyT
= -- def sizeT
0

Caso inductivo t = NodeT x ti td

HI.1) countT (const True) ti = sizeT ti
HI.2) countT (const True) td = sizeT td
TI) ¿ countT (const True) (NodeT x ti td) = sizeT (NodeT x ti td) ?

countT (const True) (NodeT x ti td)
= -- def countT
contarSi (const True x)
	+ countT (const True) ti
	+ countT (const True) td
= -- def const
contarSi True
	+ countT (const True) ti
	+ countT (const True) td
= -- def contarSi
1 + countT (const True) ti + countT (const True) td
= -- HI.1) y HI.2)
1 + sizeT ti + sizeT td

sizeT (NodeT x ti td)
= -- def sizeT
1 + sizeT ti + sizeT td

-------------------------------------------------------------

-- demo 2
-- para todo t
heightT t = length (ramaMasLarga t)

-- voy a demostrar por induccion sobre t

Caso base t = EmptyT

heightT EmptyT
= -- def heightT
0

length (ramaMasLarga EmptyT)
= -- def ramaMasLarga
length []
= -- def length
0


Caso ind. t = NodeT x ti td

HI.1) heightT ti = length (ramaMasLarga ti)
HI.2) heightT td = length (ramaMasLarga td)
TI) heightT (NodeT x ti td) = length (ramaMasLarga (NodeT x ti td))

heightT (NodeT x ti td)
= -- def heightT
if heightT ti > heightT td
   then 1 + heightT ti
   else 1 + heightT td
= -- HI.1) y HI.2)
if heightT ti > heightT td
   then 1 + length (ramaMasLarga ti)
   else 1 + length (ramaMasLarga td)

length (ramaMasLarga (NodeT x ti td))
= -- def ramaMasLarga
length (
	if heightT ti > heightT td
	   then x : ramaMasLarga ti
	   else x : ramaMasLarga td
)
= -- propidad dist. funcion sobre ramas de if
if heightT ti > heightT td
   then length (x : ramaMasLarga ti)
   else length (x : ramaMasLarga td)
= -- def length
if heightT ti > heightT td
   then 1 + length (ramaMasLarga ti)
   else 1 + length (ramaMasLarga td)

-----------------------------------------------

-- propiedad dist. funcion sobre ramas de if

f (if b then y else z) = if b then f y else f z

Caso b = True

f (if True then y else z)
=
f y

if True then f y else f z
=
f y

Caso b = False

f (if False then y else z)
=
f z

if False then f y else f z
=
f z

------------------------------

heightT :: Tree a -> Int
heightT EmptyT = 0
heightT (NodeT x ti td) =
	if heightT ti > heightT td
	   then 1 + heightT ti
	   else 1 + heightT td

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT x ti td) =
	if heightT ti > heightT td
	   then x : ramaMasLarga ti
	   else x : ramaMasLarga td

-------------------------------------------------------

data ExpA = Cte Int
		  | Suma ExpA ExpA
		  | Prod ExpA ExpA

f (Cte n)      = 
f (Suma e1 e2) = f e1 ... f e2
f (Prod e1 e2) = f e1 ... f e2

evalExpA :: ExpA -> Int
evalExpA (Cte n)      = n
evalExpA (Suma e1 e2) = evalExpA e1 + evalExpA e2
evalExpA (Prod e1 e2) = evalExpA e1 * evalExpA e2

simplificarExpA :: ExpA -> ExpA
simplificarExpA (Cte n)      = 
simplificarExpA (Suma e1 e2) = 
	simpSuma (simplificarExpA e1) (simplificarExpA e2)
simplificarExpA (Prod e1 e2) =
	simpProd (simplificarExpA e1) (simplificarExpA e2)

simpSuma (Cte 0) e2 = e2
simpSuma e1 (Cte 0) = e1
simpSuma e1 e2      = Suma e1 e2

simpProd (Cte 1) e2 = e2
simpProd e1 (Cte 1) = e1
simpProd (Cte 0) e2 = Cte 0
simpProd e1 (Cte 0) = Cte 0
simpProd e1 e2      = Prod e1 e2

---------------------------------------------------------

-- para todo e
evalExpA e = evalExpA (simplificarExpA e)

-- voy a demostrar por ind sobre e

Caso base e = Cte n

Caso ind e = Suma e1 e2

HI.1) evalExpA e1 = evalExpA (simplificarExpA e1)
HI.2) evalExpA e2 = evalExpA (simplificarExpA e2)
TI) ¿ evalExpA (Suma e1 e2) = evalExpA (simplificarExpA (Suma e1 e2)) ?

evalExpA (Suma e1 e2)
= -- def evalExpA
evalExpA e1 + evalExpA e2
= -- HI.1) y HI.2)
evalExpA (simplificarExpA e1) + evalExpA (simplificarExpA e2)

evalExpA (simplificarExpA (Suma e1 e2))
= -- def evalExpA
evalExpA (simpSuma (simplificarExpA e1) (simplificarExpA e2))
= -- por lema
evalExpA (simplificarExpA e1) + evalExpA (simplificarExpA e2)

-----------------------

-- lema
evalExpA e1 + evalExpA e2
=
evalExpA (simpSuma e1 e2)

Caso e1 = Cte 0

evalExpA (Cte 0) + evalExpA e2
= -- def evalExpA
0 + evalExpA e2
=
evalExpA e2

evalExpA (simpSuma (Cte 0) e2)
= -- def simpSuma
evalExpA e2

Caso e2 = Cte 0

evalExpA e1 + evalExpA (Cte 0)
= -- def evalExpA
evalExpA e1 + 0
=
evalExpA e1

evalExpA (simpSuma e1 (Cte 0))
= -- def simpSuma
evalExpA e1

Caso e1 /= Cte 0
     e2 /= Cte 0

-- lado der
evalExpA (simpSuma e1 e2)
= -- def simpSuma
evalExpA (Suma e1 e2)
= -- def evalExpA
evalExpA e1 + evalExpA e2
-- lado izq

----------------------------------------------------------------------

Caso ind e = Prod e1 e2

HI.1) evalExpA e1 = evalExpA (simplificarExpA e1)
HI.2) evalExpA e2 = evalExpA (simplificarExpA e2)
TI) ¿ evalExpA (Prod e1 e2) = evalExpA (simplificarExpA (Prod e1 e2)) ?

-- parecido al anterior pero lema con simpProd

-----------------------------------------------------------------------

cantidadDeSumaCero :: ExpA -> Int
cantidadDeSumaCero (Cte n)      = 0
cantidadDeSumaCero (Suma e1 e2) = 
		contarSumaCero e1 e2 + cantidadDeSumaCero e1 + cantidadDeSumaCero e2
cantidadDeSumaCero (Prod e1 e2) = cantidadDeSumaCero e1 + cantidadDeSumaCero e2

contarSumaCero (Cte 0) e2 = 1
contarSumaCero e1 (Cte 0) = 1
contarSumaCero e1 e2      = 0



