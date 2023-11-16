data Pizza = Prepizza | Capa Ingrediente Pizza
    deriving Show
data Ingrediente = Salsa | Jamon | Queso | Aceitunas Int
    deriving Show
miPizza = (Capa Salsa (Capa Jamon (Capa Queso (Capa (Aceitunas 2) (Prepizza)))))

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza    = 0
cantidadDeCapas (Capa _ p)  = 1 + cantidadDeCapas p

armarPizza :: [Ingrediente] -> Pizza
armarPizza []       = Prepizza
armarPizza (i:is)   = (Capa i (armarPizza is))

sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza     = Prepizza
sacarJamon (Capa i p)   = if esJamon i
                            then p
                            else (Capa i (sacarJamon p))

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False

tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso Prepizza       = True
tieneSoloSalsaYQueso (Capa i p)     = (esSalsaOQueso i) && (tieneSoloSalsaYQueso p)

esSalsaOQueso :: Ingrediente -> Bool
esSalsaOQueso Salsa = True
esSalsaOQueso Queso = True
esSalsaOQueso _     = False

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza      = Prepizza
duplicarAceitunas (Capa i p)    = (Capa (duplicarSiAceitunas i) (duplicarAceitunas p))

duplicarSiAceitunas :: Ingrediente -> Ingrediente
duplicarSiAceitunas (Aceitunas n) = (Aceitunas (n * 2))
duplicarSiAceitunas i             = i

cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []        = []
cantCapasPorPizza (x:xs)    = ((cantidadDeCapas x), x) : cantCapasPorPizza xs

type Presa = String -- nombre de presa
type Territorio = String -- nombre de territorio
type Nombre = String -- nombre de lobo
data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo
    | Explorador Nombre [Territorio] Lobo Lobo
    | Cria Nombre
        deriving Show
data Manada = M Lobo

nombrePerro :: Nombre
nombrePerro = "Hola"

miManada :: Manada
miManada = (M miLobo)

miLobo :: Lobo
miLobo = (Cazador "FiruAlfa" ["Liebre", "Conejo"] (Explorador "JuanExplorador" ["Montana", "Bosque"] (Cria "H3") (Cria "H4")) (Explorador "PepeExplorador" ["Playa", "Rio", "Montana"] (Cria "H1") (Cria "H2")) (Cazador "Juan" [] (Cria "H6") (Cria "H7") (Cria "H8")))
 
losQueExploraron :: Territorio -> Manada -> [Nombre]
losQueExploraron t (M lobo) = losQueExploraron' t lobo 


losQueExploraron' :: Territorio -> Lobo -> [Nombre]
losQueExploraron' t (Cria n)                     = []
losQueExploraron' t (Explorador n ts l1 l2)      = (nombreSiExploro n t ts) ++ (losQueExploraron' t l1) ++ (losQueExploraron' t l2)
losQueExploraron' t (Cazador _ _ l1 l2 l3)       = (losQueExploraron' t l1) ++ (losQueExploraron' t l2) ++ (losQueExploraron' t l3)

nombreSiExploro :: Nombre -> Territorio -> [Territorio] -> [String]
nombreSiExploro n t ts = if apareceEnLista t ts
                            then [n]
                            else []

apareceEnLista :: Nombre -> [Nombre] -> Bool
apareceEnLista a []     = False
apareceEnLista a (x:xs) = ((nombreAString a) == (nombreAString x)) || (apareceEnLista a xs)

nombreAString :: Nombre -> String
nombreAString (n) = n



exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
exploradoresPorTerritorio manada = lobosQueExploraron (territoriosExploradosDe manada) manada

territoriosExploradosDe :: Manada -> [Territorio]
territoriosExploradosDe (M lobo) = territoriosExploradosDe' lobo

territoriosExploradosDe' :: Lobo -> [Territorio]
territoriosExploradosDe' (Cria _)                   = []
territoriosExploradosDe' (Explorador n ts l1 l2)    = listaTerritoriosSR ts (listaTerritoriosSR (territoriosExploradosDe' l1) (territoriosExploradosDe' l2))
territoriosExploradosDe' (Cazador _ _ l1 l2 l3)     = listaTerritoriosSR (territoriosExploradosDe' l1) (listaTerritoriosSR (territoriosExploradosDe' l2) (territoriosExploradosDe' l3))

listaTerritoriosSR :: [Territorio] -> [Territorio] -> [Territorio]
listaTerritoriosSR [] ts            = ts
listaTerritoriosSR ts []            = ts
listaTerritoriosSR (x:xs) ys        = (territorioSiNoApareceEn x ys) ++ (listaTerritoriosSR xs ys) 

territorioSiNoApareceEn :: Territorio -> [Territorio] -> [Territorio]
territorioSiNoApareceEn t ts = if (not (apareceEnListaTerritorios t ts))
                                then [t]
                                else [] 

apareceEnListaTerritorios :: Territorio -> [Territorio] -> Bool
apareceEnListaTerritorios t []      = False
apareceEnListaTerritorios t (x:xs)  = ((territorioAString t) == (territorioAString x)) || apareceEnListaTerritorios t xs

territorioAString :: Territorio -> String
territorioAString (t) = t

lobosQueExploraron :: [Territorio] -> Manada -> [(Territorio, [Nombre])]
lobosQueExploraron [] m     = []
lobosQueExploraron (t:ts) m = (t, (losQueExploraron t m)) : (lobosQueExploraron ts m)



superioresDelCazador :: Nombre -> Manada -> [Nombre]
superioresDelCazador n (M lobo) = superioresDelCazador' n lobo

superioresDelCazador' :: Nombre -> Lobo -> [Nombre]
superioresDelCazador' n (Cria _)                = []
superioresDelCazador' n (Explorador _ _ l1 l2)  = (superioresDelCazador' n l1) ++ (superioresDelCazador' n l2)
superioresDelCazador' n (Cazador nl ts l1 l2 l3) = (singularSi nl (tieneComoSubordinadoaA (Cazador nl ts l1 l2 l3) n))
                                                    ++ (superioresDelCazador' n  l1)
                                                    ++ (superioresDelCazador' n  l2)
                                                    ++ (superioresDelCazador' n  l3)

singularSi :: a -> Bool -> [a]
singularSi a True = [a]
singularSi a False = []


tieneComoSubordinadoaA :: Lobo -> Nombre -> Bool
tieneComoSubordinadoaA (Cria _) n               = False
tieneComoSubordinadoaA (Explorador _ _ l1 l2) n   = (tieneComoSubordinadoaA l1 n) || (tieneComoSubordinadoaA l2 n) 
tieneComoSubordinadoaA (Cazador nl _ l1 l2 l3) n  = (tieneComoSubordinadoaA' l1 n) || (tieneComoSubordinadoaA' l2 n)
                                                    || (tieneComoSubordinadoaA' l3 n)

tieneComoSubordinadoaA' :: Lobo -> Nombre -> Bool
tieneComoSubordinadoaA' (Cria _) n                   = False
tieneComoSubordinadoaA' (Explorador _ _ l1 l2) n     = (tieneComoSubordinadoaA' l1 n) || (tieneComoSubordinadoaA' l2 n)  
tieneComoSubordinadoaA' (Cazador nl _ l1 l2 l3) n    = ((nombreAString nl) == (nombreAString n)) ||
                                                        (tieneComoSubordinadoaA' l1 n) ||
                                                        (tieneComoSubordinadoaA' l2 n) ||
                                                        (tieneComoSubordinadoaA' l3 n)