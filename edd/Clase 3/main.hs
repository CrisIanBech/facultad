data Color = Azul | Rojo
    deriving Show
data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

bolitaEj :: Celda
bolitaEj = Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia)))

nroBolitas :: Color -> Celda -> Int
nroBolitas c CeldaVacia                     = 0
nroBolitas c (Bolita colorActual celda)     = unoSiEsColor colorActual c + (nroBolitas c celda)

unoSiEsColor :: Color -> Color -> Int
unoSiEsColor Azul Azul  = 1
unoSiEsColor Rojo Rojo  = 1
unoSiEsColor _ _        = 0



poner :: Color -> Celda -> Celda
poner c celda = (Bolita c celda)  

sacar :: Color -> Celda -> Celda
sacar color CeldaVacia           = CeldaVacia
sacar color (Bolita c celda)     = if (sonMismoColor color c)
                                        then celda
                                        else (Bolita c (sacar color celda)) 

colorPrimerBolita :: Celda -> Color -- Prec: La Celda no puede ser CeldaVacía
colorPrimerBolita (Bolita c _) = c

sonMismoColor :: Color -> Color -> Bool
sonMismoColor Rojo Rojo     = True
sonMismoColor Azul Azul     = True
sonMismoColor _ _           = False

ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 c celda    = celda
ponerN n c celda    = ponerN (n - 1) c (poner c celda)



-- EJERCICIO 1.2

data Objeto = Cacharro | Tesoro
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino

miCamino :: Camino
miCamino = Cofre [Tesoro, Tesoro] (Nada (Nada (Nada (Nada(Cofre [Cacharro, Tesoro] Fin)))))

hayTesoro :: Camino -> Bool
hayTesoro Fin               = False
hayTesoro (Nada camino)     = hayTesoro camino
hayTesoro (Cofre os camino) = (tieneTesoro os) || (hayTesoro camino)

tieneTesoro :: [Objeto] -> Bool
tieneTesoro []      = False
tieneTesoro (o:os)  = esTesoro o || tieneTesoro os

{- tieneTesoro :: [Objeto] -> Bool
tieneTesoro []      = False
tieneTesoro (o:os)  = if esTesoro o
                        then True
                        else tieneTesoro os -}

esTesoro :: Objeto -> Bool
esTesoro Tesoro     = True
esTesoro _          = False

pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro (Fin)          = 0
pasosHastaTesoro (Nada camino)  = 1 + pasosHastaTesoro camino
pasosHastaTesoro (Cofre os c)   = if tieneTesoro os
                                    then 0
                                    else 1 + pasosHastaTesoro c

hayTesoroEn :: Int -> Camino -> Bool
hayTesoroEn 0 c               = False
hayTesoroEn n Fin             = False
hayTesoroEn n (Nada c)        = hayTesoroEn (n - 1) c
hayTesoroEn n (Cofre os c)    = if tieneTesoro os 
                                    then True
                                    else hayTesoroEn (n - 1) c

alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros cant cam = (cantTesoros cam) >= cant 

cantTesoros :: Camino -> Int
cantTesoros Fin               = 0
cantTesoros (Nada camino)     = cantTesoros camino
cantTesoros (Cofre os camino) = (cantTesoros' os) + (cantTesoros camino)

cantTesoros' :: [Objeto] -> Int
cantTesoros' []         = 0
cantTesoros' (o:os)     = unoSiEsTesoroCeroSino o + (cantTesoros' os)

unoSiEsTesoroCeroSino :: Objeto -> Int
unoSiEsTesoroCeroSino Tesoro    = 1
unoSiEsTesoroCeroSino _         = 0

cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre 0 numMax (Fin)         = 0
cantTesorosEntre 0 numMax camino        = cantTesorosEnNPasos numMax camino
cantTesorosEntre n numMax (Nada c)      = cantTesorosEntre (n - 1) (numMax - 1) c
cantTesorosEntre n numMax (Cofre _ c)   = cantTesorosEntre (n - 1) (numMax - 1) c

cantTesorosEnNPasos :: Int -> Camino -> Int
cantTesorosEnNPasos 0 _                 = 0
cantTesorosEnNPasos n (Fin)             = 0
cantTesorosEnNPasos n (Nada camino)     = cantTesorosEnNPasos (n - 1) camino
cantTesorosEnNPasos n (Cofre os c)      = (cantTesoros' os) + (cantTesorosEnNPasos (n - 1) c)






















data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
    deriving Show

miTree :: Tree Int
miTree = NodeT 12 (NodeT 4 (NodeT 2 EmptyT (NodeT 5 EmptyT EmptyT)) EmptyT) (NodeT 3 (EmptyT) (EmptyT))

sumarT :: Tree Int -> Int
sumarT EmptyT            = 0
sumarT (NodeT n t1 t2)   = n + (sumarT t1) + (sumarT t2)

sizeT :: Tree a -> Int
sizeT EmptyT         = 0
sizeT (NodeT n t1 t2)  = 1 + (sizeT t1) + (sizeT t2)

mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT            = EmptyT
mapDobleT (NodeT n t1 t2)   = (NodeT (n * 2) (mapDobleT t1) (mapDobleT t2))

perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT a EmptyT             = False
perteneceT a (NodeT e t1 t2)    = (e == a) || (perteneceT a t1) || (perteneceT a t2) 

leaves :: Tree a -> [a]
leaves EmptyT           = []
leaves (NodeT n t1 t2)  = n : (leaves t1) ++ (leaves t2)

heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT a t1 t2) = 1 + (mayorEntre (heightT t1) (heightT t2))

mayorEntre :: Int -> Int -> Int
mayorEntre a b = if a > b
                    then a
                    else b

mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT a t1 t2) = (NodeT a (mirrorT t2) (mirrorT t1))

toList :: Tree a -> [a]
toList EmptyT           = []
toList (NodeT a t1 t2)  = (toList t1) ++ a : (toList t2)

levelN :: Int -> Tree a -> [a]
levelN n EmptyT             = []
levelN 0 (NodeT e t1 t2)    = [e]
levelN n (NodeT e t1 t2)    = (levelN (n - 1) t1) ++ (levelN (n - 1) t2)

listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT             = []
listPerLevel (NodeT e t1 t2)    = []

ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT             = []
ramaMasLarga (NodeT e t1 t2)    = e : leaves (masLargoEntreRama t1 t2)

masLargoEntreRama :: Tree a -> Tree a -> Tree a
masLargoEntreRama t1 t2 = if (heightT t1 > heightT t2)
                            then t1
                            else t2

{- todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos tree = [todosLosCaminos' tree]
 -}

data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA
    deriving Show

eval :: ExpA -> Int
eval (Valor n)    = n
eval (Sum a b)    = (eval a) + (eval b)
eval (Prod a b)   = (eval a) * (eval b) 
eval (Neg a)      = - (eval a) 

simplificar :: ExpA -> ExpA
simplificar (Prod x (Valor 0))  = (Valor 0)
simplificar (Prod (Valor 0) x)  = (Valor 0) 
simplificar (Prod x (Valor 1))  = x
simplificar (Prod (Valor 1) x)  = x
simplificar (Sum x (Valor 0))   = x
simplificar (Sum (Valor 0) x)   = x
simplificar (Neg (Neg x))       = x
simplificar e                   = e

