​f [] = ...
f (x:xs) = ... f xs

length [] = 0
length (x:xs) = 1 + length xs

elem :: Eq a => a -> [a] -> Bool
elem e []     = False
elem e (x:xs) = e == x || elem e xs

any :: (a -> Bool) -> [a] -> Bool
any p []     = False
any p (x:xs) = p x || any p xs

concat :: [[a]] -> [a]
concat []     = []
concat (x:xs) = x ++ concat xs

(++) :: [a] -> [a] -> [a]
(++) []     ys = ys
(++) (x:xs) ys = x : (++) xs ys

reverse :: [a] -> [a]
reverse []     = []
reverse (x:xs) = reverse xs ++ [x]


-----------------------------------------------------
​
-- para todo xs, ys
length (​xs​ ++ ​ys​) ​=​ length ​xs​ + length ​ys

-- Voy a demostrar por inducción sobre cualquier ...

Caso base xs = []

¿length ([] ++ ​ys​) ​=​ length [] + length ​ys?

-- Trivial

Caso base xs = (z:zs)

HI) length (zs ++ ​ys​) ​=​ length zs + length ​ys
TI) length ((z:zs) ++ ​ys​) ​=​ length (z:zs) + length ​ys


length ((z:zs) ++ ​ys​)
=​ -- def (++)
length (z : (zs ++ ys))
= -- def length
1 + length (zs ++ ys)
= -- HI
1 + length zs + length ​ys

length (z:zs) + length ​ys
= -- def length
1 + length zs + length ​ys

--------------------------------------------------------

elem ​= ​any . (==)

-- principio de extensionalidad

-- para todo e
elem e = (any . (==)) e

-- que es equivalente a, por def de (.)

-- para todo e
elem e = any ((==) e)

-- principio de extensionalidad

-- para todo e, xs
elem e xs = any ((==) e) xs


-- voy a demostrar por ind est sobre cualquier xs


Caso base xs = []

¿ elem e [] = any ((==) e) [] ?

-- Trivial

Caso ind xs = (z:zs)

HI) elem e zs = any ((==) e) zs
TI) elem e (z:zs) = any ((==) e) (z:zs)

-- lado izq
elem e (z:zs)
= -- def elem
e == z || elem e zs
= -- HI
e == z || any ((==) e) zs

-- lado der
any ((==) e) (z:zs)
= -- def any
(==) e z || any ((==) e) zs
= -- usando otra forma de escribirlo
e == z || any ((==) e) zs


-------------------------------------

​any (elem ​x​) ​=​ elem ​x​ . concat

-- principio de extensionalidad

-- para todo xs :: [[a]]

any (elem x) xs = (elem x . concat) xs

-- que es equivalente a, por def (.)

any (elem x) xs = elem x (concat xs)

-- Voy a demostrar sobre ind est sobre xs

Caso base xs = []

¿ any (elem x) [] = elem x (concat []) ?

-- Trivial

Caso ind xs = z : zs

HI) any (elem x) zs = elem x (concat zs)
TI) any (elem x) (z:zs) = elem x (concat (z:zs))


any (elem x) (z:zs)
= -- def any
elem x z || any (elem x) zs
= -- HI
elem x z || elem x (concat zs)
= -- lema elem-||-++
elem x (z ++ concat zs)

elem x (concat (z:zs))
= -- def concat
elem x (z ++ concat zs)

------------------------------------------

-- lema elem-||-++

-- para todo xs, ys
elem x xs || elem x ys
= -- lema
elem x (xs ++ ys)

-- Voy a demostrar por ind sobre xs

Caso base xs = []

-- Trivial

Caso ind xs = (z:zs)

HI)
elem x zs || elem x ys
= -- lema
elem x (zs ++ ys)


TI)
¿
elem x (z:zs) || elem x ys
= -- lema
elem x ((z:zs) ++ ys)
?

-- lado izq
elem x (z:zs) || elem x ys
= -- def elem
x == z || elem x zs || elem x ys

-- lado der
elem x ((z:zs) ++ ys)
= -- def ++
elem x (z : zs ++ ys)
= -- def elem
x == z || elem x (zs ++ ys)
= -- HI
x == z || elem x zs || elem x ys

----------------------------------------

data N = Z | S N

evalN :: N -> Int​
evalN Z     = 0
evalN (S n) = 1 + evalN n

addN :: N -> N -> N
addN Z m     = m
addN (S n) m = S (addN n m)

prodN :: N -> N -> N
prodN Z     m = Z
prodN (S n) m = addN (prodN n m) m

int2N :: Int -> N
int2N 0 = Z
int2N n = S (int2N (n-1))

-- Tarea
​evalN (addN ​n1​ ​n2​) ​=​ evalN ​n1​ + evalN ​n2

evalN (prodN ​n1​ ​n2​) ​=​ evalN ​n1​ * evalN ​n2

int2N . evalN ​=​ id

evalN . int2N ​=​ id
