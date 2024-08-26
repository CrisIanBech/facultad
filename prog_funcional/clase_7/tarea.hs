data Fila a = Fin
            | Celda Int a (Fila a)


f Fin =  
f (Celda n x fila) = n x (f fila)

-- cuenta la cantidad de veces que aparece un elemento que cumple el predicado
countF :: (a -> Bool) -> Fila a -> Int
countF f Fin = 0
countF f (Celda n x fila) = if(f x) then 1 + countF f fila else 0 + countF f fila

-- le suma N a los elementos donde el predicado da verdadero
sumarN :: (a -> Bool) -> Int -> Fila a -> Fila a
sumarN f n Fin = Fin
sumarN f n (Celda m x fila) = if(f x) then (Celda m (x+n) (sumarN fila)) else (Celda m x (sumarN fila))

-- Junta dos filas manteniendo el orden de los elementos
concatenarF :: Fila a -> Fila a -> Fila a
concatenarF Fin f = f
concatenarF (Celda n x fila) f = Celda n x (concatenarF fila f)

-- transforma cada elemento aplicando una función a los mismos
mapF :: (a -> b) -> Fila a -> Fila b
mapF f Fin = Fin
mapF f (Celda n x fila) = Celda n (f x) (mapF fila)

-- transforma una fila de filas en una fila
aplanar :: Fila (Fila a) -> Fila a 
aplanar Fin = Fin
aplanar (Celda m filas fila) = aplanar' filas (aplanar fila)

multN :: Int -> Fila a -> Fila a
multN n Fin = Fin
multN n (Celda m x fila) = (Celda (m*n) x (multN n fila))

-- los elementos iguales los colapsa en una misma posición (sean contiguos o no)
agruparIguales :: Eq a => Fila a -> Fila agruparIguales
agruparIguales Fin = Fin
agruparIguales (Celda n x fila) = agruparASuIgual n x (agruparIguales fila)

agruparASuIgual :: Int -> a -> Fila a -> Fila a
agruparASuIgual n x Fin = Celda n x Fin
agruparASuIgual n x (Celda m y fila) = 
        if x == y
            then Celda (n + m) x fila
            else Celda m y (agruparASuIgual n x fila)

-- denota la composición de las funciones manteniendo el orden de aparición y aplicandolas las veces que aparezca
componer :: Fila (a -> a) -> (a -> a)
componer Fin = id
componer (Celda n f fila) = many n f . componer fila


-- Tarea:

data Functions a =  Id 
                    | F (a -> a) (Functions a)
                    | B (a -> Bool) (Functions a) (Functions a)

evalF :: Functions a -> (a -> a)
manyF :: Int -> (a -> a) -> Functions a
toFila :: Functions a -> Fila a