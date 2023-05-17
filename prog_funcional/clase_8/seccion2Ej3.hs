type NBin = [DigBin]

data DigDec = D0 | D1 | D2 | D3 | D4
| D5 | D6 | D7 | D8 | D9

data DigBin = O | I

evalNB :: Nbin -> Int
evalNB  []  = 0
evalNB nbin = evalNB' 0 nbin

evalNB' :: Int -> Nbin -> Int -> Int
evalNB' n (b:[]) = dbAsInt b * 2 ^ n
evalNB' n (b:bs) = dbAsInt b * 2 ^ n + evalNB' n bs

normalizarNB :: NBin -> NBin
normalizarNB [] = 0
normalizarNB 