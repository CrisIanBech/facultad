type NBin = [DigBin]

data DigDec = D0 | D1 | D2 | D3 | D4
| D5 | D6 | D7 | D8 | D9

data DigBin = O | I

evalNB :: Nbin -> Int
evalNB  []  = 0
evalNB nbin = evalNB' 0 nbin

evalNB' :: Int -> Nbin -> Int -> Int  
evalNB' n []     = 0
evalNB' n (b:bs) = dbAsInt b * 2 ^ n + evalNB' n + 1 bs

normalizarNB :: NBin -> NBin
normalizarNB [] = []
normalizarNB (b:bs) = removerCerosExtra b normalizarNB bs

removerCerosExtra :: DigBin -> Nbin -> Nbin
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




