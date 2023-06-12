data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

sumarT :: Tree Int -> Int
sumarT EmptyT = 0
sumarT (NodeT n t1 t2) = n + sumarT t1 + sumarT t2

sizeT :: Tree a -> Int
sizeT EmptyT = 0
sizeT (NodeT n t1 t2) = 1 + sizeT t1 + sizeT t2

anyT :: (a -> Bool) -> Tree a -> Bool
anyT p (EmptyT) = False
anyT p (NodeT n t1 t2) = p n || anyT p t1 || anyT p t2

countT :: (a -> Bool) -> Tree a -> Int
countT p EmptyT = 0
countT p (NodeT n t1 t2) = unoSiCeroSino p n + countT p t1 + countT p t2

unoSiCeroSino :: Bool -> Int
unoSiCeroSino True = 1
unoSiCeroSino False = 0

countLeaves :: Tree a -> Int
countLeaves EmptyT = 0
countLeaves (NodeT n t1 t2) = 1 + countLeaves t1 + countLeaves t2

heightT :: Tree a -> Int 
heightT EmptyT = 0
heightT (NodeT n t1 t2) = 1 + max heightT t1 heightT t2

inOrder :: Tree a -> [a]
inOrder EmptyT = []
inOrder EmptyT = (NodeT h t1 t2) = inOrder t1 ++ [h] ++ inOrder t2

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT = []
listPerLevel (NodeT h t1 t2) = [h] : (mergeTa (listPerLevel t1) (listPerLevel t2))

mergeTa :: [[a]] -> [[a]] -> [[a]]
mergeTa [] yss = yss
mergeTa xss [] = xss
mergeTa (xs:xss) (ys:yss) = (xs ++ ys) : (mergeTa xss yss)

mirrorT :: Tree a -> Tree a
mirrorT EmptyT = EmptyT
mirrorT (NodeT h t1 t2) = (NodeT h mirrorT t2 mirrorT t1)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT = []
levelN 0 (NodeT h t1 t2) = [h]
levelN n (NodeT h t1 t2) = levelN n - 1 t1 ++ levelN n - 1 t2

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT = []
ramaMasLarga (NodeT h t1 t2) = [h] ++ ramaMasLarga' ramaMasLarga t1 ramaMasLarga t2

ramaMasLarga' :: [a] -> [a] -> [a]
ramaMasLarga' t1 t2 = if(length t1 > length t2) 
                            then t1
                            else t2


todosLosCaminos :: Tree a -> [[a]] 
todosLosCaminos EmptyT = []
todosLosCaminos (NodeT h t1 t2) = addToEveryList h t1 ++ addToEveryList h t2

addToEveryList :: a -> [[a]] -> [[a]]
addToEveryList e [] = []
addToEveryList e (xs:xss) = (e:xs) ++ addToEveryList e xss

b.

i.
    Prop.: ¿heightT = length . ramaMasLarga?
    Dem.: Por ppio. de extensionalidad, es equivalente demostrar que:
        ¿Para todo a :: Tree a. heightT a = length . ramaMasLarga a?

        Sea t :: Tree a.
        Por ppio de induccion sobre la esturctura de t, es equivalente demostrar que:
        ¿heightT t = length . ramaMasLarga t?

    Caso base: t = EmptyT
        ¿heightT (EmptyT) = length . ramaMasLarga (EmptyT)?

    Caso inductivo: t = NodeT e t1 t2
        HI.1) ¡heightT t1 = length . ramaMasLarga t1!
        HI.2) ¡heightT t2 = length . ramaMasLarga t2!
        TI) ¿heightT (NodeT e t1 t2) = length . ramaMasLarga (NodeT e t1 t2)?

    Dem. caso base:
        LI:
        heightT (EmptyT)
        = def. heightT
        0

        LD:
        length . ramaMasLarga (EmptyT)
        = def. op. .
        length (ramaMasLarga (EmptyT))
        = def. ramaMasLarga.1
        length []
        = def.length
        0

    Se llega al mismo resultado. Vale este caso.

    Dem. caso inductivo:
        LI:
        heightT (NodeT e t1 t2)
        = def. heightT
        1 + max (heightT t1) (heightT t2)

        LD:
        length . ramaMasLarga (NodeT e t1 t2)
        = def. op. .
        length (ramaMasLarga (NodeT e t1 t2))
        = Lema 1
        1 + max (length (ramaMasLarga t1)) (length (ramaMasLarga t2))
        = HI.1 y HI.2
        1 + max (heightT t1) (heightT t2)

        LEMA 1:
        Prop.: ¿length (ramaMasLarga (NodeT e t1 t2)) = 1 + max (length (ramaMasLarga t1)) (length (ramaMasLarga t2))?
        Dem.: Por análisis de casos:
        
        Caso 1: length (ramaMasLarga t1) > length (ramaMasLarga t2)
            LI:
            length (ramaMasLarga (NodeT e t1 t2))
            = def. ramaMasLarga
            length ([e] ++ ramaMasLarga' (ramaMasLarga t1) (ramaMasLarga t2))
            = def. ramaMasLarga'
            length ([e] ++ if(length (ramaMasLarga t1) > length (ramaMasLarga t2)) 
                            then (ramaMasLarga t1)
                            else (ramaMasLarga t2))
            = primer caso if
            length ([e] ++ ramaMasLarga t1)
            = def. length
            1 + length (ramaMasLarga t1)

            LD:
            1 + max (length (ramaMasLarga t1)) (length (ramaMasLarga t2))
            = def. max
            1 + length (ramaMasLarga t1)

            Se cumple para este caso.
        
        Caso 2: length (ramaMasLarga t1) <= length (ramaMasLarga t2) 

        LI:
            length (ramaMasLarga (NodeT e t1 t2))
            = def. ramaMasLarga
            length ([e] ++ ramaMasLarga' (ramaMasLarga t1) (ramaMasLarga t2))
            = def. ramaMasLarga'
            length ([e] ++ if(length (ramaMasLarga t1) > length (ramaMasLarga t2)) 
                            then (ramaMasLarga t1)
                            else (ramaMasLarga t2))
            = segundo caso if
            length ([e] ++ ramaMasLarga t2)
            = def. length
            1 + length (ramaMasLarga t2)

            LD:
            1 + max (length (ramaMasLarga t1)) (length (ramaMasLarga t2))
            = def. max
            1 + length (ramaMasLarga t2)

            Se cumple para este caso.




        ii.
        Prop.: ¿reverse . listInOrder = listInOrder . mirrorT?
        Dem.: Por ppio. de extensionalidad, es equivalente demostrar que
        para todo t :: Tree a:
            ¿reverse . listInOrder t = listInOrder . mirrorT t?

        Sea k un Tree a cualquiera. Por ppio. de inducción en la esturctura de 
        k, es equivalente demostrar que:
            ¿reverse . listInOrder k = listInOrder . mirrorT k?

        Caso base: k = EmptyT
            ¿reverse . listInOrder EmptyT = listInOrder . mirrorT EmptyT?
        
        Caso inductivo: k = NoteT e t1 t2
            HI.1) ¡reverse . listInOrder t1 = listInOrder . mirrorT t1!
            HI.2) ¡reverse . listInOrder t2 = listInOrder . mirrorT t2!
            TI) ¿reverse . listInOrder (NoteT e t1 t2) = listInOrder . mirrorT (NoteT e t1 t2)?

        
        Dem. caso base:
            LI:
            reverse . listInOrder EmptyT
            = def. op. .
            reverse (listInOrder EmptyT)
            = def. inOrder
            reverse []
            = def. reverse
            []

            LD:
            listInOrder . mirrorT EmptyT
            = def. op. .
            listInOrder (mirrorT EmptyT)
            = def. mirrorT
            listInOrder EmptyT
            = def. listInOrder
            []

        Dem. caso inductivo:
            LI:
            reverse . listInOrder (NoteT e t1 t2)
            = def. op. .
            reverse (listInOrder (NoteT e t1 t2))
            = def. inOrder
            reverse (inOrder t1 ++ [h] ++ inOrder t2)
            = asociatividad del operador ++
            reverse (inOrder t1 ++ ([h] ++ inOrder t2))
            = Lema practica 8. ej 2. h)
            reverse (inOrder t1) ++ reverse (([h] ++ inOrder t2))
            = Lema practica 8. ej 2. h)
            reverse (inOrder t1) ++ (reverse [h] ++ (reverse inOrder t2))
            = asociatividad del operador ++
            (reverse inOrder t2) ++ reverse [h] ++ (reverse (inOrder t1)) 
            = HI.1 y HI.2
            listInOrder . mirrorT t1 ++ reverse [h] ++ listInOrder . mirrorT t2
            = def. reverse
            listInOrder . mirrorT t2 ++ [h] ++ listInOrder . mirrorT t1
            = def. op. .
            listInOrder (mirrorT t2) ++ [h] ++ listInOrder (mirrorT t1)

            LD:
            listInOrder . mirrorT (NoteT e t1 t2)
            = def. op. .
            listInOrder (mirrorT (NoteT e t1 t2))
            = def. mirrorT
            listInOrder (NodeT e (mirrorT t2) (mirrorT t1))
            = def. listInOrder
            inOrder (mirror t2) ++ [e] ++ inOrder (mirror t1)

        
        Se cumplen ambos casos. Vale la propiedad.