data ExpA = Cte Int
                | Suma ExpA ExpA
                | Prod ExpA ExpA
        deriving (Show)

foldExpA :: (Int -> b)
                -> (b -> b -> b)
                -> (b -> b -> b)
                -> ExpA
                -> b
foldExpA fc fs fp (Cte n)       = fc n
foldExpA fc fs fp (Suma e1 e2)  = fs (foldExpA fc fs fp e1) (foldExpA fc fs fp e2)
foldExpA fc fs fp (Prod e1 e2)  = fp (foldExpA fc fs fp e1) (foldExpA fc fs fp e2)

cantidadDeCeros :: ExpA -> Int
-- que describe la cantidad de ceros explícitos en la expresión dada

cantidadDeCeros = foldExpA fc (+) (+)
                    where fc n = unoSiCero n

unoSiCero :: Int -> Int
unoSiCero 0 = 1
unoSiCero _ = 0

noTieneNegativosExplicitosExpA :: ExpA -> Bool
-- que describe si la expresión dada no tiene números negativos de manera
-- explícita.
noTieneNegativosExplicitosExpA = foldExpA fc (&&) (&&)
                                    where fc n = n >= 0

simplificarExpA' :: ExpA -> ExpA
-- expresión con el mismo significado que la dada, pero que no tiene
-- sumas del número 0 ni multiplicaciones por 1 o por 0. La resolución
-- debe ser exclusivamente simbólica.
simplificarExpA' = foldExpA fc fs fp 
                        where   fc e                = (Cte e)

                                fs (Cte 0) (Cte m)  = Cte m
                                fs (Cte n) (Cte 0)  = Cte n
                                fs n m              = Suma n m

                                fp (Cte 1) (Cte m)  = Cte m
                                fp (Cte n) (Cte 1)  = Cte n
                                fp (Cte 0) (Cte m)  = Cte 0
                                fp (Cte n) (Cte 0)  = Cte 0
                                fp n m              = Prod n m 

evalExpA' :: ExpA -> Int
-- Int, que describe el número que resulta de evaluar la cuenta representada por la expresión aritmética dada.
evalExpA' = foldExpA (id) (+) (*)

showExpA :: ExpA -> String
showExpA = foldExpA fc fs fp
                where fc e      = "(Cte" ++ show e ++ ")"
                      fs s1 s2  = "(Suma" ++ s1 ++ s2 ++ ")"
                      fp s1 s2  = "(Prod" ++ s1 ++ s2 ++ ")"


-- c. 

    -- evalExpA :: ExpA -> Int
    -- evalExpA (Cte n) = n
    -- evalExpA (Suma exp1 exp2) = evalExpA exp1 + evalExpA exp2
    -- evalExpA (Prod exp1 exp2) = evalExpA exp1 * evalExpA exp2


    --     Prop.: ¿evalExpA' = evalExpA?
    --     Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
    --         ¿para todo x :: ExpA, evalExpA' x = evalExpA x?
    --         Por ppio. de inducción en la estructura de x, es equivalente demostrar que
    --         Sea e un elemento cualquiera de tipo ExpA, es equivalente demostrar que
    --         ¿para todo e :: ExpA, evalExpA' e = evalExpA e?

    --     Caso base: e = (Cte n)
    --         ¿evalExpA' (Cte n) = evalExpA (Cte n)?

    --     Caso inductivo 1: e = (Suma n m)
    --         HI.1) ¡evalExpA' m = evalExpA m!
    --         HI.2) ¡evalExpA' n = evalExpA n!
    --         TI)   ¿evalExpA' (Suma n m) = evalExpA (Suma n m)?

    --     Caso inductivo 2: e = (Prod n m)
    --         HI.1) ¡evalExpA' m = evalExpA m!
    --         HI.2) ¡evalExpA' n = evalExpA n!
    --         TI)   ¿evalExpA' (Prod n m) = evalExpA (Prod n m)?

    --     Dem. caso base:
    --         LI:
    --         evalExpA' (Cte n)
    --         = def. evalExpA'.1
    --         id n
    --         = def. id
    --         n

    --         LD:
    --         evalExpA (Cte n)
    --         = def. evalExpA
    --         n

    --         Se llega al mismo resultado. Vale la propiedad para este caso.

    --     Dem. caso inductivo 1:
    --         LI:
    --         evalExpA' (Suma n m)
    --         = def. foldExpA'.2
    --         (+) (foldExpA (id) (+) (*) n) (foldExpA (id) (+) (*) m)
    --         = def. evalExpA'
    --         (+) (evalExpA' n) (evalExpA' m)
    --         = HI.1 e HI.2
    --         (+) (evalExpA n) (evalExpA m)
    --         = def. seccion op. (+)
    --         evalExpA n + evalExpA m
            
    --         LD:
    --         evalExpA (Suma n m) 
    --         = def. evalExpA.2
    --         evalExpA n + evalExpA m

    --         Se llega al mismo resultado. Vale para este caso.

    --     Dem. caso inductivo 2:
    --         LI:
    --         evalExpA' (Prod n m)
    --         = def. foldExpA'.3
    --         (*) (foldExpA (id) (+) (*) n) (foldExpA (id) (+) (*) m)
    --         = def. evalExpA'
    --         (*) (evalExpA' n) (evalExpA' m)
    --         = HI.1 e HI.2
    --         (*) (evalExpA n) (evalExpA m)
    --         = def. seccion op. (*)
    --         evalExpA n * evalExpA m
            
    --         LD:
    --         evalExpA (Prod n m) 
    --         = def. evalExpA.2
    --         evalExpA n * evalExpA m

    --         Se llega al mismo resultado. Vale para este caso.
    --         Se cumplen para todos los casos. La propiedad es válida.

    -- d.

recExpA :: (Int -> b)
                -> (b -> b -> ExpA -> ExpA -> b)
                -> (b -> b -> ExpA -> ExpA -> b)
                -> ExpA
                -> b
recExpA fc fs fp (Cte n)       = fc n
recExpA fc fs fp (Suma e1 e2)  = fs (recExpA fc fs fp e1) (recExpA fc fs fp e2) e1 e2
recExpA fc fs fp (Prod e1 e2)  = fp (recExpA fc fs fp e1) (recExpA fc fs fp e2) e1 e2

cantDeSumaCeros :: ExpA -> Int
-- que describe la cantidad de constructores de suma con al menos 
-- uno de sus hijos constante cero.
cantDeSumaCeros = recExpA (const 0) fs fp
                    where   fs n1 n2 e1 e2 = n1 + n2 + if (tieneConst0 e1 || tieneConst0 e2) then 1 else 0 

                            fp n1 n2 e1 e2 = n1 + n2
    
tieneConstN :: Int -> ExpA -> Bool
tieneConstN n = foldExpA (==n) (||) (||)

tieneConst0 :: ExpA -> Bool
tieneConst0 = tieneConstN 0

tieneConst1 :: ExpA -> Bool
tieneConst1 = tieneConstN 1

cantDeProdUnos :: ExpA -> Int
-- que describe la cantidad de constructores de producto con al menos uno de sus 
-- hijos constante uno.
cantDeProdUnos = recExpA (const 0) fs fp
                    where   fs n1 n2 e1 e2 = n1 + n2 
                        
                            fp n1 n2 e1 e2 = n1 + n2 + if (tieneConst1 e1 || tieneConst1 e2) then 1 else 0 

                            

