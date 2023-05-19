data N = Z | S N

-- Intenta describir representaciones unarias de números naturales

a)
    evalN :: N -> Int
    evalN Z = 0
    evalN (S n) = 1 + evalN n

    addN :: N -> N -> N
    addN Z n = n
    addN (S n) n2 = (S (addN n n2))

    prodN :: N -> N -> N
    prodN Z n = Z
    prodN (S n1) n = addN n (prodN n1 n)

    int2N :: Int -> n
    int2N 0 = Z
    int2N n = (S (int2N n - 1))

    b)
    i. 
    PROP.: ¿para todo n1. para todo n2. evalN (addN n1 n2) = evalN n1 + evalN n2?
    DEM.: Por ppio de inducción en la estructura de n1 y n2, es equivalente demostrar que:
        ¿para todo m1. para todo m2. evalN (addN m1 m2) = evalN m1 + evalN m2?

    CASO BASE, m1 = Z)
        ¿evalN (addN Z m2) = evalN Z + evalN m2
    CASO INDUCTIVO, m1 = S n)
        HI) ¿evalN (addN n m2) = evalN n + evalN m2!
        TI) ¿evalN (addN (S n) m2) = evalN (S n) + evalN m2?

    Dem. caso base:
        LI:
        evalN (addN Z m2)
        =  def. addN.1  
        evalN m2

        LD:
        evalN Z + evalN m2
        = evalN.1
        0 + evalN m2
        = aritmetica
        evalN m2

    Dem. caso inductivo:
        LI:
        evalN (addN (S n) m2)
        = def. addN.2
        evalN (S (addN n m2))
        = def. evalN.2
        1 + evalN (addN n m2)
        = HI
        1 + evalN n + evalN m2

        LD:
        evalN (S n) + evalN m2
        = def. evalN.2
        1 + evalN n + evalN m2

        Vale en ambos casos. Se cumple la propiedad.

    ii.
    PROP.: ¿para todo n1. para todo n2. evalN (prodN n1 n2) = evalN n1 * evalN n2?
    DEM.: Según ppio. de inducción en la estructura de n1, equivalente demostrar que:
    ¿para todo m1. para todo m2. evalN (prodN m1 m2) = evalN m1 * evalN m2?

    Caso base: m1 = Z)
        ¿evalN (prodN Z m2) = evalN Z * evalN m2?

    Caso inductivo: m1 = S n)
        HI) ¡evalN (prodN n m2) = evalN n * evalN m2!
        TI) ¿evalN (prodN (S n) m2) = evalN (S n) * evalN m2?

    Dem. caso base:
        LI:
        evalN (prodN Z m2)
        = def. prodN.1
        evalN Z
        = def. evalN.1
        0

        LD:
        evalN Z * evalN m2
        = def. evalN.1
        0 * evalN m2
        = aritmetica
        0

    Dem. caso inductivo:
        LI:
        evalN (prodN (S n) m2)
        = def prodN.2
        evalN (addN m2 (prodN n m2))
        = lema b) i.
        evalN m2 + evalN (prodN n m2)
        = HI
        evalN m2 + evalN n * evalN m2
        = aritmética 
        evalN m2 * (1 + evalN n)
        = conmutividad de la multiplicacion
        (1 + evalN n) * evalN m2

        LD:
        evalN (S n) * evalN m2
        =
        (1 + evalN n) * evalN m2
        

        Vale en ambos casos. Se cumple la propiedad.

        iii.
        PROP.: ¿int2N . evalN = id?
        DEM.: Sea x :: N. Según ppio. de inducción en la estructura de x, equivalente demostrar que:
            ¿para todo x. int2N . evalN x = id x?

        Caso base: x = Z)
            ¿int2N . evalN Z = id Z?

        Caso inductivo: x = S n)
            HI) ¡int2N . evalN n = id n!
            TI) ¿int2N . evalN (S n) = id (S n)?

        Dem. caso base:
            LI:
            int2N . evalN Z
            = def. operador .
            int2N (evalN Z)
            = def. evalN.1
            int2N 0
            = def. int2N.1
            Z

            LD:
            id Z
            = def. id
            Z

        Dem. caso inductivo:
            LI: 
            int2N . evalN (S n)
            = 
            int2N (evalN (S n))
            =
            int2N (1 + evalN n)
            =
            (S (int2N (1 + evalN n) - 1))
            =
            (S (int2N evalN n))
            = def. op .
            (S int2N . evalN n)
            = HI
            (S id n)
            = def. id
            S n


            LD:
            id (S n)
            =
            S n

            iv.
            PROP.: ¿evalN . int2N = id?
            DEM.: Sea x :: N. Según ppio. de inducción en la estructura de x, equivalente demostrar que:
                ¿para todo x :: Int. evalN . int2N x = id x?

            Caso base: x = 0)
                ¿evalN . int2N 0 = id 0?

            Caso inductivo: x = n)
                HI) ¡evalN . int2N n - 1 = id n - 1!
                TI) ¿evalN . int2N n = id n?

            Dem. caso base:
                LI:
                evalN . int2N 0
                =
                evalN (int2N 0)
                =
                evalN Z
                =
                0

                LD:
                id 0
                = def. id
                0

            Dem. caso inductivo:
                LI:
                evalN . int2N n
                =
                evalN (int2N n)
                =
                evalN ((S (int2N n - 1)))
                =
                1 + evalN (int2N n - 1)
                = def. op. .
                1 + id n - 1
                = aritmética
                id n
                = def. id
                n
                

                LD:
                id n
                =
                n
                