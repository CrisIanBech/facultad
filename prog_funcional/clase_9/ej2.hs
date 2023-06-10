data Arbol a b = Hoja b | Nodo a (Arbol a b) (Arbol a b)

cantidadDeHojas :: Arbol a b -> Int
cantidadDeHojas (Hoja h) = 1
cantidadDeHojas (Nodo n arb1 arb2) = cantidadDeHojas arb1 + cantidadDeHojas arb2

cantidadDeNodos :: Arbol a b -> Int
cantidadDeNodos (Hoja h) = 0
cantidadDeNodos (Nodo n arb1 arb2) = 1 + cantidadDeNodos arb1 + cantidadDeNodos arb2

cantidadDeConstructores :: Arbol a b -> Int
cantidadDeConstructores (Hoja h) = 1
cantidadDeConstructores (Nodo n arb1 arb2) = 1 + cantidadDeConstructores arb1 + cantidadDeConstructores arb2

data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum | Mul

ea2Arbol :: EA -> Arbol BinOp Int
ea2Arbol (Const n) = Hoja n
ea2Arbol (BOp binOp exp1 exp2) = Nodo binOp ea2Arbol exp1 binOp exp2


b:
    Prop.:
        ¿para todo t :: Arbol a b
        cantidadDeHojas t + cantidadDeNodos t
        = cantidadDeConstructores t?
    Dem.: Por ppio.de inducción en la estructura de t, es equivalente demostrar
    que:
        sea n :: Arbol a b

    Caso base: n = Hoja b
        ¿cantidadDeHojas (Hoja b) + cantidadDeNodos (Hoja b) = cantidadDeConstructores (Hoja b)?

    Caso inductivo: n = Nodo a a1 a2
        HI.1) ¡cantidadDeHojas a1 + cantidadDeNodos a1 = cantidadDeConstructores a1!
        HI.2) ¡cantidadDeHojas a2 + cantidadDeNodos a2 = cantidadDeConstructores a2!
        TI) ¿cantidadDeHojas (Nodo a a1 a2) + cantidadDeNodos (Nodo a a1 a2) = cantidadDeConstructores (Nodo a a1 a2)?

    Dem. caso base:
        LI:
        cantidadDeHojas (Hoja b) + cantidadDeNodos (Hoja b)
        = def. cantidadDeHojas.1
        1 + cantidadDeNodos (Hoja b)
        = def. cantidadDeNodos
        1 + 0
        = aritmetica
        1

        LD:
        cantidadDeConstructores (Hoja b)
        = def. cantidadDeConstructores.1
        1

        Se llega al mismo resultado. Vale para este caso.


    Dem. caso inductivo:
        LI:
        cantidadDeHojas (Nodo a a1 a2) + cantidadDeNodos (Nodo a a1 a2)
        = def. cantidadDeHojas.2
        cantidadDeHojas a1 + cantidadDeHojas a2 + cantidadDeNodos (Nodo a a1 a2)
        = def. cantidadDeNodos.2
        cantidadDeHojas a1 + cantidadDeHojas a2 + 1 + cantidadDeNodos a1 + cantidadDeNodos a2
        = s. asociatividad de la suma y conmutividad
        (cantidadDeHojas a1 + cantidadDeNodos a1) + (cantidadDeHojas a2 + cantidadDeNodos a2) + 1
        = HI.1 y HI.2
        cantidadDeConstructores a1 + cantidadDeConstructores a2 + 1

        LD:
        cantidadDeConstructores (Nodo a a1 a2)
        = def. cantidadDeConstructores.2
        1 + cantidadDeConstructores a1 + cantidadDeConstructores a2
        = conmutividad de la suma
        cantidadDeConstructores a1 + cantidadDeConstructores a2 + 1

        Se llega al mismo resultado. Vale este caso, y por lo tanto, la propiedad.
        

