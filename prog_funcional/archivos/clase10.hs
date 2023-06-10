1. all p (​xs​++​ys​) ​=​ all p (reverse ​xs​) && all p (reverse ​ys​)
2. cantidadSumaCero . simplificarExpA = const 0
3. (reverseAL .) . flip consAL . reverseAL = snocAL

------------------------------------------------------------------

all p [] = True
all p (x:xs) = p x && all p xs

(++) [] ys = ys
(++) (x:xs) ys = x : (++) xs ys

reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

-- para todo p, xs e ys
all p (​xs ​++ ​ys​) ​=​ all p (reverse ​xs​) && all p (reverse ​ys​)

------------------------------------------------------------

-- Voy a demostrar por ind sobre xs

Caso base xs = []

¿ all p ([] ++ ys) = all p (reverse []) && all p (reverse ​ys​) ?

-- lado izq
all p ([] ++ ys)
= -- def ++
all p ys

-- lado der
all p (reverse []) && all p (reverse ​ys​)
= -- def reverse
all p [] && all p (reverse ys)
= -- def all
True && all p (reverse ys)
= -- def &&
all p (reverse ys)

------------------------------------------------------------

-- lema 1
-- para todo xs
all p xs = all p (reverse ​xs​)

Caso base xs = []

-- lado der
all p (reverse [])
=
all p []
-- lado izq

Caso ind xs = (z:zs)

HI) all p zs = all p (reverse zs)
TI) ¿ all p (z:zs) = all p (reverse (z:zs)) ?

-- lado izq
all p (z:zs)
= -- def all
p z && all p zs
= -- HI
p z && all p (reverse zs)

all p (reverse (z:zs))
= -- def reverse
all p (reverse zs ++ [z])
= -- lema 2
all p (reverse zs) && all p [z]
= -- varios pasos de all
all p (reverse zs) && p z
= -- conm. de &&
p z && all p (reverse zs)

-------------------------------------------------------------

Caso ind. xs = (z:zs)

HI) all p (zs ++ ys) = all p (reverse zs) && all p (reverse ​ys​)
TI) ¿ all p ((z:zs) ++ ys) = all p (reverse (z:zs)) && all p (reverse ​ys​) ?

-- lado izq
all p ((z:zs) ++ ys)
= -- def ++
all p (z : zs ++ ys)
= -- def all
p z && all p (zs ++ ys)
= -- HI)
p z && all p (reverse zs) && all p (reverse ​ys​)

-- lado der
all p (reverse (z:zs)) && all p (reverse ​ys​)
= -- def reverse
all p (reverse (reverse zs) ++ [z]) && all p (reverse ys)
= -- lema 2, all p (​xs ​++ ​ys​) = all p xs && all p ys, xs = reverse zs, ys = [z]
all p (reverse zs) && all p [z] && all p (reverse ys)
= -- def all
all p (reverse zs) && p z && all p [] && all p (reverse ys)
= -- def all
all p (reverse zs) && p z && True && all p (reverse ys)
= -- def &&
all p (reverse zs) && p z && all p (reverse ys)
= -- conmutatividad de &&
p z && all p (reverse zs) && all p (reverse ​ys​)

-------------------------------------------------------

-- lema 2
-- para todo xs, ys
all p (​xs ​++ ​ys​) = all p xs && all p ys

Caso base xs = []

¿ all p ([] ​++ ​ys​) = all p [] && all p ys ?

all p ([] ​++ ​ys​)
= -- def ++
all p ys

all p [] && all p ys
= -- def all
True && all p ys
= -- def &&
all p ys

--------------------------------------------

Caso ind xs = (z:zs)

HI) all p (zs ​++ ​ys​) = all p zs && all p ys
TI) ¿ all p ((z:zs) ​++ ​ys​) = all p (z:zs) && all p ys ?

-- lado izq
all p ((z:zs) ​++ ​ys​)
= -- def ++
all p (z : zs ​++ ​ys​)
= -- def all
p z && all p (zs ++ ys)
= -- HI
p z && all p zs && all p ys

-- lado der
all p (z:zs) && all p ys
= -- def all
p z && all p zs && all p ys

--------------------------------------------------------------

data ExpA = Cte Int
          | Suma ExpA ExpA
          | Prod ExpA ExpA

f (Cte n) = ...
f (Suma e1 e2) = ... f e1 ... f e2
f (Prod e1 e2) = ... f e1 ... f e2

evalExpA :: ExpA -> Int
evalExpA (Cte n)      = n
evalExpA (Suma e1 e2) = evalExpA e1 + evalExpA e2
evalExpA (Prod e1 e2) = evalExpA e1 * evalExpA e2

simplificarExpA :: ExpA -> ExpA
simplificarExpA (Cte n)      = Cte n
simplificarExpA (Suma e1 e2) = 
	simpSuma (simplificarExpA e1) (simplificarExpA e2)
simplificarExpA (Prod e1 e2) =
	simpProd (simplificarExpA e1) (simplificarExpA e2)

-- recibe expresiones simplificadas y simplifica segun reglas
-- de la suma
simpSuma (Cte 0) e2 = e2
simpSuma e1 (Cte 0) = e1
simpSuma e1 e2      = Suma e1 e2

simpProd (Cte 1) e2 = e2
simpProd e1 (Cte 1) = e1
simpProd (Cte 0) e2 = Cte 0
simpProd e1 (Cte 0) = Cte 0
simpProd e1 e2      = Prod e1 e2


cantidadDeSumaCero :: ExpA -> Int
cantidadDeSumaCero (Cte n)      = 0
cantidadDeSumaCero (Suma e1 e2) = 
	sumaCero e1 e2 +
	cantidadDeSumaCero e1 + 
	cantidadDeSumaCero e2 
cantidadDeSumaCero (Prod e1 e2) = 
	cantidadDeSumaCero e1 + cantidadDeSumaCero e2

sumaCero (Cte 0) e2 = 1
sumaCero e1 (Cte 0) = 1
sumaCero e1 e2      = 0

---------------------------------------------------

-- para todo e
cantidadSumaCero (simplificarExpA e) = const 0 e

-- const 0 e = 0

cantidadSumaCero (simplificarExpA e) = 0

-- Voy a demostrar por ind sobre e

Caso base e = Cte n

-- lado izq
cantidadSumaCero (simplificarExpA (Cte n))
= -- def simplificarExpA
cantidadSumaCero (Cte n)
= -- def cantidadSumaCero
0
-- lado der

Caso ind e = Suma e1 e2

HI.1) cantidadSumaCero (simplificarExpA e1) = 0
HI.2) cantidadSumaCero (simplificarExpA e2) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Suma e1 e2)) = 0 ?

cantidadSumaCero (simplificarExpA (Suma e1 e2))
= -- def simplificarExpA
cantidadSumaCero (simpSuma (simplificarExpA e1) (simplificarExpA e2))
= -- lema
cantidadSumaCero (simplificarExpA e1) + cantidadSumaCero (simplificarExpA e2)
= -- HI)
0 + 0
=
0

-------------------------------------------------------
-------------------------------------------------------
-- lema
-- para todo e1, e2
cantidadSumaCero (simpSuma e1 e2) 
= 
cantidadSumaCero e1 + cantidadSumaCero e2

-- Voy a demostrar por casos sobre e1 y e2

Caso e1 = Cte 0 y e2 cualquier otra expresión

¿
cantidadSumaCero (simpSuma (Cte 0) e2)
= 
cantidadSumaCero (Cte 0) + cantidadSumaCero e2
?

cantidadSumaCero (simpSuma (Cte 0) e2)
= -- def simpSuma
cantidadSumaCero e2

cantidadSumaCero (Cte 0) + cantidadSumaCero e2
= -- def cantidadSumaCero
0 + cantidadSumaCero e2
=
cantidadSumaCero e2

-----------------------------------------------

Caso e1 /= Cte 0 y e2 = Cte 0

¿
cantidadSumaCero (simpSuma e1 (Cte 0))
= 
cantidadSumaCero e1 + cantidadSumaCero (Cte 0)
?

cantidadSumaCero (simpSuma e1 (Cte 0))
= -- def simpSuma
cantidadSumaCero e1

cantidadSumaCero e1 + cantidadSumaCero (Cte 0)
= -- def cantidadSumaCero
cantidadSumaCero e1 + 0
=
cantidadSumaCero e1

-------------------------------------------------

Caso e1 /= Cte 0 y e2 /= Cte 0

¿
cantidadSumaCero (simpSuma e1 e2)
= 
cantidadSumaCero e1 + cantidadSumaCero e2
?

cantidadSumaCero (simpSuma e1 e2)
= -- def simpSuma
cantidadSumaCero (Suma e1 e2)
= -- def cantidadSumaCero
sumaCero e1 e2 +
cantidadDeSumaCero e1 + 
cantidadDeSumaCero e2 
= -- def sumaCero
0 +
cantidadDeSumaCero e1 + 
cantidadDeSumaCero e2 
=
cantidadDeSumaCero e1 + cantidadDeSumaCero e2 
-------------------------------------------------------
-------------------------------------------------------

Caso ind. e1 = Prod e1 e2

Caso e1 = Cte 0, y e2 cualquier otra expreion

HI.1) cantidadSumaCero (simplificarExpA (Cte 0)) = 0
HI.2) cantidadSumaCero (simplificarExpA e2) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Prod (Cte 0) e2)) = 0 ?

cantidadSumaCero (simplificarExpA (Prod e1 e2))
= -- def simplificarExpA
cantidadSumaCero (simpProd (simplificarExpA (Cte 0)) (simplificarExpA e2))
= -- def simplificarExpA
cantidadSumaCero (simpProd (Cte 0) (simplificarExpA e2))
= -- def simpProd
cantidadSumaCero (Cte 0)
= -- def cantidadSumaCero
0

Caso e1 /= Cte 0, y e2 = Cte 0

HI.1) cantidadSumaCero (simplificarExpA e1) = 0
HI.2) cantidadSumaCero (simplificarExpA (Cte 0)) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Prod e1 (Cte 0))) = 0 ?

-- Similar al anterior

Caso e1 = Cte 1, y e2 cualquier otra expresion

HI.1) cantidadSumaCero (simplificarExpA (Cte 1)) = 0
HI.2) cantidadSumaCero (simplificarExpA e2) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Prod (Cte 1) e2)) = 0 ?

cantidadSumaCero (simplificarExpA (Prod e1 e2))
= -- def simplificarExpA
cantidadSumaCero (simpProd (simplificarExpA (Cte 1)) (simplificarExpA e2))
= -- ?
cantidadSumaCero (simpProd (Cte 1) (simplificarExpA e2))
= -- def simpProd
cantidadSumaCero (simplificarExpA e2)
= -- HI.2)
0

Caso e1 /= Cte 1 y e2 = Cte 1

HI.1) cantidadSumaCero (simplificarExpA e1) = 0
HI.2) cantidadSumaCero (simplificarExpA (Cte 1)) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Prod e1 (Cte 1))) = 0 ?

-- Similar al anterior

---------------------------------------------------------------

Caso e1 /= Cte 0 y e1 /= Cte 1 y e2 /= 0 y e2 /= 1

HI.1) cantidadSumaCero (simplificarExpA e1) = 0
HI.2) cantidadSumaCero (simplificarExpA e2) = 0
TI) ¿ cantidadSumaCero (simplificarExpA (Prod e1 e2)) = 0 ?

cantidadSumaCero (simplificarExpA (Prod e1 e2))
= -- def simplificarExpA
cantidadSumaCero (simpProd (simplificarExpA e1) (simplificarExpA e2))
= -- lema
cantidadSumaCero (simplificarExpA e1) + cantidadSumaCero (simplificarExpA e2)
= -- HI.1) y HI.2)
0 + 0
=
0

-------------------------------------------------------

-- Lema

Si e1 /= Cte 0 y e1 /= Cte 1 y e2 /= 0 y e2 /= 1

entonces

cantidadSumaCero (simpProd e1 e2)
=
cantidadSumaCero e1 + cantidadSumaCero e2


cantidadSumaCero (simpProd e1 e2)
= -- def simpProd
cantidadSumaCero (Prod e1 e2)
= -- def cantidadSumaCero
cantidadSumaCero e1 + cantidadSumaCero e2

--------------------------------------------------------
--------------------------------------------------------

data AppList a = Single a
               | Append (AppList a) (AppList a)

consAL :: a -> AppList a -> AppList a
consAL x xs = Append (Single x) xs

snocAL :: AppList a -> a -> AppList a
snocAL xs x = Append xs (Single x)

reverseAL :: AppList a -> AppList a
reverseAL (Single x) = Single x
reverseAL (Append xs ys) =
	Append (reverseAL ys) (reverseAL xs)


-- principio de extensionalidad
((reverseAL .) . flip consAL . reverseAL) xs x = snocAL xs x

-- lado izq
((reverseAL .) . flip consAL . reverseAL) xs x
= -- def (.)
((reverseAL .) . flip consAL) (reverseAL xs) x
= -- def (.)
(reverseAL . flip consAL (reverseAL xs)) x
= -- def (.)
reverseAL (flip consAL (reverseAL xs) x)
= -- def flip
reverseAL (consAL x (reverseAL xs))
= -- def consAL
reverseAL (Append (Single x) (reverseAL xs))
= -- def reverseAL
Append (reverseAL (reverseAL xs)) (reverseAL (Single x))
= -- def reverseAL
Append (reverseAL (reverseAL xs)) (Single x)
= -- por demostracion anterior
Append xs (Single x)

-- lado der
snocAL xs x
= -- def snocAL
Append xs (Single x)


(.) f g x = f (g x)

((f .) . g . h) x y
=
((f .) . g) (h x) y
=
(f .) (g (h x)) y
=
(f . (g (h x))) y
=
f ((g (h x)) y)


(f .) g x
=
(f . g) x


-- voy reduciendo los puntos de derecha a izquierda
(f . g . h . w) x
=
(f . g . h) (w x)
=
(f . g) (h (w x))
=
f (g (h (w x)))

-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
-------------------------------------------------

data SetExp a = Singleton a
              | Empty
              | Union (SetExp a) (SetExp a)
              | Intersect (SetExp a) (SetExp a)

-- Convierte una expresión de conjuntos en una lista sin repetidos
evalSetExp :: SetExp a -> [a]

simpSetExp :: SetExp a -> SetExp a

¿ evalSetExp (simpSetExp e) = evalSetExp e ?

-- nota, usar:
sinRepetidos []     = []
sinRepetidos (x:xs) =
	if elem x (sinRepetidos xs)
	   then sinRepetidos xs
	   else x : sinRepetidos xs
