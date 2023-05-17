type NU = [()]

-- Simil

data Unit = Unit

evalNU :: NU -> Int
evalNU [] = 0
evalNU (x:xs) = 1 + evalNU xs

succNU :: NU -> NU
succNU [] = [()]
succNU (x:xs) = x : succNU xs

addNU :: NU -> NU -> NU 
addNU [] xs = xs
addNU xs [] = xs
addNU (x:xs) (y:ys) =  x : y : addNU xs ys

nu2n :: NU -> N
nu2n [] = Z
nu2n (x:xs) = (S (nu2n xs))

n2nu :: N -> NU 
n2nu Z = []
n2nu (S n) = () : (n2nu n)


