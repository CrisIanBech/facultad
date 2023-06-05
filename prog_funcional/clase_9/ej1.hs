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
        Bop bop expA2ea . ea2ExpA e1 expA2ea . ea2ExpA e2
        = HI.1 y HI.2
        Bop bop e1 e2

        LD:
        id (BOp bop e1 e2)
        = def. id
        BOp bop e1 e2

        LEMA: distribucionexpA2ea de binOp2ExpA
        Prop.: ¿expA2ea (binOp2ExpA bop e1 e2) = Bop bop (expA2ea e1) (expA2ea e2)?
        Dem.: Por principio de induccion en la estructura de e1 :: ExpA y e2 :: ExpA

        Caso base: e1 = Cte n )
            ¿expA2ea (binOp2ExpA bop (Cte n) e2) = Bop bop (expA2ea (Cte n)) (expA2ea e2)?
        
        Caso inductivo.1: e1 = Suma e1' e2')
            HI.1) ¡expA2ea (binOp2ExpA bop e1' e2) = Bop bop (expA2ea e1') (expA2ea e2)!
            HI.2) ¡expA2ea (binOp2ExpA bop e2' e2) = Bop bop (expA2ea e2') (expA2ea e2)!
            TI) ¿expA2ea (binOp2ExpA bop (Suma e1' e2') e2) = Bop bop (expA2ea (Suma e1' e2')) (expA2ea e2)?

        Caso inductivo.2: e1 = Prod e1' e2')
            HI.1) ¡expA2ea (binOp2ExpA bop e1' e2) = Bop bop (expA2ea e1') (expA2ea e2)!
            HI.2) ¡expA2ea (binOp2ExpA bop e2' e2) = Bop bop (expA2ea e2') (expA2ea e2)!
            TI) ¿expA2ea (binOp2ExpA bop (Prod e1' e2') e2) = Bop bop (expA2ea (Prod e1' e2')) (expA2ea e2)?

        Dem. caso base:
            LI:
            expA2ea (binOp2ExpA bop (Cte n) e2)
            =
                Por análisis de casos:
                    Caso 1: bop = Sum)
                    expA2ea (binOp2ExpA Sum (Cte n) e2)
                    = def. binOp2ExpA
                    expA2ea (Suma (Cte n) exp2)
                    = def. expA2ea
                    BOp Sum expA2ea (Cte n) expA2ea exp2
                    = def. expA2ea.2
                    BOp Sum (Const n) expA2ea exp2

                    Caso 2: bop = Mul)
                    expA2ea (binOp2ExpA Mul (Cte n) e2)
                    = def. binOp2ExpA.2
                    expA2ea (Prod (Cte n) exp2)
                    = def. expA2ea.3
                    BOp Prod expA2ea (Cte n) expA2ea exp2
                    = def. expA2ea.3.
                    BOp Prod (Const n) expA2ea exp2

            LD:
                Por análisis de casos:
                Caso 1: bop = Sum)

                Bop Sum (expA2ea (Cte n)) (expA2ea e2)
                = def. expA2ea
                Bop Sum (Const n) (expA2ea e2)

                Caso 2: bop = Mul)
                
                Bop Mul (expA2ea (Cte n)) (expA2ea e2)
                = def. expA2ea
                Bop Mul (Const n) (expA2ea e2)

                Se cumple para este caso.

        Dem. caso inductivo.1:
            LI:
            expA2ea (binOp2ExpA bop (Suma e1' e2') e2)
            = binOp2ExpA
            Por análisis de casos:
                Caso 1: bop = Sum)
                expA2ea (binOp2ExpA Sum (Suma e1' e2') e2)
                = def. binOp2ExpA.1
                expA2ea (Suma (Suma e1' e2') e2)
                = def. expA2ea.2
                BOp Sum expA2ea (Suma e1' e2') expA2ea e2
                = def. expA2ea.2
                BOp Sum (BOp Sum expA2ea e1' expA2ea e2') expA2ea e2
                
            
                Caso 2: bop = Mul)
                expA2ea (binOp2ExpA Mul (Suma e1' e2') e2)
                = def. binOp2ExpA.1
                expA2ea (Prod (Suma e1' e2') e2)
                = def. expA2ea.2
                BOp Mul expA2ea (Suma e1' e2') expA2ea exp2

            LD:
            Bop bop (expA2ea (Suma e1' e2')) (expA2ea e2)
            = def. expA2ea.2
            Bop bop (BOp Sum (expA2ea e1') (expA2ea e2')) (expA2ea e2)