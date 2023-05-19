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
addNU (x:xs) ys = x : addNU xs ys

nu2n :: NU -> N
nu2n [] = Z
nu2n (x:xs) = (S (nu2n xs))

n2nu :: N -> NU 
n2nu Z = []
n2nu (S n) = () : (n2nu n)


b.

i.
    PROP.: ¿evalNU . succNU = (+1) . evalNU?
    DEM.: Sea x :: NU. Según ppio. de inducción en la estructura de x, equivalente demostrar que:
        ¿para todo x :: NU. evalNU . succNU = (+1) . evalNU?

    Caso base: x = [])
        ¿evalNU . succNU [] = (+1) . evalNU []?

    Caso inductivo: x = (():xs))
        HI) ¡evalNU . succNU xs = (+1) . evalNU xs!
        TI) ¿evalNU . succNU (():xs) = (+1) . evalNU (():xs)?

    Dem. caso base:
    LI:
    evalNU . succNU []
    =
    evalNU (succNU [])
    =
    evalNU [()]
    =
    1 + evalNU []
    =
    1 + 0
    =
    1

    LD:
    (+1) . evalNU []
    =
    (+1) (evalNU [])
    =
    (+1) 0
    =
    1

    Dem. caso inductivo:
    LI:
    evalNU . succNU (():xs)
    =
    evalNU (succNU (():xs))
    =
    evalNU (succNU (():xs))
    =
    evalNU (() : succNU xs)
    =
    1 + evalNU (succNU xs)
    = def. operador .
    1 + evalNU . succNU xs
    = HI
    1 + (+1) . evalNU xs
    = def. op. .
    1 + (+1) (evalNU xs)

    LD:
    (+1) . evalNU (():xs)
    =
    (+1) (evalNU (():xs))
    =
    (+1) (1 + evalNU xs)
    = def. op. (+)
    (+1) (+1) evalNU xs
    = def op (+)
    1 + (+1) evalNU xs
    

    Se cumple para ambos casos. Es válida la propiedad.

    ii.
    PROP.: ¿para todo n1. para todo n2. evalNU (addNU n1 n2) = evalNU n1 + evalNU n2?
    DEM.: Según ppio. de inducción en la estructura de n1, equivalente demostrar que:

    Caso base: n1 = [])
        ¿evalNU (addNU [] n2) = evalNU [] + evalNU n2?

    Caso inductivo: x = (():xs))
        HI) ¡evalNU (addNU xs n2) = evalNU xs + evalNU n2!
        TI) ¿evalNU (addNU (():xs) n2) = evalNU (():xs) + evalNU n2?

    Dem. caso base:
        LI:
        evalNU (addNU [] n2)
        = def. addNU
        evalNU n2

        LD:
        evalNU [] + evalNU n2
        = def. evalNU
        0 + evalNU n2
        = aritmetica
        evalNU n2

    Dem. caso inductivo:
        LI:
        evalNU (addNU (():xs) n2)
        = def. addNU
        evalNU (x : addNU xs n2)
        =
        1 + evalNU (addNU xs n2)

        LD:
        evalNU (():xs) + evalNU n2
        = def evalNU.2
        1 + evalNU xs + evalNU n2
        = HI
        1 + evalNU (addNU xs n2)

    Se cumple para ambos casos. Vale la propiedad.


    iv.
    PROP.: ¿para todo nu :: NU. n2nu . nu2n nu = id nu?
    DEM.: Según ppio. de inducción en la estructura de nu, equivalente demostrar que:

    Caso base: nu = [])
        ¿n2nu . nu2n [] = id []?

    Caso inductivo: n = (():xs) )
        HI) ¡n2nu . nu2n xs = id xs!
        TI) ¿n2nu . nu2n (():xs) = id (():xs)?

    Dem. caso base:
        LI:
        n2nu . nu2n []
        = def. op. .
        n2nu (nu2n [])
        = def. nu2n
        n2nu Z
        = def. n2nu
        []
        

        LD:
        id []
        = def. id
        []

    Dem. caso inductivo:
        LI:
        n2nu . nu2n (():xs)
        = def. op. .
        n2nu (nu2n (():xs))
        = def. nu2n
        n2nu (S (nu2n xs))
        = def. n2nu
        () : (n2nu (nu2n xs))
        = def. op. .
        () : (n2nu . nu2n xs)
        = HI
        () : id xs
        = def. id
        ():xs
        
        LD:
        id (():xs)
        = def. id
        ():xs


        Se cumple para ambos casos. Se cumple la propiedad.

        
         iii.
    PROP.: ¿para todo n :: N. nu2n . n2nu n = id n?
    DEM.: Según ppio. de inducción en la estructura de n, equivalente demostrar que:

    Caso base: n = Z)
        ¿nu2n . n2nu Z = id Z?

    Caso inductivo: n = (S m) )
        HI) ¡nu2n . n2nu m = id m!
        TI) ¿nu2n . n2nu (S m) = id (S m)?

    Dem. caso base:
        LI:
        nu2n . n2nu Z
        = def. op. .
        nu2n (n2nu Z)
        = def. n2nu 
        nu2n []
        = def. nu2n
        Z

        LD:
        id Z
        = def. id
        Z

    Dem. caso inductivo:
        LI:
        nu2n . n2nu (S m)
        = def. op. .
        nu2n (n2nu (S m))
        = def. n2nu
        nu2n (() : (n2nu m))
        = 
        (S (n2nu (n2nu m)))
        = def. op. .
        (S n2nu . n2nu m)
        = HI
        S id m
        = def. id
        S m

        =
        LD:
        id (S m)
        = def. id
        S m