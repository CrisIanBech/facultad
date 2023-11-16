-- 1_a
sucesor :: Int -> Int
sucesor primerNum = primerNum + 1

-- 1_b
sumar :: Int -> Int -> Int
sumar primerNum segundoNum = primerNum + segundoNum

-- 1_c
divisionYResto :: Int -> Int -> (Int, Int)
divisionYResto primerNum segundoNum = (div primerNum segundoNum, mod primerNum segundoNum)

-- 1_d
maxDelPar :: (Int, Int) -> Int
maxDelPar (primerNum, segundoNum) = if (primerNum > segundoNum)
                                    then primerNum
                                    else segundoNum


-- 2 TIPOS ENUMERATIVOS

data Dir = Norte | Este | Oeste | Sur
    deriving Show -- Se usa para que me tome el dato
-- 1_a
opuesto :: Dir -> Dir
opuesto Norte   = Sur
opuesto Sur     = Norte
opuesto Este    = Oeste
opuesto Oeste   = Este
-- 1_b
iguales :: Dir -> Dir -> Bool
iguales Norte Norte  = True
iguales Este  Este   = True
iguales Oeste Oeste  = True
iguales Sur Sur      = True
iguales _   _        = False
-- 1_c
siguiente :: Dir -> Dir
siguiente Norte     = Este
siguiente Este      = Oeste
siguiente Oeste     = Sur
siguiente Sur       = Norte


data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo
    deriving Show

primerYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primerYUltimoDia = (Lunes, Domingo)

empiezaConM :: DiaDeSemana -> Bool
empiezaConM Martes      = True
empiezaConM Miercoles   = True
empiezaConM _           = False

vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool
vieneDespues Domingo Sabado     = True
vieneDespues Sabado Viernes     = True
vieneDespues Viernes Jueves     = True
vieneDespues Jueves Miercoles   = True
vieneDespues Miercoles Martes   = True
vieneDespues Martes Lunes       = True
vieneDespues _ _                = False

estaEnMedio :: DiaDeSemana -> Bool
estaEnMedio Lunes   = False
estaEnMedio Domingo = False
estaEnMedio _       = True


negar :: Bool -> Bool
negar True  = False
negar False = True

implica :: Bool -> Bool -> Bool
implica True False  = False
implica _ _         = True

and :: Bool -> Bool -> Bool
and True True   = True
and _ _         = False

or :: Bool -> Bool -> Bool
or False False  = False
or _ _          = True

-- 3 REGISTROS

data Persona = Persona String Int -- Nombre Edad
	deriving Show

juan    = Persona "Juan" 50
yo 		= Persona "Tomas" 21
pepe 	= Persona "Pepe" 22

nombre :: Persona -> String
nombre (Persona nombrePersona _ ) = nombrePersona

edad :: Persona -> Int
edad (Persona _ edadPersona) = edadPersona

crecer :: Persona -> Persona
crecer (Persona nombrePersona edadPersona) = (Persona nombrePersona (edadPersona + 1))

cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre nuevoNombre (Persona _ edadPersona ) = (Persona nuevoNombre edadPersona)

esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra (Persona nombrePersona edadPersona) (Persona nombreOtraPersona edadOtraPersona) = edadPersona > edadOtraPersona

laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor primeraPersona segundaPersona =    if esMayorQueLaOtra primeraPersona segundaPersona
                                                    then primeraPersona
                                                    else segundaPersona

charmander :: Pokemon
charmander = ConsPokemon Fuego 100

bulbasaur :: Pokemon
bulbasaur = ConsPokemon Agua 100

pokPlanta :: Pokemon
pokPlanta = ConsPokemon Planta 100

ash :: Entrenador
ash = ConsEntrenador "Ash" [charmander, bulbasaur, pokPlanta]


tieneVentajaA :: TipoDePokemon -> TipoDePokemon -> Bool
tieneVentajaA Agua Fuego    = True
tieneVentajaA Fuego Planta  = True
tieneVentajaA Planta Agua   = True
tieneVentajaA _ _           = False
 
esMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esMismoTipo Fuego Fuego     = True
esMismoTipo Planta Planta   = True
esMismoTipo Agua Agua       = True
esMismoTipo _ _             = False


{-

cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe tipoAVer (E _ primerPokemon segundoPokemon) = cantidadDeTipo tipoAVer primerPokemon segundoPokemon

cantidadDeTipo :: TipoDePokemon -> Pokemon -> Pokemon -> Int
cantidadDeTipo tipoAVer (Pok tipoPrimero _) (Pok tipoSegundo _) = 
    (if esMismoTipo tipoAVer tipoPrimero then 1 else 0) +
    (if esMismoTipo tipoAVer tipoSegundo then 1 else 0)


juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (primerEntrenador, segundoEntrenador) = (pokemonsDe primerEntrenador) ++ (pokemonsDe segundoEntrenador)

pokemonsDe :: Entrenador -> [Pokemon]
pokemonsDe (E _ primerPokemon segundoPokemon) = [primerPokemon, segundoPokemon]
 -}
loMismo :: a -> a
loMismo a = a

siempreSiete :: a -> Int
siempreSiete a = 7

swap :: (a, b) -> (b, a)
swap (a, b) = (b, a)

estaVacia :: [a] -> Bool
estaVacia []    = True
estaVacia _     = False

elPrimero :: [a] -> a
elPrimero (x:xs) = x

sinElPrimero :: [a] -> [a]
sinElPrimero (x:xs) = xs

splitHead :: [a] -> (a, [a])
splitHead (x:xs) = (x, xs)

-- PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2
-- PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2
-- PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2
-- PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2
-- PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2 PRACTICA 2

sumatoria :: [Int] -> Int
sumatoria []        = 0
sumatoria (n:ns)    = n + sumatoria ns

longitud :: [a] -> Int
longitud []        = 0
longitud (n:ns)    = 1 + longitud ns

sucesores :: [Int] -> [Int]
sucesores []    = []
sucesores (n:ns) = (n + 1) : sucesores ns

conjuncion :: [Bool] -> Bool
conjuncion []       = True
conjuncion (n:ns)   = n && conjuncion ns

disyuncion :: [Bool] -> Bool
disyuncion []       = False
disyuncion (n:ns)   = n || disyuncion ns

aplanar :: [[a]] -> [a]
aplanar []      = []
aplanar (x:xs)  = x ++ aplanar xs


pertenece :: Eq a => a -> [a] -> Bool
pertenece e []        = False
pertenece e (x:xs)    = (x == e) || pertenece e xs  

apariciones :: Eq a => a -> [a] -> Int
apariciones e []        = 0
apariciones e (x:xs)    = unoSiCeroSino (e==x) + apariciones e xs

unoSiCeroSino :: Bool -> Int
unoSiCeroSino True  = 1
unoSiCeroSino False = 0

losMenoresA :: Int -> [Int] -> [Int]
losMenoresA x []        = []
losMenoresA x (n:ns)    = if n < x
                            then n : losMenoresA x ns
                            else losMenoresA x ns

lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA l []        = []
lasDeLongitudMayorA l (x:xs)    = if (longitud x) > l
                                    then x : lasDeLongitudMayorA l xs
                                    else lasDeLongitudMayorA l xs

agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] n     = n : []
agregarAlFinal (x:xs) n = x : agregarAlFinal xs n 

concatenar :: [a] -> [a] -> [a]
concatenar [] ys         = ys
concatenar (x:xs) ys     =  x : concatenar xs ys  


reversa :: [a] -> [a] 
reversa []      = []
reversa (x:xs)  = agregarAlFinal (reversa xs) x

zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] ys            = ys
zipMaximos (x:xs) (y:ys)    = if x > y
                                then x : zipMaximos xs ys
                                else y : zipMaximos xs ys

elMinimo :: Ord a => [a] -> a
elMinimo []       = error "la lista no puede ser vacía"
elMinimo (x:xs)   = if null xs
                        then x
                        else minim x (elMinimo xs)

minim :: Ord a => a -> a -> a
minim x y = if x < y 
            then x 
            else y

factorial :: Int -> Int     -- Prec: El num debe ser mayor o igual a 0
factorial 0 = 1
factorial n = n * factorial (n - 1)

cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0   = []
cuentaRegresiva n = n : cuentaRegresiva (n - 1)

repetir :: Int -> a -> [a]
repetir 0 e = []
repetir n e = e : (repetir (n - 1) e)

losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 xs        = []
losPrimeros n []        = []
losPrimeros n (x:xs)    = x : losPrimeros (n - 1) xs

sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 xs     = xs
sinLosPrimeros n []     = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n - 1) xs

mayoresA :: Int -> [Persona] -> [Persona]
mayoresA n []       = []
mayoresA n (x:xs)   = if (edad x) > n
                        then x : mayoresA n xs
                        else mayoresA n xs 

promedioEdad :: [Persona] -> Int
promedioEdad []     = 0
promedioEdad ps     = div (edadDeTodosDe ps) (longitud ps) 

edadDeTodosDe :: [Persona] -> Int
edadDeTodosDe []        = 0
edadDeTodosDe (p:ps)    = (edad p) + edadDeTodosDe ps

elMasViejo :: [Persona] -> Persona
elMasViejo []       = error "La lista no puede ser vacía"
elMasViejo [p]      = p
elMasViejo (p:ps)   = laQueEsMayor p (elMasViejo ps)

cantPokemon :: Entrenador -> Int
cantPokemon (ConsEntrenador n ps)   = longitud ps


data TipoDePokemon = Agua | Fuego | Planta
data Pokemon = ConsPokemon TipoDePokemon Int
data Entrenador = ConsEntrenador String [Pokemon]


cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe tipo (ConsEntrenador n listaPokemon) = cantPokemonDe' tipo listaPokemon  

cantPokemonDe' :: TipoDePokemon -> [Pokemon] -> Int
cantPokemonDe' _ []            = 0
cantPokemonDe' tipo (p:ps)     = if esMismoTipoPok tipo p
                                    then 1 + cantPokemonDe' tipo ps
                                    else cantPokemonDe' tipo ps

sonMismoTipo :: Pokemon -> Pokemon -> Bool
sonMismoTipo (ConsPokemon tipoPrimero _) (ConsPokemon tipoSegundo _) = esMismoTipo tipoPrimero tipoSegundo

esMismoTipoPok :: TipoDePokemon -> Pokemon -> Bool
esMismoTipoPok tipoAVer (ConsPokemon tipoPrimero _) = esMismoTipo tipoPrimero tipoAVer

losQueLeGanan :: TipoDePokemon -> Entrenador -> Entrenador -> Int
losQueLeGanan t (ConsEntrenador _ ps1) (ConsEntrenador _ ps2) = losQueLeGanan' t ps1 ps2

losQueLeGanan' :: TipoDePokemon -> [Pokemon] -> [Pokemon] -> Int
losQueLeGanan' tipo [] _        = 0
losQueLeGanan' tipo (p:ps) rs   = if (esMismoTipoPok tipo p) && (venceATodosDe p rs)
                                    then 1 + losQueLeGanan' tipo ps rs
                                    else losQueLeGanan' tipo ps rs

venceATodosDe :: Pokemon -> [Pokemon] -> Bool
venceATodosDe pok []        = True
venceATodosDe pok (p:ps)    = (vencePokA pok p) && venceATodosDe pok ps

vencePokA :: Pokemon -> Pokemon -> Bool
vencePokA (ConsPokemon tipo1 _) (ConsPokemon tipo2 _) = tieneVentajaA tipo1 tipo2

esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon (ConsEntrenador _ ps) = (tieneTipo Agua ps) && (tieneTipo Planta ps) && (tieneTipo Fuego ps)

tieneTipo :: TipoDePokemon -> [Pokemon] -> Bool
tieneTipo tipo []       = False
tieneTipo tipo (p:ps)   = if esMismoTipoPok tipo p
                            then True
                            else False || (tieneTipo tipo ps) 

data Seniority = Junior | SemiSenior | Senior
    deriving Show
data Proyecto = ConsProyecto String
    deriving Show
data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
    deriving Show
data Empresa = ConsEmpresa [Rol]
    deriving Show

proyectoPerros :: Proyecto
proyectoPerros = ConsProyecto "ProyectoPerros"

proyectoGatos :: Proyecto
proyectoGatos = ConsProyecto "ProyectoGatos"

proyectoHamsters :: Proyecto
proyectoHamsters = ConsProyecto "ProyectoHamsters"

primerRol :: Rol
primerRol = Developer SemiSenior proyectoGatos

segundoRol :: Rol
segundoRol = Developer SemiSenior proyectoPerros

tercerRol :: Rol
tercerRol = Management SemiSenior proyectoHamsters

cuartoRol :: Rol
cuartoRol = Management Junior proyectoHamsters

miEmpresa :: Empresa 
miEmpresa = ConsEmpresa [primerRol, segundoRol, tercerRol, cuartoRol]

proyectos :: Empresa -> [Proyecto]
proyectos (ConsEmpresa roles) = proyectos' roles 

proyectos' :: [Rol] -> [Proyecto]
proyectos' []       = []
proyectos' (r:rs)   =  elementoSiNoRepetido (proyectoDe r) (proyectos' rs)

proyectoDe :: Rol -> Proyecto
proyectoDe (Developer s p) = p
proyectoDe (Management s p) = p

elementoSiNoRepetido :: Proyecto -> [Proyecto] -> [Proyecto]
elementoSiNoRepetido x [] = [x]
elementoSiNoRepetido x xs = if not (contieneA x xs)
                                then (x:xs)
                                else xs

contieneA :: Proyecto -> [Proyecto] -> Bool
contieneA a []      = False
contieneA a (x:xs)  = if sonProyectosIguales a x
                        then True
                        else contieneA a xs

losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior (ConsEmpresa roles) ps = cantidadSeniorsEn roles ps

cantidadSeniorsEn :: [Rol] -> [Proyecto] -> Int
cantidadSeniorsEn [] _      = 0
cantidadSeniorsEn (r:rs) ps = if (perteneceProyecto r ps) && (esSenior r) 
                                then 1 + (cantidadSeniorsEn rs ps)
                                else cantidadSeniorsEn rs ps

esSenior :: Rol -> Bool
esSenior (Developer Senior _)    = True
esSenior (Management Senior _)   = True
esSenior _                       = False


perteneceProyecto :: Rol -> [Proyecto] -> Bool
perteneceProyecto rol []        = False
perteneceProyecto rol (x:xs)    = if sonProyectosIguales (proyectoDe rol) x
                                    then True
                                    else perteneceProyecto rol xs

sonProyectosIguales :: Proyecto -> Proyecto -> Bool
sonProyectosIguales (ConsProyecto n1) (ConsProyecto n2) = n1 == n2

cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn [] e      = 0
cantQueTrabajanEn (p:ps) e  = (cantQueTrabajanEn' p e) + (cantQueTrabajanEn ps e )

cantQueTrabajanEn' :: Proyecto -> Empresa -> Int
cantQueTrabajanEn' p (ConsEmpresa roles) = cantProyectosEnRoles p roles

cantProyectosEnRoles :: Proyecto -> [Rol] -> Int
cantProyectosEnRoles p []       = 0
cantProyectosEnRoles p (r:rs)   = if sonProyectosIguales (proyectoDe r) p
                                    then 1 + cantProyectosEnRoles p rs
                                    else cantProyectosEnRoles p rs

asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto empresa = asignadosPorProyecto' (proyectos empresa) empresa

asignadosPorProyecto' :: [Proyecto] -> Empresa -> [(Proyecto, Int)]
asignadosPorProyecto' [] e       = []
asignadosPorProyecto' (p:ps) e   = (p, (cantQueTrabajanEn [p] e)) : (asignadosPorProyecto' ps e)