

 es2ExpA . expA2es = id
por ppio de ext. para todo x :: ExpA,  (es2ExpA . expA2es) x = id x  --- por def. de id = x
por (.) (es2ExpA . expA2es) x = es2ExpA (expA2es x)

--Demuestro por induccino estructural sobre x. Elijo x = e

Caso base e = Cte n

es2ExpA (expA2es (Cte n)) = (Cte n)

--lado der.
es2ExpA (expA2es (Cte n))
= --def. de expA2es
es2ExpA (CteS n)
= --def. de es2ExpA
Cte n
--llego al lado der.

--------------------------------------

Caso inductivo 1 e = Suma n m
HI1) es2ExpA (expA2es n) = n
HI2) es2ExpA (expA2es m) = m
TI) ¿es2ExpA (expA2es (Suma n m)) = (Suma n m)?

es2ExpA (expA2es (Suma n m)) = (Suma n m)

--lado izq.
es2ExpA (expA2es (Suma n m))
= --def. de expA2es
es2ExpA (SumS (expA2es n) (expA2es m))
= --def. de es2ExpA
Suma (es2ExpA (expA2es n)) (es2ExpA (expA2es m))
= -- por HI 1 y 2
Suma n m
--llego al lado derecho

------------------------------------

Caso inductivo 2 e = Prod n m
HI1) es2ExpA (expA2es n) = n
HI2) es2ExpA (expA2es m) = m
TI) ¿es2ExpA (expA2es (Prod n m)) = (Prod n m)?

es2ExpA (expA2es (Prod n m)) = (Prod n m)

--lado izq.
es2ExpA (expA2es (Prod n m))
= --def. de expA2es
es2ExpA (ProdS (expA2es n) (expA2es m))
= --def. de es2ExpA
Prod (es2ExpA (expA2es n)) (es2ExpA (expA2es m))
= -- por HI 1 y 2
Prod n m
--llego al lado derecho
