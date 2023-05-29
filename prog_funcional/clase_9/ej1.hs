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
expA2ea (Suma exp1 exp2) = BOp Sum expA2ea exp1 expA2ea exp2
expA2ea (Prod exp1 exp2) = BOp Mul expA2ea exp1 expA2ea exp2

b)

i.
    Prop.: ¿ea2ExpA . expA2ea = id?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿Para todo x :: ExpA. ea2ExpA . exp2A2ea x = id x?
    Sea n :: ExpA. Por ppio de inducción en la estructura de n,
    es equivalente demostrar que
    ¿ea2ExpA . exp2A2ea n = id n?

    Caso base: n = Cte n )
        ¿ea2ExpA . exp2A2ea (Cte n) = id (Cte n)?

    Caso inductivo 1: n = Suma ex1 ex2 )
        HI.1) ¡ea2ExpA . exp2A2ea ex1 = id ex1!
        HI.2) ¡ea2ExpA . exp2A2ea ex2 = id ex2!
        TI) ¿ea2ExpA . exp2A2ea (Suma ex1 ex2) = id (Suma ex1 ex2)?-
   
    Caso inductivo 2: n = Prod ex1 ex2 )
        HI.1) ¡ea2ExpA . exp2A2ea ex1 = id ex1!
        HI.2) ¡ea2ExpA . exp2A2ea ex2 = id ex2!
        TI) ¿ea2ExpA . exp2A2ea (Prod ex1 ex2) = id (Prod ex1 ex2)?

    Dem. caso base:

    LI:
    ea2ExpA . expA2ea (Cte n)
    = def. op. .
    ea2ExpA (expA2ea (Cte n))
    = def. expA2ea
    ea2ExpA (Const n)
    = def. ea2ExpA
    Cte n

    LD:
    id (Cte n)
    = def. id
    Cte n

    Se cumple para este caso.

    Dem. caso inductivo 1:

    LI:
    ea2ExpA . exp2A2ea (Suma ex1 ex2)
    = def. op. .
    ea2ExpA (exp2A2ea (Suma ex1 ex2))
    = def. exp2A2ea 
    ea2ExpA (Sum (expA2ea ex1) (expA2ea ex2))
    = def. ea2ExpA
    BOp binOp2ExpA Sum ea2ExpA (expA2ea ex1) ea2ExpA (expA2ea ex2)
    = def. op. .
    BOp binOp2ExpA Sum (ea2ExpA . expA2ea ex1) (ea2ExpA . expA2ea ex2)
    = HI.1 y HI.2
    BOp binOp2ExpA Sum (id ex1) (id ex2)
    = def. id
    BOp binOp2ExpA Sum ex1 ex2
    = def. binOp2ExpA.1
    Suma ex1 ex2

    LD:
    id (Suma ex1 ex2)
    = def. id
    Suma ex1 ex2

    
    


    