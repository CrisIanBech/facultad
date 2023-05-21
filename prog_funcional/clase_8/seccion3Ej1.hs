data ExpA = Cte Int
    | Suma ExpA ExpA
    | Prod ExpA ExpA

evalExpA :: ExpA -> Int
evalExpA (Cte n) = n
evalExpA (Suma exp1 exp2) = evalExpA exp1 + evalExpA exp2
evalExpA (Prod exp1 exp2) = evalExpA exp1 * evalExpA exp2

simplificarExpA :: ExpA -> ExpA
simplificarExpA (Cte n) = n
simplificarExpA (Suma exp1 exp2) = sinSumaDeCero simplificarExpA exp1 simplificarExpA exp2
simplificarExpA (Prod exp1 exp2) = sinProdRedundante simplificarExpA exp1 simplificarExpA exp2

sinSumaDeCero :: ExpA -> ExpA -> ExpA
sinSumaDeCero (Cte 0) exp = exp
sinSumaDeCero exp (Cte 0) = exp
sinSumaDeCero exp1 exp2 = (Suma exp1 exp2)

sinProdRedundante :: ExpA -> ExpA -> ExpA
sinProdRedundante (Cte 0) exp = (Cte 0)
sinProdRedundante exp (Cte 0) = (Cte 0)
sinProdRedundante (Cte 1) exp = exp
sinProdRedundante exp (Cte 1) = exp
sinProdRedundante exp1 exp2 = Prod exp1 exp2 

cantidadDeSumaCero :: ExpA -> Int
cantidadDeSumaCero (Cte n) = 0
cantidadDeSumaCero (Prod exp1 exp2) = 0 + cantidadDeSumaCero exp1 + cantidadDeSumaCero exp2
cantidadDeSumaCero (Sum exp1 exp2) = unoSiSumaCeroCeroSino exp1 exp2 + cantidadDeSumaCero exp1 + cantidadDeSumaCero exp2

unoSiSumaCeroCeroSino (Cte 0) exp2 = 1
unoSiSumaCeroCeroSino exp1 (Cte 0) = 1

data ExpS = CteS N
    | SumS ExpS ExpS
    | ProdS ExpS ExpS

evalES :: ExpS -> Int
evalES (CteS n) = n
evalES (SumS exp1 exp2) = evalES exp1 + evalES exp2
evalES (ProdS exp1 exp2) = evalES exp1 * evalES exp2

es2ExpA :: ExpS -> ExpA
es2ExpA (CteS n) = (Cte n)
es2ExpA (SumS exp1 exp2) = (Suma es2ExpA exp1 es2ExpA exp2)
es2ExpA (ProdS exp1 exp2) = (Prod es2ExpA exp1 es2ExpA exp2)

expA2es :: ExpA -> ExpS
expA2es (Cte n) = (CteS n)
expA2es (Suma exp1 exp2) = (SumS expA2es exp1 expA2es exp2)
expA2es (Prod exp1 exp2) = (ProdS expA2es exp1 expA2es exp2)