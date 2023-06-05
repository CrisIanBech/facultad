data NExp = Var Variable
| NCte Int
| NBOp NBinOp NExp NExp
data NBinOp = Add | Sub | Mul | Div | Mod | Pow
type Variable = String

evalNExp :: NExp -> Memoria -> Int
evalNExp (Var v)                = \mem -> case cuantoVale v mem of
                                    Nothing -> error ("Variable "++v++" no definida")
                                    Just n -> n
evalNExp (NCte n)               = \mem -> n
evalNExp (NBOp nbop exp1 exp2)  = \mem -> evalNbop nbop (evalNExp exp1 mem) (evalNExp exp2 mem)

evalNbop :: NBinOp -> Int -> Int -> Int
evalNbop (Add) = (+)
evalNbop (Sub) = (-)
evalNbop (Mul) = (*)
evalNbop (Div) = (/)
evalNbop (Mod) = (%)
evalNbop (Pow) = (^)

cfNExp :: NExp -> NExp
cfNExp (Var v)               = (Var v)
cfNExp (NCte n)              = (NCte n)
cfNExp (NBOp nbop exp1 exp2) = simplificarNExp nbop (cfNExp exp1) (cfNExp exp2)

simplificarNExp :: NBinOp -> NExp -> NExp -> NExp
simplificarNExp nbinop (Cte n) (Cte m)  = (Cte (evalNbop nbinop n m))
simplificarNExp Mul exp1 exp2           = simplificarNExpMul exp1 exp2 
simplificarNExp Sum nexp1 nexp2         = simplificarNExpSum nexp1 nexp2
simplificarNExp Div nexp1 (Cte 1)       = nexp1

simplificarNExpMul :: NExp -> NExp -> NExp
simplificarNExpMul (Cte 1) nexp2    = nexp2
simplificarNExpMul (Cte 0) (Cte m)  = (Cte 0)
simplificarNExpMul nexp1 (Cte 1)    = nexp1
simplificarNExpMul nexp1 (Cte 0)    = (Cte 0)
simplificarNExpMul nexp1 nexp2      = NBOp Mul exp1 exp2

simplificarNExpSum :: NExp -> NExp -> NExp
simplificarNExpSum nexp1 (Cte 0) = nexp1
simplificarNExpSum (Cte 0) nexp2 = nexp2
simplificarNExpSum nexp1 nexp2   = NBOp Sum exp1 exp2



