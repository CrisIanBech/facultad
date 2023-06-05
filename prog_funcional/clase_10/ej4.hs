data DirR = Oeste | Este
data ExpR a = Lit a
        | PuedeMover Dir
        | NroBolitas
        | HayBolitas
        | UnOp UOp (ExpR a)
        | BinOp BOp (ExpR a) (ExpR a)

data UOp = No | Siguiente | Previo
data BOp = YTambien | OBien | Mas | Por

type ProgramaR = ComandoR
data ComandoR = Mover DirR
                    | Poner
                    | Sacar
                    | NoOp
                    | Repetir (ExpR Int) ComandoR
                    | Mientras (ExpR Bool) ComandoR
                    | Secuencia ComandoR ComandoR

-- Tad TableroR
tableroInicial :: Int -> TableroR
mover :: DirR -> TableroR -> TableroR
poner :: TableroR -> TableroR
sacar :: TableroR -> TableroR
nroBolitas :: TableroR -> Int
hayBolitas :: TableroR -> Bool
puedeMover :: DirR -> TableroR -> Bool
boom :: String -> TableroR -> a

-- Ej
evalExpRInt :: ExpR Int -> TableroR -> Int
evalExpRInt (Lit n)                     tablero = n
evalExpRInt (PuedeMover dir)            tablero = boom "La expresión dada no es de tipo Int" tablero
evalExpRInt (NroBolitas)                tablero = nroBolitas tablero
-- evalExpRInt (HayBolitas)                tablero = hayBolitas tablero
evalExpRInt (HayBolitas)                tablero = boom "La expresión dada no es de tipo Int" tablero
-- evalExpRInt (UnOp uop expr)             tablero = evalUOp uop expr
evalExpRInt (UnOp uop expr)             tablero = boom "La expresión dada no es de tipo Int" tablero
evalExpRInt (BinOp bop exp1 exp2)       tablero = evalBinopInt bop (evalExpRInt exp1 tablero) (evalExpRInt exp2 tablero) tablero

evalBinopInt :: BOp -> Int -> Int -> TableroR -> Int
evalBinopInt (YTambien) n1 n2 = boom "La expresión dada no es de tipo Int" tablero
evalBinopInt (OBien) n1 n2    = boom "La expresión dada no es de tipo Int" tablero
evalBinopInt (Mas)            = (+)
evalBinopInt (Por)            = (*)

evalExpRBool :: ExpR Bool -> TableroR -> Bool
evalExpRBool (Lit n)                     tablero = n
evalExpRBool (PuedeMover dir)            tablero = puedeMover dir tablero
evalExpRBool (NroBolitas)                tablero = boom "La expresión dada no es de tipo Bool" tablero
evalExpRBool (HayBolitas)                tablero = hayBolitas tablero
evalExpRBool (UnOp uop expr)             tablero = evalUnopBool uop (evalExpRBool expr) tablero
evalExpRBool (BinOp bop exp1 exp2)       tablero = evalBinopBool bop tablero (evalExpRBool exp1 tablero) (evalExpRBool exp2 tablero)

evalUnopBool :: UOp -> Bool -> TableroR -> Bool
evalUnopBool (No) = not
evalUnopBool _    = boom "La expresión dada no es de tipo Bool"

evalBinopBool :: BOp -> TableroR -> Bool -> Bool -> Bool
evalBinopBool (YTambien) t = (&&)
evalBinopBool (OBien)    t = (||)
evalBinopBool _          t = boom "La expresión dada no es de tipo Bool" t

-- Falta ej iii y iv

evalR :: ComandoR -> TableroR -> TableroR
evalR (Mover dir)               t = moverEnTablero dir t
evalR (Poner)                   t = poner t
evalR (Sacar)                   t = sacarSiPuede t
evalR (NoOp)                    t = t
evalR (Repetir exprInt com)     t = many (evalExpRInt exprInt t) (evalR com) t
evalR (Mientras exprBool com)   t = mientrasB (evalExpRBool exprBool t) com t
evalR (Secuencia com com)       t = exSec com com t

moverEnTablero :: DirR -> TableroR -> TableroR
moverEnTablero dir t = if(puedeMover dir) then mover dir t else boom "No puede moverse a la dirección dada" t

mientrasB :: Bool -> ComandoR -> TableroR -> TableroR
mientrasB b cm t = if(b) then evalR (Secuencia cm cm) t else evalR (Secuencia cm (NoOp))

exSec :: ComandoR -> ComandoR -> TableroR -> TableroR
exSec cm1 cm2 t = evalR cm2 (evalR cm1 t)

cantSacar :: ComandoR -> Int
evalR (Sacar)                   t = 1
evalR (Secuencia com1 com2)     t = cantSacar com1 + cantSacar com2
evalR (Repetir exprInt com)     t = cantSacar com * (evalBinopInt exprInt t) -- La cantidad es operacional o literal?
evalR (Mientras exprBool com)   t = cantSacar com
evalR (Mover dir)               t = 0
evalR (Poner)                   t = 0
evalR (NoOp)                    t = 0

seqN :: Int -> ComandoR -> ComandoR
seqN 0 c = NoOp
seqN n c = Secuencia c (seqN n - 1 c)

repeat2Seq :: ComandoR -> ComandoR
repeat2Seq (Repetir exprInt com) = seqN (evalExpRInt exprInt) com
repeat2Seq c                     = c