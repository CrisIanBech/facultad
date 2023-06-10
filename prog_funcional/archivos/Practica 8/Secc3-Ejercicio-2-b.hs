data ExpS = CteS N
			| SumS ExpS ExpS
			| ProdS ExpS ExpS

data ExpA = Cte Int
			| Suma ExpA ExpA
			| Prod ExpA ExpA


evalES :: ExpS -> Int
evalES (CteS n) = evalN n
evalES (SumS e1 e2) = evalES e1 + evalES e2
evalES (ProdS e1 e2) = evalES e1 * evalES e2

es2ExpA :: ExpS -> ExpA
es2ExpA (CteS n) = Cte (evalN n)
es2ExpA (SumS e1 e2) = Suma (es2ExpA e1) (es2ExpA e2)
es2ExpA (ProdS e1 e2) = Prod (es2ExpA e1) (es2ExpA e2)

expA2es :: ExpA -> ExpS
expA2es (Cte n) = CteS n
expA2es (Suma e1 e2) = SumS (expA2es e1) (expA2es e2)
expA2es (Prod e1 e2) = ProdS (expA2es e1) (expA2es e2)


b.i)

evalExpA . es2ExpA = evalES
por pio. de ext. para todo x :: ExpS, (evalExpA . es2ExpA) x = evalES x
por def de (.) evalExpA (es2ExpA x)

--Demuestro por induccion estructural sobre x. Elijo x = e

Caso base e = CteS n

evalExpA (es2ExpA (CteS n)) = evalES (CteS n)

--lado izq.
evalExpA (es2ExpA (CteS n))
= --def. de es2ExpA
evalExpA (Cte (evalN n))
= --def. de evalExpA
evalN n

--lado der.
evalES (CteS n)
= --def. de evalES
evalN n

------------------------------
Caso inductivo  e = SumS e1 e2

evalExpA (es2ExpA (SumS e1 e2)) = evalES (SumS e1 e2)
HI1) evalExpA (es2ExpA e1) = evalES e1
HI1) evalExpA (es2ExpA e2) = evalES e2
TI)¿evalExpA (es2ExpA (SumS e1 e2)) = evalES (SumS e1 e2)?

--lado izq.
evalExpA (es2ExpA (SumS e1 e2))
= --def. de es2ExpA
evalExpA (Suma (es2ExpA e1) (es2ExpA e2))
= --def. de evalExpA
(evalExpA (es2ExpA e1)) + (evalExpA (es2ExpA e2)) 
= --por HI 1 y 2
evalES e1 + evalES e2


--lado der.
evalES (SumS e1 e2)
= --def. de evalES
evalES e1 + evalES e2

----------------------------------------
Caso inductivo 2 e = ProdS e1 e2

evalExpA (es2ExpA (ProdS e1 e2)) = evalES (ProdS e1 e2)
HI1) evalExpA (es2ExpA e1) = evalES e1
HI1) evalExpA (es2ExpA e2) = evalES e2
TI)¿evalExpA (es2ExpA (ProdS e1 e2)) = evalES (ProdS e1 e2)?

---es igual pero con *