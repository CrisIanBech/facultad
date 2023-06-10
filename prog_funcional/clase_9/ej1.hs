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
ea2ExpA (BOp binOp exp1 exp2) = binOp2ExpA binOp (ea2ExpA exp1) (ea2ExpA exp2)

binOp2ExpA :: BinOp -> ExpA -> ExpA -> ExpA
binOp2ExpA (Sum) exp1 exp2 = Suma exp1 exp2
binOp2ExpA (Mul) exp1 exp2 = Prod exp1 exp2

expA2ea :: ExpA -> EA
expA2ea (Cte n) = (Const n)
expA2ea (Suma exp1 exp2) = BOp Sum (expA2ea exp1) (expA2ea exp2)
expA2ea (Prod exp1 exp2) = BOp Mul (expA2ea exp1) (expA2ea exp2)

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

    Dem. caso inductivo 2:

    LI:
    ea2ExpA . exp2A2ea (Prod ex1 ex2)
    = def. op. .
    ea2ExpA (exp2A2ea (Prod ex1 ex2))
    = def. exp2A2ea.3
    ea2ExpA (Bop Prod (expA2ea ex1) (expA2ea ex2))
    = def. ea2ExpA.3
    BOp binOp2ExpA Mul ea2ExpA (expA2ea ex1) ea2ExpA (expA2ea ex2)
    = def. op. .
    BOp binOp2ExpA Mul (ea2ExpA . expA2ea ex1) (ea2ExpA . expA2ea ex2)
    = HI.1 y HI.2
    BOp binOp2ExpA Mul (id ex1) (id ex2)
    = def. id
    BOp binOp2ExpA Mul ex1 ex2
    = def. binOp2ExpA.2
    Prod ex1 ex2

    LD:
    id (Prod ex1 ex2)
    = def. id
    Prod ex1 ex2
    
    Se cumple para los 3 casos. Por lo tanto, la propiedad es válida.

    ii.
    Prop.: ¿expA2ea . ea2ExpA = id?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿Para todo x :: ea. expA2ea . ea2ExpA X = id X?
    Sea n :: EA. Por ppio de inducción en la estructura de n,
    es equivalente demostrar que
    ¿expA2ea . ea2ExpA n = id n?

    Caso base: n = Const n )
        ¿expA2ea . ea2ExpA (Const n) = id (Const n)?

    Caso inductivo: n = (BOp bop e1 e2)
        HI.1) ¡expA2ea . ea2ExpA e1 = id e1!
        HI.2) ¡expA2ea . ea2ExpA e2 = id e2!
        TI) ¿expA2ea . ea2ExpA (BOp bop e1 e2) = id (BOp bop e1 e2)?

    Dem. caso base:
        LI:
        expA2ea . ea2ExpA (Const n)
        = def. op. .
        expA2ea (ea2ExpA (Const n))
        = def. ea2ExpA.1
        expA2ea (Cte n)
        = def. expA2ea
        Const n

        LD:
        id (Const n)
        = def. id
        Const n

    Dem. caso inductivo:
        LI:
        expA2ea . ea2ExpA (BOp bop e1 e2)
        = def. op. .
        expA2ea (ea2ExpA (BOp bop e1 e2))
        = def. ea2ExpA
        expA2ea (binOp2ExpA bop (ea2ExpA e1) (ea2ExpA e2))
        = Lema distribucion expA2ea de binOp2ExpA 
        Bop bop (expA2ea . ea2ExpA e1) (expA2ea . ea2ExpA e2)
        = HI.1 y HI.2
        Bop bop e1 e2

        LD:
        id (BOp bop e1 e2)
        = def. id
        BOp bop e1 e2

        LEMA: distribucion expA2ea de binOp2ExpA
        Prop.: ¿expA2ea (binOp2ExpA bop e1 e2) = Bop bop (expA2ea e1) (expA2ea e2)?
        Dem.: Por análisis de caso sobre e1:
        
        Dem. caso 1: e1 :: Cte n
        Según análisis de casos:
            Caso 1.1: bop = Sum
            expA2ea (binOp2ExpA Sum (Cte n) e2)
            = def. binOp2ExpA
            expA2ea (Suma (Cte n) exp2)
            = def. expA2ea.2
            BOp Sum (Const n) (expA2ea exp2)

            Caso 1.2: bop = Mul
            expA2ea (binOp2ExpA Mul (Cte n) e2)
            = def. binOp2ExpA
            expA2ea (Prod (Cte n) exp2)
            = def. expA2ea.3
            BOp Mul (Const n) (expA2ea exp2)

        LD:
        Según análisis de casos:
            Caso 1.1: bop = Sum
            Bop Sum (expA2ea (Cte n)) (expA2ea e2)
            = def. expA2ea
            Bop Sum (Const n) (expA2ea e2)

            Caso 1.2: bop = Mul
            Bop Mul (expA2ea (Cte n)) (expA2ea e2)
            = def. expA2ea
            Bop Mul (Const n) (expA2ea e2)

        Se llega al mismo resultado en ambas partes. Vale para este caso

        Caso 2: e1 = (Suma e1' e2')

        LI:
            Por análisis de casos:
            Caso 2.1: bop = Sum
            expA2ea (binOp2ExpA Sum (Suma e1' e2') e2)
            = def. binOp2ExpA.1
            expA2ea (Suma (Suma e1' e2') e2)
            = def. exp2A2ea.2
            BOp Sum (expA2ea (Suma e1' e2')) (expA2ea exp2)
            = def. expA2ea.2
            BOp Sum (BOp Sum (expA2ea e1') (expA2ea e2')) (expA2ea exp2)
            = ?

            Caso 2.2: bop = Mul
            expA2ea (binOp2ExpA Mul (Suma e1' e2') e2)
            = def. binOp2ExpA.1
            expA2ea (Suma (Suma e1' e2') e2)
            = def. exp2A2ea.2
            BOp Mul (expA2ea (Suma e1' e2')) (expA2ea exp2)
            = def. expA2ea.2
            BOp Mul (BOp Sum (expA2ea e1') (expA2ea e2')) (expA2ea exp2)
        
        LD:
            Por análisis de casos:
            Caso 2.1: bop = Sum
            Bop Sum (expA2ea (Suma e1' e2')) (expA2ea e2)
            = def. expA2ea.3
            Bop Sum (BOp Sum (expA2ea e1') (expA2ea e2')) (expA2ea exp2)
            
            Caso 2.2: bop = Mul
            Bop Mul (expA2ea (Prod e1' e2')) (expA2ea e2)
            = def. expA2ea.3
            Bop Mul (BOp Mul (expA2ea e1') (expA2ea e2')) (expA2ea exp2)

        Caso 3: Trivial, igual que caso 2 pero con Mul.

    iii.
    Prop.: ¿evalExpA . ea2ExpA = evalEA?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿Para todo x :: EA. expA2ea . ea2ExpA X = id X?
    Sea n :: EA. Por ppio de inducción en la estructura de n,
    es equivalente demostrar que
    ¿expA2ea . ea2ExpA n = id n?

    Caso base: n = Const m
        ¿evalExpA . ea2ExpA (Const m) = evalEA (Const m)?

    Caso inductivo: n = BOp binop e1 e2
        HI.1) ¡evalExpA . ea2ExpA e1 = evalEA e1!
        HI.2) ¡evalExpA . ea2ExpA e2 = evalEA e2!
        TI) ¿evalExpA . ea2ExpA (BOp binop e1 e2) = evalEA (BOp binop e1 e2)?

    Dem. caso base:
    LI:
    evalExpA . ea2ExpA (Const m)
    = def. ea2ExpA.1
    evalExpA (Cte m)
    = def. evalExpA.1
    m

    LD:
    evalEA (Const m)
    = def. evalEA
    m

    Vale para este caso.

    Caso inductivo:
    LI:
    evalExpA . ea2ExpA (BOp binop e1 e2)
    = def. op. .
    evalExpA (ea2ExpA (BOp binop e1 e2))
    = def. ea2ExpA
    evalExpA (binOp2ExpA binOp (ea2ExpA e1) (ea2ExpA e2))

    LD:
    evalEA (BOp binop e1 e2)
    = def. evalEA
    evalBinop binOp (evalEA e1) (evalEA e2)

    LEMA 1:
    Prop.: ¿evalExpA (binOp2ExpA binOp e1 e2) = evalBinop binOp (evalExpA e1) (evalExpA e2)?
    Dem.: Por análisis de casos:
    
    Caso 1: binOp = Sum
        Li:
        evalExpA (binOp2ExpA Sum e1 e2)
        = def. binOp2ExpA
        evalExpA (Suma exp1 exp2)
        = def. evalExpA.2
        evalExpA exp1 + evalExpA exp2

        Ld:
        evalBinop Sum (evalExpA e1) (evalExpA e2)
        = def. evalBinop .1
        (+) (evalExpA e1) (evalExpA e2)
        = def. seccion. op. (+)
        evalExpA e1 + evalExpA e2

    Caso 2 es trivial. Igual que el 1 pero con * y Mul

    iv.
    Prop.: ¿evalEA . expA2ea = evalExpA?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    ¿Para todo x :: ExpA. expA2ea . ea2ExpA X = id X?
    Sea n :: ExpA. Por ppio de inducción en la estructura de n,
    es equivalente demostrar que
    ¿evalEA . expA2ea n = evalExpA n?

    Caso base: n = Cte n
        ¿evalEA . expA2ea (Cte n) = evalExpA (Cte n)?
    
    Caso inductivo 1: n = (Suma e1 e2)
        HI.1) ¡evalEA . expA2ea e1 = evalExpA e1!
        HI.2) ¡evalEA . expA2ea e2 = evalExpA e2!
        TI) ¿evalEA . expA2ea (Suma e1 e2) = evalExpA (Suma e1 e2)?

    Caso inductivo 2: n = (Prod e1 e2)
        HI.1) ¡evalEA . expA2ea e1 = evalExpA e1!
        HI.2) ¡evalEA . expA2ea e2 = evalExpA e2!
        TI) ¿evalEA . expA2ea (Prod e1 e2) = evalExpA (Prod e1 e2)?

    Dem. caso base:
        LI:
        evalEA . expA2ea (Cte n)
        = def. expA2ea.1
        evalEA (Const n)
        = def. evalEA
        n

        LD:
        evalExpA (Cte n)
        = def. evalExpA.1
        n

        Se llega al mismo resultado. Vale para este caso
    
    Dem. caso inductivo 1:
        LI:
        evalEA . expA2ea (Suma e1 e2)
        = def. expA2ea
        evalEA (BOp Sum (expA2ea e1) (expA2ea e2))
        = def. evalEA.2
        evalBinop Sum evalEA (expA2ea e1) evalEA (expA2ea e2)
        = def. evalBinop.1
        (+) evalEA (expA2ea e1) evalEA (expA2ea e2)
        = HI.1 y HI.2
        (+) evalExpA e1 evalExpA e2
        = def. secc. op (+)
        evalExpA e1 + evalExpA e2

        LD:
        evalExpA (Suma e1 e2)
        = def. evalExpA
        evalExpA e1 + evalExpA e2

    Caso inductivo 2 es trivial.

    