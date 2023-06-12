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


Prop.: ¿evalNExp . cfNExp = evalNExp?
Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿Para todo nexp :: NExp. evalNExp . cfNExp nexp = evalNExp nexp?
    Sea m :: Memoria. Sea nexp :: NExp ¿evalNExp . cfNExp nexp m = evalNExp nexp m?
    Por induccion en la estructura de nexp:

Caso base 1: nexp = Var x
    ¿evalNExp . cfNExp (Var x) m = evalNExp (Var x) m?

Caso base 2: nexp = NCte n
    ¿evalNExp . cfNExp (NCte n) m = evalNExp (NCte n) m?

Caso inductivo: nexp = NBOp nb e1 e2
    HI.1) ¡evalNExp . cfNExp e1 m = evalNExp e1 m!
    HI.2) ¡evalNExp . cfNExp e2 m = evalNExp e2 m!
    TI) ¿evalNExp . cfNExp (NBOp nb e1 e2) m = evalNExp (NBOp nb e1 e2) m?

Dem. caso base 1:
    LI:
    evalNExp . cfNExp (Var x) m
    = def. op. .
    evalNExp (cfNExp (Var x)) m
    = def. cfNExp.1
    evalNExp (Var x) m

    Se llega al lado derecho
    
Dem. caso base 2:
    LI: 
    evalNExp . cfNExp (NCte n) m
    = def. op. .
    evalNExp (cfNExp (NCte n)) m
    = def. cfNExp.2
    evalNExp (NCte n) m

    Se llega al lado derecho.

Dem caso inductivo:
    LI:
    evalNExp . cfNExp (NBOp nb e1 e2) m
    = def. op. .
    evalNExp (cfNExp (NBOp nb e1 e2)) m
    =
    evalNExp (simplificarNExp nbop (cfNExp exp1) (cfNExp exp2)) m
    = LEMA 1
    evalNbop nbop (evalNExp . cfNExp exp1 m) (evalNExp . cfNExp exp2 m)
    = HI.1 HI.2
    evalNbop nbop (evalNExp e1 m) (evalNExp e2 m)

    LD:
    evalNExp (NBOp nb e1 e2) m
    = df. evalNExp
    evalNbop nbop (evalNExp exp1 m) (evalNExp exp2 m)

LEMA 1:
¿evalNExp (simplificarNExp nbop exp1 exp2) m = evalNbop nbop (evalNExp exp1 m) (evalNExp exp2 m)?

-- Paja para desarrollar. Hay que probar por todos los casos de simplificarNExp == evalNbop