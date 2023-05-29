type NBin = [DigBin]

data DigDec = D0 | D1 | D2 | D3 | D4
| D5 | D6 | D7 | D8 | D9

data DigBin = O | I

evalNB :: NBin -> Int
evalNB  []  = 0
evalNB nbin = evalNB' 0 nbin

evalNB' :: Int -> NBin -> Int -> Int  
evalNB' n []     = 0
evalNB' n (b:bs) = dbAsInt b * 2 ^ n + evalNB' n + 1 bs

normalizarNB :: NBin -> NBin
normalizarNB [] = []
normalizarNB (b:bs) = removerCerosExtra b normalizarNB bs

removerCerosExtra :: DigBin -> NBin -> NBin
removerCerosExtra db [] = [db]
removerCerosExtra db bs = if(all (0==) bs) 
                                then [db]
                                else db : bs

succNB :: NBin -> NBin
succNB bs = addBin I bs

addBin :: DigBin -> NBin -> NBin
addBin O bs = bs
addBin I (b:bs) = sumarI b bs

sumarI :: DigBin -> NBin -> NBin
sumarI I bs = I : addBin I bs 
sumarI O bs = I : bs

addNB :: NBin -> NBin -> NBin
addNB b b' = addNBConCarry b b' O 

-- Prec, NBin no deben de ser []
addNBConCarry :: NBin -> NBin -> DigBin -> NBin
addNBConCarry [] [] c = vacioSiO
addNBConCarry [] bs c = addNBConCarry nBinZero bs c  
addNBConCarry bs [] c = addNBConCarry bs nBinZero c
addNBConCarry (b:bs) (b':bs') c = let (bit, carry) = addDBConCarry b b' c
                                    in bit: addNBConCarry bs bs' carry

vacioSiO O = []
vacioSiO I = [I]

addDBConCarry :: DigBin -> DigBin -> DigBin -> (DigBin, DigBin)
addDBConCarry I I I = (I, I)
addDBConCarry O I I = (O, I)
addDBConCarry I O I = (O, I)
addDBConCarry I I O = (O, I)
addDBConCarry I O O = (I, O)
addDBConCarry O I O = (I, O)
addDBConCarry O O I = (I, O)
addDBConCarry _ _ _ = (O, O)

nBinZero = [O]
nBinOne = [I]

nb2n :: NBin -> N
nb2n nb = nb2n' nb 0

nb2n' :: NBin -> Int -> N
nb2n' [] n     = Z
nb2n' (b:bs) n = addN nFromNB b n nb2n' bs n + 1

nFromNB = int2N dbAsInt b * 2 ^ n

n2nb :: N -> NBin
n2nb Z = nBinZero
n2nb (S n) = addNB nBinOne n2nb n  


b.
    i.
    Prop.: ¿evalNB . normalizarNB = evalNB?
    Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
    ¿para todo x :: NBin. evalNB . normalizarNB x = evalNB x?

    Sea n :: NBin
    Por ppio. de inducción en la estructura de NBin:
    ¿evalNB . normalizarNB n = evalNB n?

    Caso base: n = [] )
        ¿evalNB . normalizarNB [] = evalNB []?

    Caso inductivo: n = (b:bs) )
        HI) ¡evalNB . normalizarNB bs = evalNB bs!
        TI) ¿evalNB . normalizarNB (b:bs) = evalNB (b:bs)?

    Dem.:
    Caso base:

    LI:
    evalNB . normalizarNB []
    = def. op. .
    evalNB (normalizarNB [])
    = def. normalizarNB.1
    evalNB []
    = def. evalNB.1
    0

    LD:
    evalNB []
    = def. evalNB.1
    0

    Se cumpe para este caso

    Caso inductivo:

    LI:
    evalNB . normalizarNB (b:bs)
    = def. op. .
    evalNB (normalizarNB (b:bs))
    = def. normalizarNB.2
    evalNB (removerCerosExtra b normalizarNB bs)

    Segun analisis de casos:
        bs = []
        evalNB (removerCerosExtra b normalizarNB [])
        = def. normalizarNB.1
        evalNB (removerCerosExtra b [])
        = def. removerCerosExtra.1
        evalNB [b]
        = def. evalNB.2
        evalNB' 0 [b]
        = def. evalNB'.2
        dbAsInt b * 2 ^ 0 + evalNB' 0 + 1 []
        = aritmetica
        dbAsInt b * 2 ^ 0 + evalNB' 1 []
        = def. evalNB'.1
        dbAsInt b * 2 ^ 0 + 0
        = aritmetica
        dbAsInt b * 2 ^ 0

        bs = bs'
        evalNB (removerCerosExtra b normalizarNB bs')
        = def. 





    LD:
    evalNB (b:bs)
    = def. evalNB.2
    evalNB' 0 (b:bs)
    = def. evalNB.2
    dbAsInt b * 2 ^ 0 + evalNB' n + 1 bs


    NO LO PUDE HACER


    i.
    Prop.: ¿evalNB . succNB = (+1) . evalNB?
    Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
    ¿para todo x :: NBin. evalNB . succNB x = (+1) . evalNB x?

    Sea n :: NBin
    Por ppio. de inducción en la estructura de NBin:
    ¿evalNB . succNB n = (+1) . evalNB n?

    Caso base: n = [] )
        ¿evalNB . succNB [] = (+1) . evalNB []?

    Caso inductivo: n = (b:bs) )
        HI) ¡evalNB . succNB bs = (+1) . evalNB bs!
        TI) ¿evalNB . succNB (b:bs) = (+1) . evalNB (b:bs)?

    Dem. caso base:
    LI:
    evalNB . succNB []
    = def. caso .
    evalNB (succNB [])
    = def. succNB.1
    evalNB ()