data Ingrediente = Aceitunas Int
                 | Anchoas
                 | Cebolla
                 | Jamón
                 | Queso
                 | Salsa

data Pizza = Prepizza | Capa Ingrediente Pizza

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa i p) =
	1 + cantidadDeCapas p

cantidadDeAceitunas :: Pizza -> Int
cantidadDeAceitunas Prepizza   = 0
cantidadDeAceitunas (Capa i p) =
	aceitunas i + cantidadDeAceitunas p

aceitunas :: Ingrediente -> Int
aceitunas (Aceitunas n) = n
aceitunas i             = 0

duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza   = Prepizza
duplicarAceitunas (Capa i p) =
	Capa (dupAc i) (duplicarAceitunas p)

dupAc :: Ingrediente -> Ingrediente
dupAc (Aceitunas n) = Aceitunas (n*2)
dupAc i             = i

sinLactosa :: Pizza -> Pizza
sinLactosa Prepizza   = Prepizza
sinLactosa (Capa i p) =
	agregarSiNoEsQueso i (sinLactosa p)

agregarSiNoEsQueso :: Ingrediente -> Pizza -> Pizza
agregarSiNoEsQueso Queso p = p
agregarSiNoEsQueso i     p = Capa i p

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa Prepizza   = True
aptaIntolerantesLactosa (Capa i p) =
	noEsQueso i && aptaIntolerantesLactosa p

noEsQueso :: Ingrediente -> Bool
noEsQueso Queso = False
noEsQueso i     = True

conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada Prepizza   = Prepizza
conDescripcionMejorada (Capa i p) =
	juntarAc i (conDescripcionMejorada p)

juntarAc :: Ingrediente -> Pizza -> Pizza
juntarAc (Aceitunas n) (Capa (Aceitunas m) p) =
	Capa (Aceitunas (n+m)) p
juntarAc i             p =
	Capa i p

--------------------------------------------------

Propiedad 0:

-- para todo p
cantidadDeCapas (duplicarAceitunas p) = cantidadDeCapas p


-- voy a dem por ind est sobre p

Caso base p = Prepizza

cantidadDeCapas (duplicarAceitunas Prepizza)
=
cantidadDeCapas Prepizza


Caso ind. p = Capa i pz

HI) cantidadDeCapas (duplicarAceitunas pz) = cantidadDeCapas pz

TI) ¿ cantidadDeCapas (duplicarAceitunas (Capa i pz)) = cantidadDeCapas (Capa i pz) ?


cantidadDeCapas (duplicarAceitunas (Capa i pz))
= -- def duplicarAceitunas
cantidadDeCapas (Capa (dupAc i) (duplicarAceitunas pz))
= -- def cantidadDeCapas
1 + cantidadDeCapas (duplicarAceitunas pz)
= -- HI) 
1 + cantidadDeCapas pz

cantidadDeCapas (Capa i pz)
=
1 + cantidadDeCapas pz


Propiedad 1:

-- para todo p
cantidadDeAceitunas (duplicarAceitunas ​p​) =​ 2 * cantidadDeAceitunas ​p

-- dem por ind est sobre p

Caso base p = Prepizza

cantidadDeAceitunas (duplicarAceitunas ​Prepizza)
=
cantidadDeAceitunas ​Prepizza
=
0

2 * cantidadDeAceitunas ​Prepizza
=
2 * 0
=
0

Caso ind p = Capa i pz

HI) cantidadDeAceitunas (duplicarAceitunas pz​) =​ 2 * cantidadDeAceitunas pz
TI) cantidadDeAceitunas (duplicarAceitunas ​(Capa i pz)) =​ 2 * cantidadDeAceitunas ​(Capa i pz)

cantidadDeAceitunas (duplicarAceitunas ​(Capa i pz))
= -- def duplicarAceitunas
cantidadDeAceitunas (Capa (dupAc i) (duplicarAceitunas pz))
= -- def cantidadDeAceitunas
aceitunas (dupAc i) + cantidadDeAceitunas (duplicarAceitunas pz)
= -- HI)
aceitunas (dupAc i) + 2 * cantidadDeAceitunas pz
= -- doble-aceitunas-cosmico
2 * aceitunas i + 2 * cantidadDeAceitunas pz

2 * cantidadDeAceitunas ​(Capa i pz)
= -- def cantidadDeAceitunas
2 * (aceitunas i + cantidadDeAceitunas pz)
= -- prop dist.
2 * aceitunas i + 2 * cantidadDeAceitunas pz

--------------------------------------------

-- lema doble-aceitunas-cosmico

-- para todo i
aceitunas (dupAc i) = 2 * aceitunas i

-- voy a demostrar por casos sobre i

Caso i = Aceitunas n

aceitunas (dupAc (Aceitunas n))
= -- def dupAc
aceitunas (Aceitunas (2*n))
= -- def aceitunas
2 * n

2 * aceitunas (Aceitunas n)
= -- def aceitunas
2 * n

Caso i /= Aceitunas n

aceitunas (dupAc i)
= -- dupAc
aceitunas i
= -- def aceitunas
0

2 * aceitunas i
= -- def aceitunas
2 * 0
=
0

------------------------------------------------------------

Propiedad 2:

-- para todo p
cantidadDeAceitunas p
=
cantidadDeAceitunas (conDescripcionMejorada p)

-- voy a dem por ind est sobre p

Caso base p = Prepizza

-- trivial

Caso ind p = Capa i pz

HI)

cantidadDeAceitunas pz
=
cantidadDeAceitunas (conDescripcionMejorada pz)


TI)

¿
cantidadDeAceitunas (Capa i pz)
=
cantidadDeAceitunas (conDescripcionMejorada (Capa i pz))
?


cantidadDeAceitunas (Capa i pz)
= -- def cantidadDeAceitunas
aceitunas i + cantidadDeAceitunas pz
= -- HI)
aceitunas i + cantidadDeAceitunas (conDescripcionMejorada pz)


cantidadDeAceitunas (conDescripcionMejorada (Capa i pz))
= -- def conDescripcionMejorada
cantidadDeAceitunas (juntarAc i (conDescripcionMejorada pz))

---------------------------------------------------------------

-- para todo p, para todo i
aceitunas i + cantidadDeAceitunas p
=
cantidadDeAceitunas (juntarAc i p)

Voy a demostrar por casos


Caso i = Aceitunas n
     p = Capa (Aceitunas m) p

aceitunas (Aceitunas n) + cantidadDeAceitunas (Capa (Aceitunas m) p)
= -- def aceitunas
n + cantidadDeAceitunas (Capa (Aceitunas m) p)
= -- def cantidadDeAceitunas
n + aceitunas (Aceitunas m) + (cantidadDeAceitunas p)
= -- def aceitunas
n + m + cantidadDeAceitunas p

cantidadDeAceitunas (juntarAc (Aceitunas n) (Capa (Aceitunas m) p))
= -- def juntarAc
cantidadDeAceitunas (Capa (Aceitunas (n+m)) p)
= -- def cantidadDeAceitunas
aceitunas (Aceitunas (n + m)) + cantidadDeAceitunas p
= -- def aceitunas
n + m + cantidadDeAceitunas p



Caso para cualquier otra combinacion

cantidadDeAceitunas (juntarAc i p)
= -- def juntarAc
cantidadDeAceitunas (Capa i p)
= -- def cantidadDeAceitunas
aceitunas i + cantidadDeAceitunas p