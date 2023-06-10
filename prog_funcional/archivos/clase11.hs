data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Aceitunas Int
                 | Jamon
                 | Queso
                 | Salsa

-- f Prepizza = ...
-- f (Capa ing ps) = ... f ps

cantidadCapasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen p Prepizza = 0
cantidadCapasQueCumplen p (Capa ing ps) = 
    if p ing
       then 1 + cantidadCapasQueCumplen p ps
       else cantidadCapasQueCumplen p ps

--  unoSiCumple (p ing) + cantidadCapasQueCumplen p ps

-- unoSiCumple True  = 1
-- unoSiCumple False = 0

conCapasTransformadas :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas f Prepizza      = Prepizza
conCapasTransformadas f (Capa ing ps) = 
    Capa (f ing) (conCapasTransformadas f ps)

soloLasCapasQue :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue p Prepizza      = Prepizza
soloLasCapasQue p (Capa ing ps) = 
    if p ing
       then Capa ing (soloLasCapasQue p ps)
       else soloLasCapasQue p ps

sinLactosa :: Pizza -> Pizza
sinLactosa = soloLasCapasQue (\ing -> not (esQueso ing))
--                             (not . esQueso)

esQueso Queso = True
esQueso _     = False

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa p = cantidadCapasQueCumplen esQueso p == 0
                          -- = (== 0) . cantidadCapasQueCumplen esQueso

cantidadDeQueso :: Pizza -> Int
cantidadDeQueso = cantidadCapasQueCumplen esQueso

conElDobleDeAceitunas :: Pizza -> Pizza
conElDobleDeAceitunas = conCapasTransformadas dupAceitunas

dupAceitunas (Aceitunas ing) = Aceitunas (ing * 2)
dupAceitunas ing             = ing

pizzaProcesada :: (Ingrediente -> b -> b) -> b -> Pizza -> b
pizzaProcesada fcap pr Prepizza      = pr
pizzaProcesada fcap pr (Capa ing pz) = 
    fcap ing (pizzaProcesada fcap pr pz)

pizzaProcesadaRecPrim :: (Ingrediente -> Pizza -> b -> b) -> b -> Pizza -> b
pizzaProcesadaRecPrim fcap pr Prepizza      = pr
pizzaProcesadaRecPrim fcap pr (Capa ing pz) = 
    fcap ing pz (pizzaProcesadaRecPrim fcap pr pz)


cantidadCapasQueCumplen' :: (Ingrediente -> Bool) -> Pizza -> Int
cantidadCapasQueCumplen' p = pizzaProcesada 
    (\ing pp -> if p ing then 1 + pp else pp)
    0

conCapasTransformadas' :: (Ingrediente -> Ingrediente) -> Pizza -> Pizza
conCapasTransformadas' f =
    pizzaProcesada (\ing pp -> Capa (f ing) pp) Prepizza
    --                         Capa . f

soloLasCapasQue' :: (Ingrediente -> Bool) -> Pizza -> Pizza
soloLasCapasQue' p = pizzaProcesada
    (\ing pp -> if p ing then Capa ing pp else pp)
    Prepizza

sinLactosa' :: Pizza -> Pizza
sinLactosa' = pizzaProcesada
    (\ing pp -> if esQueso ing then pp else Capa ing pp)
    Prepizza

aptaIntolerantesLactosa' :: Pizza -> Bool
aptaIntolerantesLactosa' = pizzaProcesada
    (\ing pp -> not (esQueso ing) && pp)
    True

cantidadDeQueso' :: Pizza -> Int
cantidadDeQueso' = pizzaProcesada
    (\ing pp -> if esQueso ing then 1 + pp else pp)
    0

conElDobleDeAceitunas' :: Pizza -> Pizza
conElDobleDeAceitunas' = pizzaProcesada
    (\ing pp -> Capa (dupAceitunas ing) pp)
    Prepizza

cantidadAceitunas :: Pizza -> Int
cantidadAceitunas = pizzaProcesada
    (\ing pp -> aceitunas ing + pp)
    0

aceitunas (Aceitunas n) = n
aceitunas _             = 0

capasQueCumplen :: (Ingrediente -> Bool) -> Pizza -> [Ingrediente]
capasQueCumplen p = pizzaProcesada
    (\ing pp -> if p ing then ing : pp else pp)
    []

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada = pizzaProcesada
    (\ing pp -> comprimirAceitunas ing pp)
    Prepizza

comprimirAceitunas (Aceitunas n) (Capa (Aceitunas m) p) = Capa (Aceitunas (n+m)) p
comprimirAceitunas ing p = Capa ing p

conCapasDe pz1 pz2 = pizzaProcesada (\ing pp -> Capa ing pp) pz2 pz1

primerasNCapas' :: Int -> Pizza -> Pizza
primerasNCapas' n pz = pizzaProcesada fcap (\n -> Prepizza) pz n
    where fcap ing pp 0 = Prepizza
          fcap ing pp n = Capa ing (pp (n-1))

primerasNCapas 0 _        = Prepizza
primerasNCapas n Prepizza = Prepizza
primerasNCapas n (Capa ing p) =
    Capa ing (primerasNCapas (n-1) p)

zipPizza :: Pizza -> Pizza -> [(Ingrediente, Ingrediente)]
zipPizza Prepizza pz2      = []
zipPizza (Capa ing1 pz1) Prepizza      = []
zipPizza (Capa ing1 pz1) (Capa ing2 pz2) =
    (ing1, ing2) : zipPizza pz1 pz2

zipPizza' :: Pizza -> Pizza -> [(Ingrediente, Ingrediente)]
zipPizza' pz1 pz2 =
    (pizzaProcesada
            g
            (\pz2 -> [])
            pz1)
        pz2
  where g ing1 pp Prepizza        = []
        g ing1 pp (Capa ing2 pz2) = (ing1, ing2) : pp pz2

sacarNCapas :: Int -> Pizza -> Pizza
sacarNCapas n pz =
    pizzaProcesadaRecPrim
     fcap
     (\n -> Prepizza)
     pz
     n
     where fcap ing pz pp 0 = Capa ing pz
           fcap ing pz pp n = pp (n - 1)

elIngredienteNroN :: Int -> Pizza -> Maybe Ingrediente
elIngredienteNroN n pz =
    pizzaProcesada
        fcap
        (\n -> Nothing)
        pz
        n

        where fcap ing pp 0 = Just ing
              fcap ing pp n = pp (n-1)

-- map :: (a -> b) -> [a] -> [b]
-- map f []     = []
-- map f (x:xs) = f x : map f xs

-- filter :: (a -> Bool) -> [a] -> [a]
-- filter p []     = []
-- filter p (x:xs) = if p x then x : filter p xs else filter p xs

-- foldr :: (a -> b -> b) -> b -> [a] -> b
-- foldr f z []     = z
-- foldr f z (x:xs) = f x (foldr f z xs)

recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr z f []     = z
recr z f (x:xs) = f x xs (recr z f xs)

-- foldr1 :: (a -> a -> a) -> [a] -> a
-- foldr1 f [x]    = x
-- foldr1 f (x:xs) = f x (foldr1 f xs)

-- minimum [x] = x
-- minimum (x:xs) = min x (minimum xs)

-- minimum = foldr1 min

-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-- zipWith f []     ys     = ys
-- zipWith f xs     []     = xs
-- zipWith f (x:xs) (y:ys) = f x y : zipWith f xs

-- zipMaximos :: [Int] -> [Int] -> [Int]
-- zipMaximos = zipWith max

-- scanr :: (a -> b -> b) -> b -> [a] -> [b]
-- scanr f z []     = [z]
-- scanr f z (x:xs) = 
--     foldr f z (x:xs) : scanr f z xs

-- sum :: [Int] -> Int
-- sum = foldr (+) 0

-- length :: [a] -> Int
-- length = foldr (\x r -> 1 + r) 0
-- --         foldr (const (+1)) 0

-- map :: (a -> b) -> [a] -> [b]
-- map f = foldr (\x r -> f x : r) []
-- --              ((:) . f)

-- filter :: (a -> Bool) -> [a] -> [a]
-- filter p = foldr (\x r -> if f x then x : r else r) []

-- find :: (a -> Bool) -> [a] -> Maybe a
-- find p = foldr (\x r -> if p x then Just x else r) Nothing

-- any :: (a -> Bool) -> [a] -> Bool
-- any p = foldr (\x r -> p x || r) False

-- all :: (a -> Bool) -> [a] -> Bool
-- all p = foldr (\x r -> p x && r) True

-- countBy :: (a -> Bool) -> [a] -> Int
-- countBy p = foldr (\x r -> if p x then 1 + r else r) 0

-- partition :: (a -> Bool) -> [a] -> ([a], [a])
-- partition p = foldr (\x (xs, ys) -> 
--                         if p x then (x:xs, ys) else (xs, x:ys))
--                     ([], [])

-- zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-- zipWith f xs ys =
--     foldr g (\ys -> []) xs ys
--     where g x r []     = []
--           g x r (y:ys) = f x y : r ys

-- takeWhile :: (a -> Bool) -> [a] -> [a]
-- takeWhile p = foldr (\x r -> if p x then x : r else []) []

-- take :: Int -> [a] -> [a]
-- take n [] = []
-- take 0 _  = []
-- take n (x:xs) = x : take (n-1) xs

-- take' n xs = foldr g (\n -> []) xs n
--     where g x r 0 = []
--           g x r n = x : r (n-1)

drop :: Int -> [a] -> [a]
drop n xs =
    recr (\n -> []) g xs n
    where g x xs r 0 = x : xs
          g x xs r n = r (n-1)

-- (!!) :: Int -> [a] -> a

sumarMientrasSeanPares =
    foldr (\x r -> if even x then x + r else 0) 0

printSumarMientrasSeanPares =
    foldr (\x r -> if even x then "(" ++ show x ++ " + " ++ r ++ ")" else "0") ""

showFoldrMagic :: (Show a) => String -> String -> [a] -> String
showFoldrMagic f z = foldr (\x r -> concat ["(",f," ",show x," ",r,")"]) z

showFoldlMagic :: (Show a) => String -> String -> [a] -> String
showFoldlMagic f z = foldl (\r x -> concat ["(",f," ",r," ",show x,")"]) z


-- head [] = error "no tiene head"
-- head (x:xs) = x

head' = foldr (\x r -> x) (error "no tiene head")

-- tail [] = error "no tiene tail"
-- tail (x:xs) = xs

tail' = recr (error "no tiene tail") (\x xs r -> xs)


last' = recr (error "no tiene last")
             (\x xs r -> 
                 case xs of 
                     [] -> x
                     _  -> r) 


init' = recr (error "no puedo")
             (\x xs r -> 
                 case xs of 
                     [] -> []
                     _  -> x : r)

agrupar :: Eq a => [a] -> [[a]]
agrupar = foldr (\x r -> agregarAgrupado x r) []

agregarAgrupado x []       = [[x]]
agregarAgrupado x (ys:yss) = 
    if elem x ys
       then (x : ys) : yss
       else [x] : ys : yss

-- me dan un numero y una lista ordenada de numeros
-- e inserto el numero donde corresponda, dejando
-- el resultado, ordenado de menor a mayor
insert :: Ord a => a -> [a] -> [a]
insert = undefined