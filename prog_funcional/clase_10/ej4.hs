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
