data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum | Mul
    deriving (Show)

data ExpA = Cte Int
                | Suma ExpA ExpA
                | Prod ExpA ExpA
        deriving (Show)

foldEA :: (Int -> b)
            -> (BinOp -> b -> b -> b)
            -> EA
            -> b
foldEA fc fbop (Const n)        = fc n
foldEA fc fbop (BOp bop e1 e2)  = fbop bop (foldEA fc fbop e1) (foldEA fc fbop e2)

noTieneNegativosExplicitosEA :: EA -> Bool
noTieneNegativosExplicitosEA = foldEA (not . (<0)) fbop
                                where fbop bop p1 p2 = p1 && p2

simplificarEA' :: EA -> EA
-- que describe una expresión con
-- el mismo significado que la dada, pero que no tiene sumas del
-- número 0 ni multiplicaciones por 1 o por 0. La resolución debe ser
-- exclusivamente simbólica.
simplificarEA' = foldEA (Const) simplificarBop

simplificarBop :: BinOp -> EA -> EA -> EA
simplificarBop Sum (Const 0) n = n
simplificarBop Sum n (Const 0) = n
simplificarBop Mul (Const 1) m = m
simplificarBop Mul m (Const 1) = m
simplificarBop Mul (Const 0) m = (Const 0)
simplificarBop Mul m (Const 0) = (Const 0)

evalEA' :: EA -> Int
-- que describe el número que resulta de
-- evaluar la cuenta representada por la expresión aritmética dada
evalEA' = foldEA (id) (evalBop)

evalBop :: BinOp -> Int -> Int -> Int
evalBop Sum = (+)
evalBop Mul = (*)

showEA :: EA -> String
showEA = foldEA fc fbop
            where fc n = "(Const " ++ show n ++ ")"
                  fbop bop e1 e2 = "(BinOp " ++ show bop ++ " " ++ e1 ++ " " ++ e2 ++ ")"

ea2ExpA' :: EA -> ExpA
-- que describe una expresión aritmética
-- representada con el tipo ExpA, cuyo significado es el mismo que la
-- dada.
ea2ExpA' = foldEA (Cte) fbop
            where fbop Sum e1 e2 = Suma e1 e2
                  fbop Mul e1 e2 = Prod e1 e2

data ABTree a b = Leaf b | Node a (ABTree a b) (ABTree a b)
        deriving (Show)

arbolPrueba = BOp Sum (BOp Mul (Const 5) (Const 23)) (Const 7)

ea2Arbol' :: EA -> ABTree BinOp Int
ea2Arbol' = foldEA (Leaf) (Node)

-- evalEA :: EA -> Int
-- evalEA (Const n) = n
-- evalEA (BOp binOp exp1 exp2) = evalBinop binOp evalEA exp1 evalEA exp2

-- evalBinop :: BinOp -> Int -> Int -> Int
-- evalBinop (Sum) n1 n2 = (+)
-- evalBinop (Mul) n1 n2 = (*)

-- c. 

    Prop.: evalEA' = evalEA?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
        ¿para todo x :: EA, evalEA' x = evalEA x?
        Por ppio. de inducción en la estructura de x, es equivalente demostrar que
        Sea e un elemento cualquiera de tipo EA, es equivalente demostrar que
        ¿para todo e :: ExpA, evalEA' e = evalEA e?

    Caso base: e = (Const n)
        evalEA' (Const n) = evalEA (Const n)?

    Caso inductivo: e = (BOp bop e1 e2)
        HI.1) ¡evalEA' e1 = evalEA e1!
        HI.2) ¡evalEA' e2 = evalEA e2!
        TI) ¿evalEA' (BOp bop e1 e2) = evalEA (BOp bop e1 e2)?

    Dem. caso base:
        LI:
        evalEA' (Const n)
        = def. evalEA'
        foldEA (id) (evalBop) (Const n)
        = def. foldEA.1
        id n
        = def. id
        n

        LD:
        evalEA (Const n)
        = def. evalEA
        n

        Se llega a la misma expresión. Vale para este caso.

    Dem. caso inductivo:
        LI:
        evalEA' (BOp bop e1 e2)
        = def. evalEA'
        foldEA (id) (evalBop) (BOp bop e1 e2)
        = def. foldEA
        evalBop bop (foldEA (id) (evalBop) e1) (foldEA (id) (evalBop) e2)
        = def. evalEA' 
        evalBop bop (evalEA' e1) (evalEA' e2)
        = HI.1 e HI.2
        evalBop bop (evalEA e1) (evalEA e2)

        ANÁLISIS DE CASOS:
            CASO 1: bop = Sum
                evalBop Sum (evalEA e1) (evalEA e2)
                = def. evalBop.1
                (+) (evalEA e1) (evalEA e2)

            CASO 2: bop = Mul
                evalBop Mul (evalEA e1) (evalEA e2)
                = def. evalBop.2
                (*) (evalEA e1) (evalEA e2)


        LD:
        evalEA (BOp bop e1 e2)
        = def. evalEA.2
        evalBinop bop (evalEA e1) (evalEA e2)
        
        ANÁLISIS DE CASOS:
            CASO 1: bop = Sum
                evalBinop Sum (evalEA e1) (evalEA e2)
                = def. evalBinop.1
                (+) (evalEA e1) (evalEA e2)

            CASO 2: bop = Mul
                evalBinop Mul (evalEA e1) (evalEA e2)
                = def. evalBinop.2
                (*) (evalEA e1) (evalEA e2)

        Se llega al mismo resultado en todos los casos. Es válido el caso y por ende,
        la propiedad.



        