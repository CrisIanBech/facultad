data NExp = Var Variable
            | NCte Int
            | NBOp NBinOp NExp NExp
data NBinOp = Add | Sub | Mul | Div | Mod | Pow
type Variable = String

data BExp = BCte Bool
            | Not BExp
            | And BExp BExp
            | Or BExp BExp
            | ROp RelOp NExp NExp

data RelOp = Eq  | NEq -- Equal y NotEqual
            | Gt | GEq -- Greater y GreaterOrEqual
            | Lt | LEq -- Lower y LowerOrEqual

evalBExp :: BExp -> Memoria -> Bool
evalBExp (BCte b)               = \mem -> b
evalBExp (Not b)                = \mem -> not (evalBExp b mem)
evalBExp (And b1 b2)            = \mem -> (&&) (evalBExp b1 mem) (evalBExp b2 mem)
evalBExp (Or b1 b2)             = \mem -> (||) (evalBExp b1) (evalBExp b2)
evalBExp (ROp rop nexp1 nexp2)  = \mem -> evalRop rop (evalNExp nexp1 mem) (evalNExp nexp2 mem)

evalRop :: RelOp -> Int -> Int -> Bool
evalRop (Eq)    = (==)
evalRop (NEq)   = (!=)
evalRop (Gt)    = (>)
evalRop (Geq)   = (>=)
evalRop (Lt)    = (<)
evalRop (LEq)   = (<=)

cfBExp :: BExp -> BExp
cfBExp (BCte b)               = BCTe b
cfBExp (Not b)                = cfNot (cdBExp be)
cfBExp (And b1 b2)            = cfAnd (cfBExp b1) (cfBExp b2)
cfBExp (Or b1 b2)             = cfOr (cfBExp b1) (cfBExp b2)
cfBExp (ROp rop nexp1 nexp2)  = cfROp rop (cfNExp nexp1) (cfNExp nexp2)

cfNot :: BExp -> BExp
cfNot (BCte b) = BCte (not b)
cfNot be = Not be

cfAnd :: BExp -> BExp -> BExp
cfAnd (BCte b) b2 = if(b) then b2 else BCte False
cfAnd b1 b2       = And b1 b2

cfOr :: BExp -> BExp -> BExp 
cfOr (BCte b1) (BCte b2) = if(b1) then (Bcte True) else b2
cfOr b1 b2               = Or b1 b2

cfROp :: RelOp -> NExp -> NExp -> BExp
cfROp rop (NCte n) (NCte m) = BCte (evalRop rop n m)
cfROp rop exp1 exp2         = ROp rop exp1 exp2

