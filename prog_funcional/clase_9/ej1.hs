data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum | Mul

evalEA :: EA -> Int
evalEA (Const n) = n
evalEA (BOp binOp exp1 exp2) = evalBinop binOp evalEA exp1 evalEA exp2

evalBinop :: BinOp -> Int -> Int -> Int
evalBinop (Sum) n1 n2 = (+)
evalBinop (Mul) n1 n2 = (*)

data ExpA = Cte Int
    | Suma ExpA ExpA
    | Prod ExpA ExpA

ea2ExpA :: EA -> ExpA
ea2ExpA (Const n) = (Cte n)
ea2ExpA (BOp binOp exp1 exp2) = binOp2ExpA binOp ea2ExpA exp1 ea2ExpA exp2

binOp2ExpA :: BinOp -> ExpA -> ExpA -> ExpA
binOp2ExpA (Sum) exp1 exp2 = Suma exp1 exp2
binOp2ExpA (Mul) exp1 exp2 = Prod exp1 exp2

expA2ea :: ExpA -> EA
expA2ea (Cte n) = (Const n)
expA2ea (Suma exp1 exp2) = Sum expA2ea exp1 expA2ea exp2
expA2ea (Prod exp1 exp2) = Mul expA2ea exp1 expA2ea exp2

