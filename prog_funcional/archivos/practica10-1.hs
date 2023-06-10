data BExp = BCte Bool
            | Not BExp
            | And BExp BExp
            | Or BExp BExp
            | ROp RelOp NExp NExp

data RelOp = Eq | Neq | Lt | LEq | Gt | GEt

cfBExp :: BExp -> BExp
cfBExp (Not be) = cfNot (cfBExp be)
cfBExp (BCte b) = BCte b

cfNot :: BExp -> BExp
cfNot (BCte b)  = BCte (not b) -- (b :: Bool)
cfNot be        = Not be --be es el resultado de hacer cf en el resto

(Not (Not (BCte True)))

cfBExp (Not (Not (BCte True)))
= -- Def cfBExp
cfNot (cfBExp (Not (BCte True)))
= -- Def cfBexp
cfNot (cfNot (cfBExp BCte True))
= -- Def cfBExp
cfNot (cfNot (BCte True))
= -- Def cfNot
cfNot (BCte (not True)))
= -- Def not
cfNot (BCte False))
= -- Def cfNot
BCte (not False)
= -- Def not
BCte True


evalComando :: Comando -> (Memoria -> Memoria)
evalComando (Assign x ne) = 
    \mem -> recordar x (evalExpA ne mem) mem
evalComando (If be cs1 cs2) =
    \mem -> if (evalBExp be mem)
                then evalBloque cs1 mem
                else evalBloque cs2 mem
evalComando (While be cs) =
    evalComando (If be then(cs ++ [While be cs]) else [])

-- Que pasa aca con un while?
-- Ponele que hago while (x != 2) { x = x + 1 }
-- Lo que ocurre es que va a evaluar el comando while, que va a evaluar un if 
-- (o sea, entra otra vez a evalComando) con la condicion del while, y si la condicion es 
-- verdadera va a ejecutar un bloque compuesto por el bloque que estaba adentro del while, y al final
-- una ejecucion mas del while




-- EJERCICIO 1
data NExp = Var Variable
            | NCte Int
            | NBOp NBinOp NExp NExp

data NBinOp = Add | Sub | Mul | Div | Mod | Pow
type Variable = String

-- Memoria
enBlanco    :: Memoria
cuantoVale  :: Variable -> Memoria -> Maybe Int
recordar    :: Variable -> Int -> Memoria -> Memoria
variables   :: Memoria -> [Variable]

evalNExp :: NExp -> Memoria -> Int
evalNExp (Var x)            mem = 
    case cuantoVale x mem of --Fede en clase directamente usó fromJust
        Nothing -> error ("Variable "++x++" no está definida")
        Just n -> n
evalNExp (NCte n)           mem = n
evalNExp (NBOp bop ex1 ex2) mem = 
    evalBOp bop (evalNExp ex1 mem) (evalNExp ex2 mem)

evalBOp :: BinOp -> Int -> Int -> Int
evalBOp Add = (+)
evalBOp Sub = (-)
evalBOp Mul = (*)
evalBOp Div = div
evalBOp Mod = mod
evalBOp Pow = (^)

cfNExp :: NExp -> NExp
cfNExp (Var x)              = Var x
cfNExp (NCte n)             = NCte n
cfNExp (NBOp bop ex1 ex2)   = 
    cfBOp bop (cfNExtp ex1) (cfNExtp ex2)

cfBOp :: BinOp -> NExp -> NExp -> NExp
cfBOp Add n1 n2 = cfAdd n1 n2
cfBOp Sub n1 n2 = cfSub n1 n2
cfBOp Mul n1 n2 = cfMul n1 n2
cfBOp Div n1 n2 = cfDiv n1 n2
cfBOp Mod n1 n2 = cfMod n1 n2
cfBOp Pow n1 n2 = cfPow n1 n2

cfAdd :: NExp -> NExp -> NExp
cfAdd (NCte n) (NCte n2) = NCte (n + n2)
cfAdd ex1 ex2            = NBOp Add ex1 ex2 
-- Aca Fede hizo
-- cfAdd (NCte 0) m = m
-- cfAdd m (NCte 0) = m
-- cfAdd n m        = NBOp Add ex1 ex2 


cfSub :: NExp -> NExp -> NExp
cfSub (NCte n) (NCte n2) = NCte (n - n2)
cfSub ex1 ex2            = NBOp Sub ex1 ex2 

cfMul :: NExp -> NExp -> NExp
cfMul (NCte n) (NCte n2) = NCte (n * n2)
cfMul ex1 ex2            = NBOp Mul ex1 ex2 

cfDiv :: NExp -> NExp -> NExp
cfDiv (NCte n) (NCte n2) = NCte (n `div` n2)
cfDiv ex1 ex2            = NBOp Div ex1 ex2 

cfMod :: NExp -> NExp -> NExp
cfMod (NCte n) (NCte n2) = NCte (n `mod` n2)
cfMod ex1 ex2            = NBOp Mod ex1 ex2 

cfPow :: NExp -> NExp -> NExp
cfPow (NCte n) (NCte n2) = NCte (n ^ n2)
cfPow ex1 ex2            = NBOp Mul ex1 ex2 

-- b
evalNExp . cfNExp ​=​ evalNExp

-- Por ppio de extensionalidad, para todo ex :: NExp, mem :: Memoria
    -- (evalNExp . cfNExp) ex ​mem =​ evalNExp ex mem

-- Sea bx :: NExp totalmente definido, por ppio de induccion estructural sobre la estructura de bx:

-- Caso base 1: bx = (NCte b)
-- (evalNExp . cfNExp) (NCte b) mem =​ evalNExp (NCte b) mem

-- Caso base 2: bx = (Var x)
-- (evalNExp . cfNExp) (Var x) mem =​ evalNExp (Var x) mem

-- Caso inductivo: bx =  (NBOp bop ex1 ex2)
-- HI-1: (evalNExp . cfNExp) ex1 mem ​=​ evalNExp ex1 mem
-- HI-2: (evalNExp . cfNExp) ex2 mem ​=​ evalNExp ex2 mem
-- TI: (evalNExp . cfNExp) (NBOp bop ex1 ex2) mem ​=​ evalNExp (NBOp bop ex1 ex2) mem

-- Caso base 1
(evalNExp . cfNExp) (NCte b) mem =​ evalNExp (NCte b) mem

-- Lado izquierdo
(evalNExp . cfNExp) (NCte b) mem
= -- Def (.)
evalNExp (cfNExp (NCte b)) mem
= -- Def cfNExp . 2
evalNExp (NCte b) mem

-- Es igual al lado derecho

-- Caso base 2
(evalNExp . cfNExp) (Var x) mem =​ evalNExp (Var x) mem

-- Lado izquierdo
(evalNExp . cfNExp) (Var x) mem
= -- Def (.)
evalNExp (cfNExp (Var x)) mem
= -- Def cfNExp . 1
evalNExp (Var x) mem

-- Igual al lado derecho, pero evalNExp es parcial para este caso, por lo que
-- suponemos que elem x (variables) = True

-- Caso inductivo
(evalNExp . cfNExp) (NBOp bop ex1 ex2) mem ​=​ evalNExp (NBOp bop ex1 ex2) mem

-- Lado izquierdo
(evalNExp . cfNExp) (NBOp bop ex1 ex2) mem
= -- Def (.)
evalNExp (cfNExp (NBOp bop ex1 ex2)) mem
= -- Def cfNExp . 3
evalNExp (cfBOp bop (cfNExtp ex1) (cfNExtp ex2)) mem
= -- Lema dist evalNExp en cfBOp
evalBOp bop (evalNExp (cfNExp ex1)) (evalNExp (cfNExp ex2))

-- Aca Fede dijo no es por aca capo, retrocedio y dividio en casos desde antes

Caso op = Add
-- Caso inductivo: bx =  (NBOp Add ex1 ex2)
-- HI-1: (evalNExp . cfNExp) ex1 mem ​=​ evalNExp ex1 mem
-- HI-2: (evalNExp . cfNExp) ex2 mem ​=​ evalNExp ex2 mem
(evalNExp . cfNExp) (NBOp Add ex1 ex2) mem ​=​ evalNExp (NBOp Add ex1 ex2) mem

-- Lado izquierdo
(evalNExp . cfNExp) (NBOp Add ex1 ex2) mem
= -- def (.)
evalNExp (cfNExp (NBOp Add ex1 ex2)) mem
= -- def cfNExp . 3
evalNExp (cfBOp Add (cfNExt ex1) (cfNExt ex2)) mem
= -- def cfBOp . 1
evalNExp (cfAdd (cfNExt ex1) (cfNExt ex2)) mem
= -- Lema distrib evalNExp / cfAdd
(evalNExp (cfNExt ex1) mem) + (evalNExp (cfNExt ex2) mem)

-- Lado derecho
evalNExp (NBOp Add ex1 ex2) mem
= -- def evalNExp . 3
evalBOp Add (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- def evalBOp . 1
(+) (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- HI
(+) ((evalNExp . cfNExp) ex1 mem) ((evalNExp . cfNExp) ex2 mem)
= -- operador infijo
((evalNExp . cfNExp) ex1 mem) + ((evalNExp . cfNExp) ex2 mem)
= -- def (.)
(evalNExp (cfNExp ex1) mem) + (evalNExp (cfNExp ex2) mem)

-- Demostrado

-- Lema distrib evalNExp / cfAdd
evalNExp (cfAdd ex1 ex2) mem = (evalNExp ex1 mem) + (evalNExp ex2 mem)

-- Voy a demostrar por casos sobre ex1 y ex2
-- Caso ex1 = (NCte n), ex2 = (NCte m)
evalNExp (cfAdd (NCte n) (NCte m)) mem = (evalNExp (NCte n) mem) + (evalNExp (NCte m) mem)

-- Lado izquierdo
evalNExp (cfAdd (NCte n) (NCte m)) mem
= -- def cfAdd . 1
evalNExp (NCte (n + m)) mem
= -- def evalNExp . 2
(n + m)

-- Lado derecho
(evalNExp (NCte n) mem) + (evalNExp (NCte m) mem)
= -- def evalNExp . 2
n + m

-- Caso cualquier ex1 y cualquier ex2
evalNExp (cfAdd ex1 ex2) mem = (evalNExp ex1 mem) + (evalNExp ex2 mem)

-- Lado izquierdo
evalNExp (cfAdd ex1 ex2) mem
= -- def cfAdd . 2
evalNExp (NBOp Add ex1 ex2) mem 
= -- def evalNExp . 3
evalBOp Add (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- def evalBOp . 1
(+) (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- operador infijo
(evalNExp ex1 mem) + (evalNExp ex2 mem)

-- Es igual al lado derecho, demostrado

Caso op = Mul
-- Caso inductivo: bx =  (NBOp Mul ex1 ex2)
-- HI-1: (evalNExp . cfNExp) ex1 mem ​=​ evalNExp ex1 mem
-- HI-2: (evalNExp . cfNExp) ex2 mem ​=​ evalNExp ex2 mem
(evalNExp . cfNExp) (NBOp Mul ex1 ex2) mem ​=​ evalNExp (NBOp Mul ex1 ex2) mem

-- Lado izquierdo
(evalNExp . cfNExp) (NBOp Mul ex1 ex2) mem
= -- def (.)
evalNExp (cfNExp (NBOp Mul ex1 ex2)) mem
= -- def cfNExp . 3
evalNExp (cfBOp Mul (cfNExtp ex1) (cfNExtp ex2)) mem
= -- def cfBOp . 3
evalNExp (cfMul (cfNExtp ex1) (cfNExtp ex2)) mem
= -- lema dist evalNExp / cfMul
(evalNExp (cfNExp ex1) mem) * (evalNExp (cfNExp ex2) mem))


-- Lado derecho
evalNExp (NBOp Mul ex1 ex2) mem
= -- def evalNExp . 3
evalBOp Mul (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- def evalBOp . 3
(*) (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- HI
(*) ((evalNExp . cfNExp) ex1 mem) (evalNExp . cfNExp) ex2 mem)
= -- operador infijo
((evalNExp . cfNExp) ex1 mem) * (evalNExp . cfNExp) ex2 mem)

-- lema dist evalNExp / cfMul
evalNExp (cfMul ex1 ex2) mem = (evalNExp ex1 mem) * (evalNExp ex2 mem))

-- Por casos sobre ex1 y ex2
-- Caso ex1 = (NCte n) y ex2 = (NCte m)
evalNExp (cfMul (NCte n) (NCte m)) mem = (evalNExp (NCte n) mem) * (evalNExp (NCte m) mem))

-- Lado izquierdo
evalNExp (cfMul (NCte n) (NCte m)) mem
= -- def cfMul . 1
evalNExp (NCte n * m) mem
= -- def evalNExp . 2
NCte n * m

-- Lado derecho
(evalNExp (NCte n) mem) * (evalNExp (NCte m) mem))
= -- def cfNExp . 2
n * m

-- Demostrado

-- Caso ex1 cualquiera y ex2 cualquiera
evalNExp (cfMul ex1 ex2) mem = (evalNExp ex1 mem) * (evalNExp ex2 mem))

-- Lado izquierdo
evalNExp (cfMul ex1 ex2) mem
= -- def cfMul . 2
evalNExp (NBOp Mul ex1 ex2 ) mem 
= -- def evalNExp . 3
evalBOp Mul (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- def evalBOp . 3
(*) (evalNExp ex1 mem) (evalNExp ex2 mem)
= -- operador infijo
(evalNExp ex1 mem) * (evalNExp ex2 mem)

-- Es igual al lado derecho, demostrado

Caso op = Div 
Caso op = Mod 
Caso op = Pow

-- Estos casos son muy similares a los anteriores, no vale la pena seguirlos

--------------------------------------------------------------------------------------------
-- EJERCICIO 2
data BExp = BCte Bool          
            | Not BExp          
            | And BExp BExp          
            | Or BExp BExp          
            | ROp RelOp NExp NExp

data RelOp = Eq   | NEq   -- Equal y NotEqual
           | Gt   | GEq   -- Greater y GreaterOrEqual
           | Lt   | LEq   -- Lower y LowerOrEqual

evalBExp :: BExp -> Memoria -> Bool
evalBExp (BCte b)         mem = b
evalBExp (Not b)          mem = not b
evalBExp (And b1 b2)      mem = evalAnd (evalBExp b1 mem) (evalBExp b2 mem)
evalBExp (Or b1 b2)       mem = evalOr (evalBExp b1 mem) (evalBExp b2 mem)
evalBExp (ROp ro ex1 ex2) mem = evalROp ro (evalNExp ex1 mem) (evalNExp ex2 mem)

evalAnd :: Bool -> Bool -> Bool
evalAnd = (&&)

evalOr :: BExp -> BExp -> Bool
evalOr = (||)

evalROp :: RelOp -> Int -> Int -> Bool
evalROp Eq  = (=)
evalROp NEq = (/=)
evalROp Gt  = (>)
evalROp GEq = (>=)
evalROp Lt  = (<)
evalROp LEq = (<=)

cfBExp :: BExp -> BExp
cfBExp (BCte b)       = BCte b
cfBExp (Not b)        = cfNot (cfBExp b)
cfBExp (And b1 b2)    = cfAnd (cfBExp b1) (cfBExp b2)
cfBExp (Or b1 b2)     = cfOr (cfBExp b1) (cfBExp b2)
cfBExp (ROp ro b1 b2) = cfROp ro (cfNExp b1) (cfNExp b2)

cfNot :: BExp -> BExp
cfNot (BCte b) = BCte (not b)
cfNot bex      = Not bex

cfAnd :: BExp -> BExp -> BExp
cfAdd (BCte b1) (BCte b2) = BCte (b1 && b2)
cfAdd b1 b2               = And b1 b2

cfOr :: BExp -> BExp -> BExp
cfOr (BCte b1) (BCte b2) = BCte (b1 || b2)
cfOr b1 b2               = Or b1 b2

cfROp :: RelOp -> NExp -> NExp -> BExp
cfROp op (NCte n) (NCte m) = BCte (evalROp op n m)
cfROp op ex1 ex2           = ROp op ex1 ex2

evalBExp . cfBExp ​=​ evalBExp

-- Por ppio de extensionalidad,
-- Para todo bexp :: BExp, para todo mem :: Memoria
(evalBExp . cfBExp) bexp mem ​=​ evalBExp bexp mem

-- Sea bx :: BExp totalmente definido, por ppio de induccion estructural
-- sobre la estructura de bx

-- Caso base 1, bx = (BCte b)
-- (evalBExp . cfBExp) (BCte b) mem ​=​ evalBExp (BCte b) mem

-- Caso base 2, bx = (ROp rop ex1 ex2)
-- (evalBExp . cfBExp) (ROp rop ex1 ex2) mem ​=​ evalBExp (ROp rop ex1 ex2) mem

-- Caso inductivo 1, bx = (Not be)
-- HI-1: (evalBExp . cfBExp) be mem ​=​ evalBExp be mem
-- TI-1: (evalBExp . cfBExp) (Not be) mem ​=​ evalBExp (Not be) mem

-- Caso inductivo 2, bx = (And be1 be2)
-- HI-21: (evalBExp . cfBExp) be1 mem ​=​ evalBExp be1 mem 
-- HI-22: (evalBExp . cfBExp) be2 mem ​=​ evalBExp be2 mem 
-- TI-2: (evalBExp . cfBExp) (And be1 be2) mem ​=​ evalBExp (And be1 be2) mem

-- Caso inductivo 3, bx = (Or be1 be2)
-- HI-31: (evalBExp . cfBExp) be1 mem ​=​ evalBExp be1 mem 
-- HI-32: (evalBExp . cfBExp) be2 mem ​=​ evalBExp be2 mem 
-- TI-3: (evalBExp . cfBExp) (Or be1 be2) mem ​=​ evalBExp (Or be1 be2) mem

-- Caso base 1
(evalBExp . cfBExp) (BCte b) mem ​=​ evalBExp (BCte b) mem

-- Lado izquierdo
(evalBExp . cfBExp) (BCte b) mem
= -- def (.)
evalBExp (cfBExp (BCte b)) mem
= -- def cfBExp . 1
evalBExp (BCte b) mem

-- Es igual al lado derecho

-- Caso base 2
(evalBExp . cfBExp) (ROp rop ex1 ex2) mem ​=​ evalBExp (ROp rop ex1 ex2) mem

-- Por casos sobre ex1 y ex2,
-- Caso ex1 = (NCte n) y ex2 = (NCte m)
-- Lado izquierdo
(evalBExp . cfBExp) (ROp rop (NCte n) (NCte m)) mem
= -- def (.)
evalBExp (cfBExp (ROp rop (NCte n) (NCte m))) mem
= -- def cfBExp . 5
evalBExp (cfROp ro (cfNExp (NCte n)) (cfNExp (NCte m)))
= -- def cfNExp . 2
evalBExp (cfROp ro (NCte n) (NCte m))
= -- def cfROp . 1
evalBExp (BCte (evalROp op n m))
= -- def evalBExp . 1
evalROp op n m

-- Lado derecho
evalBExp (ROp rop (NCte n) (NCte m)) mem
= -- def evalBExp . 5
evalROp rop (evalNExp (NCte n) mem) (evalNExp (NCte m) mem)
= -- def evalNExp . 2
evalROp rop n m

-- Caso ex1 cualquier caso y ex2 cualquier caso, mientras que no sean ambos (NCte x)
(evalBExp . cfBExp) (ROp rop ex1 ex2) mem ​=​ evalBExp (ROp rop ex1 ex2) mem

-- Lado izquierdo 
(evalBExp . cfBExp) (ROp rop ex1 ex2) mem
= -- def (.)
evalBExp (cfBExp (ROp rop ex1 ex2)) mem
= -- def cfBExp . 5
evalBExp (cfROp rop (cfNExp b1) (cfNExp b2)) mem
= -- def cfROp . 2
evalBExp (ROp rop (cfNExp b1) (cfNExp b2)) mem
= -- def evalBExp . 5
evalROp rop (evalNExp (cfNExp b1) mem) (evalNExp (cfNExp b2) mem)
= -- por la propiedad evalNExp . cfNExp = evalNExp
evalROp rop (evalNExp b1 mem) (evalNExp b2 mem)



-- Lado derecho
evalBExp (ROp rop ex1 ex2) mem
= -- def evalBExp . 5
evalROp rop (evalNExp ex1 mem) (evalNExp ex2 mem)

-- Demostrado



-- Caso inductivo 1, bx = (Not be)
-- HI-1: (evalBExp . cfBExp) be mem ​=​ evalBExp be mem
-- TI-1: (evalBExp . cfBExp) (Not be) mem ​=​ evalBExp (Not be) mem

(evalBExp . cfBExp) (Not be) mem ​=​ evalBExp (Not be) mem

-- Lado izquierdo
(evalBExp . cfBExp) (Not be)
= -- def (.)
evalBExp (cfBExp (Not be))
= -- def cfBExp . 
evalBExp (cfNot (Not be)
= -- def cfNot . 2  
evalBExp (Not be)
= -- def evalBExp . 2
not be 

-- Lado derecho
evalBExp (Not be) mem
= -- def evalBExp . 2
not be

-- Demostrado... No hizo falta la hipotesis inductiva, por lo que no fue una demostracion
-- por induccion estructural.


-- Caso inductivo 2, bx = (And be1 be2)
-- HI-21: (evalBExp . cfBExp) be1 mem ​=​ evalBExp be1 mem 
-- HI-22: (evalBExp . cfBExp) be2 mem ​=​ evalBExp be2 mem 
(evalBExp . cfBExp) (And be1 be2) mem ​=​ evalBExp (And be1 be2) mem

-- Lado izquierdo
(evalBExp . cfBExp) (And be1 be2) mem ​
= -- def (.)
(evalBExp (cfBExp (And be1 be2)) mem ​
= -- def cfBExp . 3
evalBExp (cfAnd (cfBExp b1) (cfBExp b2)) mem
= -- lema dist evalBExp / cfAnd
evalBExp (cfBExp b1) && evalBExp (cfBExp b2)
= -- HI
evalBExp b1 && evalBExp b2

-- Lado derecho
evalBExp (And be1 be2) mem
= -- def evalBExp . 3
evalAnd (evalBExp b1) (evalBExp b2) 
= -- def evalAnd
(&&) (evalBExp b1) (evalBExp b2)
= -- operador infijo
evalBExp b1 && evalBExp b2


-- lema dist evalBExp / cfAnd
evalBExp (cfAnd b1 b2) mem = evalBExp b1 && evalBExp b2

-- Voy a demostrar por casos
-- Caso b1 = (BCte b1) y b2 = (BCte b2)
evalBExp (cfAnd (BCte b1) (BCte b2)) mem = evalBExp (BCte b1) && evalBExp (BCte b2)

-- Lado izquierdo
evalBExp (cfAnd (BCte b1) (BCte b2)) mem
= -- def cfAnd . 1
evalBExp (BCte (b1 && b2)) mem
= -- def evalBExp . 1
b1 && b2

-- Lado derecho
evalBExp (BCte b1) && evalBExp (BCte b2)
= -- def evalBExp . 1
bi && b2

-- Demostrado


-- Caso b1 cualquier otro caso o b2 cualquier otro caso
evalBExp (cfAnd b1 b2) mem = evalBExp b1 && evalBExp b2

-- Lado izquierdo
evalBExp (cfAnd b1 b2) mem
= -- def cfAnd . 2
evalBExp (And b1 b2) mem
= -- def evaBExp . 3
evalAnd (evalBExp b1) (evalBExp b2)
= -- def evalAnd 
(&&) (evalBExp b1) (evalBExp b2)
= -- operador infijo
evalBExp b1 && evalBExp b2

-- Es igual al lado derecho, demostrado

-- Caso inductivo 3, bx = (Or be1 be2)
-- HI-31: (evalBExp . cfBExp) be1 mem ​=​ evalBExp be1 mem 
-- HI-32: (evalBExp . cfBExp) be2 mem ​=​ evalBExp be2 mem 
(evalBExp . cfBExp) (Or be1 be2) mem ​=​ evalBExp (Or be1 be2) mem

-- Lado derecho
(evalBExp . cfBExp) (Or be1 be2) mem ​
= -- def (.)
evalBExp (cfBExp (Or be1 be2)) mem
= -- def cfBExp . 4
evalBExp (cfOr (cfBExp b1) (cfBExp b2)​) mem
= -- lema dist evalBExp / cfOr
evalBExp (cfBExp b1) mem || evalBExp (cfBExp b2)​) mem
= -- HI
evalBExp b1 mem || evalBExp b2 mem

-- Lado derecho
evalBExp (Or be1 be2) mem
= -- def evalBExp . 4
evalOr (evalBExp b1 mem) (evalBExp b2 mem)
= -- def evalOr
(||) (evalBExp b1 mem) (evalBExp b2 mem)
= -- operador infijo
evalBExp b1 mem || evalBExp b2 mem

-- lema dist evalBExp / cfOr
evalBExp (cfOr b1 b2)​) mem = evalBExp b1 mem || evalBExp b2 mem

-- Por casos sobre b1 y b2
-- Caso b1 = (BCte b1') y b2 = (BCte b2')
evalBExp (cfOr (BCte b1') (BCte b2'))​) mem = evalBExp (BCte b1') mem || evalBExp (BCte b2') mem

-- Lado izquierdo
evalBExp (cfOr (BCte b1') (BCte b2'))​) mem
= -- def cfOr . 1
evalBExp (BCte (b1' || b2')) mem
= -- def evalBExp . 1
b1' || b2'

-- Lado derecho
evalBExp (BCte b1') mem || evalBExp (BCte b2') mem
= -- def evalBExp . 1
b1' || b2'


-- Caso b1 cualquier otro o b2 cualquier otro
evalBExp (cfOr b1 b2)​) mem = evalBExp b1 mem || evalBExp b2 mem

-- Lado izquierdo
evalBExp (cfOr b1 b2)​) mem
= -- def cfOr . 2
evalBExp (Or b1 b2) mem
= -- def evalBExp . 4
evalOr (evalBExp b1 mem) (evalBExp b2 mem)
= -- def evalOr . 2
(||) (evalBExp b1 mem) (evalBExp b2 mem)
= -- operador infijo
(evalBExp b1 mem) || (evalBExp b2 mem)
= -- asociatividad
evalBExp b1 mem || evalBExp b2 mem

-- Es igual al lado derecho

----------------------------------------------------------------------------
-- EJERCICIO 3
data Programa = Prog Bloque
type Bloque = [Comando]
data Comando = Assign Nombre NExp
             | If BExp Bloque Bloque
             | While BExp Bloque

evalProg :: Programa -> Memoria -> Memoria
evalProg (Prog b) mem = evalBloque b mem

evalBloque :: Bloque -> Memoria -> Memoria
evalBloque []     mem = mem
evalBloque (c:cs) mem = let mem' = evalCom c mem 
                            in evalBloque cs mem'

evalCom :: Comando -> Memoria -> Memoria
evalCom (Assign n ex)  mem = recordar n (evalNExp ex mem) mem
evalCom (If bex b1 b2) mem = if (evalBExp bex mem)
                                    then evalCom b1
                                    else evalCom b2
evalCom (While bex bl) mem = evalBloque (if (evalBExp bex) 
                                            then (bl ++ [While bex bl]) 
                                            else []
                                        ) mem

optimizeCf :: Programa -> Programa
optimizeCf (Prog bloque) = Prog (optimizeBl bloque)

optimizeBl :: Bloque -> Bloque
optimizeBl []       = []
optimizeBl (c:cs)   = optimizeCom c ++ optimizeBl cs

optimizeCom :: Comando -> Bloque
optimizeCom (Assign n ex)   = [Assign n (cfNExp ex)]
optimizeCom (If bex b1 b2)  = cfIf bex b1 b2
optimizeCom (While bex bl)  = cfWhile bex bl

cfIf :: BExp -> Bloque -> Bloque -> Bloque
cfIf (BCte b) b1 b2 = if b then b1 else b2
cfIf bex b1 b2      = [If (cfBExp bex) (optimizeBl b1) (optimizeBl b2) ]

cfWhile :: Bexp -> Bloque -> Bloque
cfWhile (BCte b) bl = if b 
                        then [While (BCte b) (optimizeBl bl)] 
                        else [(optimizeBl bl)]
cfWhile bex bl      = [While (cfBExp bex) (optimizeBl bl)] 




-- para todo ​c.​ para todo ​cs.
--   evalBloque (​c​:​cs​) ​=​ evalBloque ​cs​ . evalComando ​c

-- Por principio de extensionalidad, es lo mismo que 
-- para todo mem :: Memoria, para todo c. para todo cs.
--   evalBloque (​c​:​cs​) ​mem =​ (evalBloque ​cs​ . evalComando ​c​) mem

-- Lado izquierdo
evalBloque (​c​:​cs​) mem
= -- def evalBloque . 2
let mem' = evalCom c mem in evalBloque cs mem'
= -- let ACA TENGO LA DUDA; COMO SIGNIFICO LA DEF DE LET
evalBloque cs (evalCom c mem)

-- Lado derecho
(evalBloque ​cs​ . evalComando ​c) mem
= -- def (.)
evalBloque ​cs​ (evalComando ​c mem)

-- Demostrado, aparentemente


-- para todo ​cs​1​.​ para todo ​cs​2​.  
--     evalBloque (​cs​1​ ++ ​cs​2​) =​ evalBloque ​cs​2​ . evalBloque ​cs​1

-- Por ppio de extensionalidad, 
-- para todo ​cs​1​.​ para todo ​cs​2​. para todo mem.
--     evalBloque (​cs​1​ ++ ​cs​2​) mem =​ (evalBloque ​cs​2​ . evalBloque ​cs​1) mem

-- Sea xs :: Bloque totalmente definido, por ppio de induccion estructural sobre la estructura de xs
-- para todo mem.
--     evalBloque (xs​ ++ ​cs​2​) mem =​ (evalBloque ​xs​ . evalBloque ​cs​1) mem

-- Caso base, xs = []
-- para todo mem.
--     evalBloque ([] ++ ​cs​2​) mem =​ (evalBloque [] . evalBloque ​cs​1) mem

-- Caso inductivo, xs = (c:cs)
-- HI: para todo mem. evalBloque (cs ++ ​cs​2​) mem =​ (evalBloque cs2 . evalBloque cs) mem
-- TI: para todo mem. evalBloque ((c:cs) ++ ​cs​2​) mem =​ (evalBloque cs2 . evalBloque (c:cs)) mem


-- Caso base, xs = []
-- para todo mem. evalBloque ([] ++ ​cs​2​) mem =​ (evalBloque cs2 . evalBloque ​[]) mem

-- Lado izquierdo
evalBloque ([] ++ ​cs​2​) mem
= -- def (++)
evalBloque ​cs​2 mem

-- Lado derecho
(evalBloque ​cs​2. evalBloque []) mem
= -- def (.)
evalBloque ​cs​2 (evalBloque [] mem)
= -- def evalBloque . 1
evalBloque ​cs​2 mem

-- Caso inductivo, xs = (c:cs)
para todo mem. evalBloque ((c:cs) ++ ​cs​2​) mem =​ (evalBloque cs2 . evalBloque (c:cs)) mem

-- Lado izquierdo
evalBloque ((c:cs) ++ ​cs​2​) mem
= -- def (++) . 2
evalBloque (c : (cs ++ ​cs​2​)) mem
= -- def evalBloque . 2
let mem' = evalCom c mem in evalBloque (cs ++ cs2) mem'
= -- def let?
evalBloque (cs ++ cs2) (evalCom c mem)

-- Lado derecho
(evalBloque cs2 . evalBloque (c:cs)) mem
= -- def (.)
evalBloque cs2 (evalBloque (c:cs) mem)
= -- def evalBloque . 2
evalBloque cs2 (let mem' = evalCom c mem in evalBloque cs mem')
= -- def let?
evalBloque cs2 (evalBloque cs (evalCom c mem))
= -- def (.)
(evalBloque cs2 . evalBloque cs) (evalCom c mem)
= -- HI
evalBloque (cs ++ ​cs​2​) (evalCom c mem)

-- Aca igual hice un movimiento medio ilegal, porque hice que mem = (evalCom c mem), de ambos
-- lados eran iguales, asi que DEBERIA ser legal...



-- para todo ​be.​ para todo ​cs​1​.​ para todo ​cs​2​.
--     evalCom (If ​be​​cs​1​ cs​2​)​ =​ evalCom (If (Not ​be​) ​cs​2​ cs​1​)
-- Por ppio de extensionalidad,
-- para todo ​be.​ para todo ​cs​1​.​ para todo ​cs​2​. para todo mem.
--     evalCom (If ​be ​​cs​1​ cs​2​)​ mem =​ evalCom (If (Not ​be​) ​cs​2​ cs​1​) mem

-- Sea be' :: BExp totalmente definido, por ppio de induccion estructural sobre la estructura
-- de be',

-- Caso base 1, be' = (BCte b)
-- evalCom (If (BCte b) ​​cs​1​ cs​2​)​ mem =​ evalCom (If (Not ​(BCte b)​) ​cs​2​ cs​1​) mem

-- Caso base 2, be' = (ROp ro ex1 ex2)
-- evalCom (If (ROp ro ex1 ex2) ​​cs​1​ cs​2​)​ mem =​ evalCom (If (Not ​(ROp ro ex1 ex2)​) ​cs​2​ cs​1​) mem



-- No puedo hacer caso evalBExp be = True, caso evalBExp be = False?
-- Porque el caso ROp va a ser medio complicado. Bah no, cualquier caso que no sea BCte es imposible.
-- Por aca no es.

-- para todo ​be.​ para todo ​cs​1​.​ para todo ​cs​2​.
--     evalCom (If ​be​​ cs​1​ cs​2​)​ =​ evalCom (If (Not ​be​) ​cs​2​ cs​1​)

-- Por ppio de extensionalidad,
-- para todo ​be.​ para todo ​cs​1​.​ para todo ​cs​2​. para todo mem.
--     evalCom (If ​be ​​cs​1​ cs​2​)​ mem =​ evalCom (If (Not ​be​) ​cs​2​ cs​1​) mem

-- Lado izquierdo
evalCom (If ​be ​​cs​1​ cs​2​)​ mem
= -- def evalCom . 2
if (evalBExp bex mem)
        then evalCom b1 mem
        else evalCom b2 mem

-- Lado derecho
evalCom (If (Not ​be​) ​cs​2​ cs​1​) mem
= -- def evalCom . 2
if (evalBExp (Not bex) mem)
        then evalCom b2 mem
        else evalCom b1 mem
= -- def evalBExp . 2
if (not (evalBExp bex mem))
        then evalCom b2 mem
        else evalCom b1 mem
= -- definicion de if (checkear)
if (evalBExp bex mem)
        then evalCom b1 mem
        else evalCom b2 mem

-- Demostrado

para todo ​x. ​para todo ​ne​1​. ​para todo ​ne​2​.​
    si (para todo ​mem.
        ​evalNExp ​ne​2​ mem​ ≠ ⊥​ implica
        ​evalNExp ​ne​2 (recordar​ x ​(error "¡Está!") ​mem​)​ ≠ ⊥​)
    entonces ​evalBloque [Assign ​x​​ ne​1​, Assign ​x ​​ne​2​]
                        ​=​ evalComando (Assign ​x ​​ne​2​)
AYUDA:el antecedente solamente establece que​ x no aparece en ne​2​
     y por lo tanto no influye en el resultado

-- Hipotesis: 
    -- si ​evalNExp ​ne​2​ mem​ ≠ ⊥​ 
    -- entonces​ evalNExp ​ne​2 (recordar​ x ​(error "¡Está!") ​mem​)​ ≠ ⊥​
-- Tesis: ​evalBloque [Assign ​x​​ ne​1, Assign ​x ​​ne​2​] ​=​ evalComando (Assign ​x ​​ne​2​)

-- Por ppio de extensionalidad, para todo x. para todo ne1. para todo ne2. para todo mem
​evalBloque [Assign ​x​​ ne1, Assign ​x ​​ne​2​] mem ​=​ evalComando (Assign ​x ​​ne​2​) mem

-- Lado izquierdo
​evalBloque [Assign ​x​​ ne1, Assign ​x ​​ne​2​] mem
= -- def evalBloque . 2
let mem' = evalCom (Assign ​x​​ ne1) mem in evalBloque [Assign ​x ​​ne​2​] mem'
= -- def let
evalBloque [Assign ​x ​​ne​2​] (evalCom (Assign ​x​​ ne1) mem)
= -- def evalBloque . 2
let mem' = evalCom (Assign ​x ​​ne​2) (evalCom (Assign ​x​​ ne1) mem) in evalBloque [] mem'
= -- def let
evalBloque [] (evalCom (Assign ​x ​​ne​2) (evalCom (Assign ​x​​ ne1) mem))
= -- def evalBloque . 1
evalCom (Assign ​x ​​ne​2) (evalCom (Assign ​x​​ ne1) mem)
= -- def evalCom . 1
evalCom (Assign ​x ​​ne​2) (recordar x (evalNExp ne1 mem) mem)
= -- def evalCom . 1
let mem' = (recordar x (evalNExp ne1 mem) mem) 
    in recordar x (evalNExp ne2 mem') mem'
-- Aca la idea seria que si vos guardas algo en x, y luego guardas otro algo en x,
-- la memoria se queda con el ultimo


evalProg . optimizeCf ​=​ evalProg

-- Por principio de extensionalidad, para todo b. para todo mem.
    (evalProg . optimizeCf) (Prog b) mem =​ evalProg (Prog b) mem

-- Sea b' :: Bloque totalmente definido, por ppio de induccion estructural sobre
-- la estructura de b',

-- Caso base, b' = []
-- (evalProg . optimizeCf) (Prog []) mem =​ evalProg (Prog []) mem

-- Caso inductivo, b' = (c:cs)
-- HI: (evalProg . optimizeCf) (Prog cs) mem =​ evalProg (Prog cs) mem
-- TI: (evalProg . optimizeCf) (Prog (c:cs)) mem =​ evalProg (Prog (c:cs)) mem

-- Caso base
(evalProg . optimizeCf) (Prog []) mem =​ evalProg (Prog []) mem

-- Lado izquierdo
(evalProg . optimizeCf) (Prog []) mem
= -- def (.)
evalProg (optimizeCf (Prog [])) mem
= -- def optimizeCf 
evalProg (Prog (optimizeBl [])) mem
= -- def optimizeBl . 1
evalProg (Prog []) mem


-- Lado derecho
evalProg (Prog []) mem

-- Demostrado

-- Caso inductivo
(evalProg . optimizeCf) (Prog (c:cs)) mem =​ evalProg (Prog (c:cs)) mem

-- Voy a separar en casos sobre c
-- Caso c = (Assign n ex)

-- Lado izquierdo
(evalProg . optimizeCf) (Prog ((Assign n ex):cs)) mem
= -- def (.)
evalProg (optimizeCf (Prog ((Assign n ex):cs))) mem
= -- def optimizeCf
evalProg (Prog (optimizeBl ((Assign n ex):cs))) mem
= -- def optimizeBl . 2
evalProg (Prog (optimizeCom (Assign n ex) ++ optimizeBl cs) mem
= -- def optimizeCom . 1
evalProg (Prog ([Assign n (cfNExp ex)] ++ optimizeBl cs) mem
= -- def evalProg 
evalBloque ([Assign n (cfNExp ex)] ++ optimizeBl cs) mem
= -- constructor de listas
evalBloque ((Assign n (cfNExp ex):[]) ++ optimizeBl cs) mem
= -- def (++)
evalBloque (Assign n (cfNExp ex) : ([] ++ optimizeBl cs)) mem
= -- def evalBloque . 2
let mem' = evalCom (Assign n (cfNExp ex)) mem 
        in evalBloque ([] ++ optimizeBl cs)) mem'
= -- def (++)
let mem' = evalCom (Assign n (cfNExp ex)) mem 
        in evalBloque (optimizeBl cs) mem'
= -- def let
evalBloque (optimizeBl cs) (evalCom (Assign n (cfNExp ex)) mem) 
= -- def evalCom . 1
evalBloque (optimizeBl cs) (recordar n (evalNExp (cfNExp ex) mem) mem) 
= -- propiedad evalNExp . cfNExp
evalBloque (optimizeBl cs) (recordar n (evalNExp ex mem) mem) 
= -- def evalProg
evalProg (Prog (optimizeBl cs)) (recordar n (evalNExp ex mem) mem)
= -- def optimiceCf
evalProg (optimiceCf (Prog cs)) (recordar n (evalNExp ex mem) mem)
= -- HI
evalProg (Prog cs) (recordar n (evalNExp ex mem) mem)

-- Lado derecho
evalProg (Prog ((Assign n ex):cs)) mem
= -- def evalProg 
evalBloque ((Assign n ex):cs) mem
= -- def evalBloque . 2
let mem' = evalCom (Assign n ex) mem 
                            in evalBloque cs mem'
= -- let
evalBloque cs (evalCom (Assign n ex) mem)
= -- evalCom . 1
evalBloque cs (recordar n (evalNExp ex mem) mem)
= -- def evalProg
evalProg (Prog cs) (recordar n (evalNExp ex mem) mem)

-- DEMOSTRADO

-- Caso c = (If bex b1 b2)
(evalProg . optimizeCf) (Prog ((If bex b1 b2):cs)) mem =​ evalProg (Prog ((If bex b1 b2):cs)) mem

-- Lado izquierdo
(evalProg . optimizeCf) (Prog ((If bex b1 b2):cs)) mem
= -- def (.)
evalProg (optimizeCf (Prog ((If bex b1 b2):cs))) mem
= -- def optimizeCf
evalProg (Prog (optimizeBl ((If bex b1 b2):cs))) mem
= -- def optimizeBl . 2
evalProg (Prog (optimizeCom (If bex b1 b2) ++ optimizeBl cs) mem
= -- def optimizeCom . 2
evalProg (Prog (cfIf bex b1 b2 ++ optimizeBl cs) mem
= -- aca dependo de que es bex..
-- Si pudiera pasar de lo de arriba a esto, seria un golazo. 
-- Pero para eso que tengo que hacer? Volver a dividir por casos?
evalProg (Prog ((if cfBExp bex then optimizeBl b1 else optimizeBl b2) ++ optimizeBl cs) mem

-- Lado derecho
evalProg (Prog ((If bex b1 b2):cs)) mem
= -- def evalProg 
evalBloque ((If bex b1 b2):cs) mem
= -- def evalBloque . 2
let mem' = evalCom (If bex b1 b2) mem
        in evalBloque cs mem'
= -- def let
evalBloque cs (evalCom (If bex b1 b2) mem)
= -- def evalCom . 2
evalBloque cs (if (evalBExp bex mem) then evalCom b1 mem else evalCom b2 mem)


-- Caso c = (While  bex bl)
-- HI: (evalProg . optimizeCf) (Prog ((While  bex bl):cs)) mem =​ evalProg (Prog ((While  bex bl):cs)) mem
(evalProg . optimizeCf) (Prog ((While  bex bl):cs)) mem =​ evalProg (Prog ((While  bex bl):cs)) mem
-- Sub casos

-- Caso bex = (BCte True)
(evalProg . optimizeCf) (Prog ((While (BCte True) bl):cs)) mem =​ evalProg (Prog ((While  (BCte True) bl):cs)) mem


-- Lado izquierdo
(evalProg . optimizeCf) (Prog ((While (BCte True) bl):cs)) mem
= -- def (.)
evalProg (optimizeCf (Prog ((While (BCte True) bex bl):cs))) mem
= -- def optimizeCf 
evalProg (optimizeBl (While (BCte True) bl):cs)) mem
= -- def optimizeBl . 2
evalProg ((optimizeCom (While (BCte True) bl)) ++ (optimizeBl cs)) mem
= -- def optimizeCom . 3
evalProg ((cfWhile (BCte True) bl) ++ (optimizeBl cs)) mem
= -- def cfWhile . 1
evalProg ([While (BCte True) (optimizeBl bl)] ++ (optimizeBl cs)) mem
= -- def (++)
evalProg (While (BCte True) (optimizeBl bl)):(optimizeBl cs) mem
= -- def evalProg
evalBloque (While (BCte True) (optimizeBl bl)):(optimizeBl cs) mem 
= -- def evalBloque . 2
evalBloque (optimizeBl cs) (evalCom (While (BCte True) (optimizeBl bl)) mem) 
= -- def evalProg
evalProg (Prog (optimizeBl cs)) (evalCom (While (BCte True) (optimizeBl bl)) mem)      
= -- def optimizeCf
(evalProg . optimiceCf) (Prog cs) (evalCom (While (BCte True) (optimizeBl bl)) mem)

-- Lado derecho
evalProg (Prog ((While  (BCte True) bl):cs)) mem
= -- def evalProg 
evalBloque (While (BCte True) bl):cs) mem
= -- def evalBloque . 2
let mem' = evalCom (While (BCte True) bl) mem
        in evalBloque cs mem'
= -- def let 
evalBloque cs (evalCom (While (BCte True) bl) mem)




-- Caso bex = (BCte False)
-- Caso bex cualquier otro caso












---------------------------------------------------------------------------------------------------

data DirR = Oeste | Este
data ExpR a = Lit a
            | PuedeMover Dir
            | NroBolitas            
            | HayBolitas            
            | UnOp  UOp (ExpR a)            
            | BinOp BOp (ExpR a) (ExpR a)

data UOp = No 
        | Siguiente 
        | Previo

data BOp = YTambien 
        | OBien 
        | Mas 
        | Por

type ProgramaR = ComandoR
data ComandoR = Mover DirR              
            | Poner              
            | Sacar              
            | NoOp              
            | Repetir (ExpR Int) ComandoR              
            | Mientras (ExpR Bool) ComandoR              
            | Secuencia ComandoR ComandoR

-- Tablero

mover :: DirR -> TableroR -> TableroR​
poner :: TableroR -> TableroR​
sacar :: TableroR -> TableroR
nroBolitas :: TableroR -> Int
hayBolitas :: TableroR -> Bool
puedeMover :: DirR -> TableroR -> Bool
boom :: String -> a​

evalExpRInt :: ExpR Int -> TableroR -> Int
evalExpRInt (Lit n)               tab = n
evalExpRInt (NroBolitas)          tab = nroBolitas tab
evalExpRInt (UnOp uop exp)        tab = evalUnOpInt uop exp tab
evalExpRInt (BinOp bop exr1 exr2) tab = evalBinOpInt bop exr1 exr2 tab

evalBinOpInt :: BOp -> ExpR Int -> ExpR Int -> TableroR -> Int
evalBinOpInt Mas exp1 ep2 tab = evalExpRInt exp1 tab + evalExpRInt exp2 tab
evalBinOpInt Por exp1 ep2 tab = evalExpRInt exp1 tab * evalExpRInt exp2 tab

evalUnOpInt :: UOp -> ExpR Int -> TableroR -> Int
evalUnOpInt Siguiente exp tab = evalExpRInt exp + 1
evalUnOpInt Previo exp    tab = evalExpRInt exp - 1

evalExpRBool :: ExpRBool -> TableroR -> Bool
evalExpRBool (Lit b)                 tab = b
evalExpRBool (PuedeMover dir)        tab = puedeMover dir tab
evalExpRBool (HayBolitas)            tab = hayBolitas tab
evalExpRBool (UnOp uop expb)         tab = evalUnOpBool uop expb tab
evalExpRBool (BinOp bop expb1 expb2) tab = evalBinOpBool bop expb1 expb2 tab

evalUnOpBool :: UOp -> ExpR Bool -> TableroR -> Bool
evalUnOpBool No expb tab = not (evalExpRBool expb)

evalBinOpBool :: BOp -> ExpR Bool -> ExpR Bool -> TableroR -> Bool
evalBinOpBool YTambien expb1 expb2 tab = evalExpRBool expb1 && evalExpRBool expb2
evalBinOpBool OBien expb1 expb2    tab = evalExpRBool expb1 || evalExpRBool expb2

expRTieneTipoInt :: ExpRInt -> Bool​
expRTieneTipoInt (Lit x)               = -- Aca tendria que preguntar por el tipo de x?
expRTieneTipoInt NroBolitas            = True
expRTieneTipoInt (PuedeMover d)        = False
expRTieneTipoInt HayBolitas            = False
expRTieneTipoInt (UnOp uop exp)        = uOpTieneTipoInt uop && expRTieneTipoInt exp
expRTieneTipoInt (BinOp bop exp1 exp2) = binOpTieneTipoInt uop && expRTieneTipoInt exp1 && expRTieneTipoInt exp2

uOpTieneTipoInt :: UnOp -> Bool
uOpTieneTipoInt No        = False
uOpTieneTipoInt Siguiente = True
uOpTieneTipoInt Previo    = True

binOpTieneTipoInt :: BinOp -> Bool
binOpTieneTipoInt YTambien = False
binOpTieneTipoInt OBien    = False
binOpTieneTipoInt Mas      = True
binOpTieneTipoInt Por      = True
