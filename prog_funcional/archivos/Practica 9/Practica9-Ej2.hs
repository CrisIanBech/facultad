data Arbol a b = Hoja b | Nodo a (Arbol a b) (Arbol a b)

a) Implementar

i) 
cantidadDeHojas :: Arbol a b -> Int
cantidadDeHojas Hoja _ = 1
cantidadDeHojas Nodo _ (a1) (a2) = cantidadDeHojas a1 + cantidadDeHojas a2

ii)
cantidadDeNodos :: Arbol a b -> Int
cantidadDeNodos Hoja _ = 0
cantidadDeNodos Nodo _ (a1) a2) = 1 + cantidadDeNodos a1 + cantidadDeNodos a2

iii)
cantidadDeConstructores :: Arbol a b -> Int
cantidadDeConstructores Hoja _ = 1
cantidadDeConstructores Nodo _ (a1) (a2) = 1 + cantidadDeConstructores a1+ cantidadDeConstructores a2


iv)
data EA = Const Int | BOp BinOp EA EA
data BinOp = Sum | Mul
a = BinOp
b = Int

ea2Arbol :: EA -> Arbol BinOp Int
ea2Arbol (Const n) = Hoja n
ea2Arbol (BOp bp e1 e2) = Nodo bp (ea2Arbol e1) (ea2Arbol e2)


