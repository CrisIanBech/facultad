data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Aceitunas Int
                 | Jamon
                 | Queso
                 | Salsa

-- f Prepizza     =
-- f (Capa ing p) = ... f p ...

cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza     = 0
cantidadDeCapas (Capa ing p) = 1 + cantidadDeCapas p

-- dos casos inductivos al demostrar
-- cantidadDeAceitunas :: Pizza -> Int
-- cantidadDeAceitunas Prepizza     = 0
-- cantidadDeAceitunas (Capa ing p) =
-- 	if esAceitunas ing
-- 	   then aceitunas ing + cantidadDeAceitunas p
-- 	   else cantidadDeAceitunas p

-- esAceitunas (Aceitunas n) = True
-- esAceitunas _ = False

aceitunas :: Ingrediente -> Int
aceitunas (Aceitunas n) = n
aceitunas _             = 0

cantidadDeAceitunas :: Pizza -> Int
cantidadDeAceitunas Prepizza     = 0
cantidadDeAceitunas (Capa ing p) =
	aceitunas ing + cantidadDeAceitunas p

-- dos casos inductivos al demostrar
-- duplicarAceitunas​ :: Pizza -> Pizza
-- duplicarAceitunas​ Prepizza     = Prepizza
-- duplicarAceitunas​ (Capa ing p) = 
-- 	if esAceitunas ing
-- 	   then Capa (duplicarAc ing) (duplicarAceitunas​ p)
-- 	   else Capa ing (duplicarAceitunas​ p)


-- duplicarAc (Aceitunas n) = Aceitunas (n*2)
-- duplicarAc _             = error "no puedo"

duplicarAceitunas​ :: Pizza -> Pizza
duplicarAceitunas​ Prepizza     = Prepizza
duplicarAceitunas​ (Capa ing p) = 
	Capa (duplicarAc ing) (duplicarAceitunas​ p)

duplicarAc (Aceitunas n) = Aceitunas (n*2)
duplicarAc ing           = ing

sinLactosa :: Pizza -> Pizza
sinLactosa Prepizza     = Prepizza
sinLactosa (Capa ing p) = 
   agregarSiNoEsQueso ing (sinLactosa p)

-- No agrego queso a una pizza sin queso
agregarSiNoEsQueso :: Ingrediente -> Pizza -> Pizza
agregarSiNoEsQueso Queso p = p
agregarSiNoEsQueso ing   p = Capa ing p

-- agregarSiNoEsQueso :: Ingrediente -> Pizza -> Pizza
-- agregarSiNoEsQueso Queso = id
-- agregarSiNoEsQueso ing   = Capa ing

aptaIntolerantesLactosa :: Pizza -> Bool
aptaIntolerantesLactosa Prepizza     = True
aptaIntolerantesLactosa (Capa ing p) =
	not (esQueso ing) && aptaIntolerantesLactosa p

esQueso Queso = True
esQueso _     = False

-- aptaIntolerantesLactosa (Capa ing p) =
-- 	noEsQueso ing && aptaIntolerantesLactosa p

-- noEsQueso Queso = False
-- noEsQueso _     = True

-- normalización
conDescripcionMejorada :: Pizza -> Pizza
conDescripcionMejorada Prepizza     = Prepizza
conDescripcionMejorada (Capa ing p) = 
	comprimirAceitunas ing (conDescripcionMejorada p)

comprimirAceitunas (Aceitunas n) (Capa (Aceitunas m) p) = Capa (Aceitunas (n+m)) p
comprimirAceitunas ing p = Capa ing p


juntarCapas :: Pizza -> Pizza -> Pizza
juntarCapas Prepizza pz2 = pz2
juntarCapas (Capa ing pz) pz2 =
	Capa ing (juntarCapas pz pz2)

----------------------------------------------------

-- Propiedad 1
-- para todo pz
cantidadDeCapas (duplicarAceitunas pz) = cantidadDeCapas pz

-- Voy a demostrar por induccion estructural sobre cualquier pz

Caso base pz = Prepizza

¿ cantidadDeCapas (duplicarAceitunas Prepizza) = cantidadDeCapas Prepizza ?

-- lado der
cantidadDeCapas (duplicarAceitunas Prepizza)
= -- def duplicarAceitunas
cantidadDeCapas Prepizza
-- lado izq

Caso ind pz = Capa ing p

HI) cantidadDeCapas (duplicarAceitunas p) = cantidadDeCapas p
TI) ¿ cantidadDeCapas (duplicarAceitunas (Capa ing p)) = cantidadDeCapas (Capa ing p) ?

cantidadDeCapas (duplicarAceitunas (Capa ing p))
= -- def duplicarAceitunas
cantidadDeCapas (Capa (duplicarAc ing) (duplicarAceitunas​ p))
= -- def cantidadDeCapas
1 + cantidadDeCapas (duplicarAceitunas​ p)
= -- HI)
1 + cantidadDeCapas p

cantidadDeCapas (Capa ing p)
= -- def cantidadDeCapas
1 + cantidadDeCapas p

-----------------------------------------------------------

-- para todo pz1, pz2
cantidadDeCapas (juntarCapas pz1 pz2) = cantidadDeCapas pz1 + cantidadDeCapas pz2

-- Voy a demostrar por induccion estructural sobre cualquier pz1

Caso base pz1 = Prepizza

¿ cantidadDeCapas (juntarCapas Prepizza pz2) = cantidadDeCapas Prepizza + cantidadDeCapas pz2 ?

cantidadDeCapas (juntarCapas Prepizza pz2)
= -- def juntarCapas
cantidadDeCapas pz2

cantidadDeCapas Prepizza + cantidadDeCapas pz2
= -- def cantidadDeCapas
0 + cantidadDeCapas pz2
= -- neutro de la suma
cantidadDeCapas pz2

Caso ind pz = Capa ing p

HI) cantidadDeCapas (juntarCapas p pz2) = cantidadDeCapas p + cantidadDeCapas pz2
TI) ¿ cantidadDeCapas (juntarCapas (Capa ing p) pz2) = cantidadDeCapas (Capa ing p) + cantidadDeCapas pz2 ?

-- lado izq
cantidadDeCapas (juntarCapas (Capa ing p) pz2)
= -- def juntarCapas
cantidadDeCapas (Capa ing (juntarCapas p pz2))
= -- def cantidadDeCapas
1 + cantidadDeCapas (juntarCapas p pz2)
= -- HI
1 + (cantidadDeCapas p + cantidadDeCapas pz2)
= -- asociatividad de la suma
(1 + cantidadDeCapas p) + cantidadDeCapas pz2

-- lado der
cantidadDeCapas (Capa ing p) + cantidadDeCapas pz2
= -- def cantidadDeCapas
(1 + cantidadDeCapas p) + cantidadDeCapas pz2


--------------------------------------------------
-- Alternativa

-- lado izq
cantidadDeCapas (juntarCapas (Capa ing p) pz2)
= -- def juntarCapas
cantidadDeCapas (Capa ing (juntarCapas p pz2))
= -- def cantidadDeCapas
1 + cantidadDeCapas (juntarCapas p pz2)
= -- HI
1 + (cantidadDeCapas p + cantidadDeCapas pz2)
= -- asociatividad de la suma
(1 + cantidadDeCapas p) + cantidadDeCapas pz2
= -- def cantidadDeCapas
cantidadDeCapas (Capa ing p) + cantidadDeCapas pz2
-- lado der

---------------------------------------------------

-- para todo pz
cantidadDeAceitunas pz = cantidadDeAceitunas (conDescripcionMejorada pz)

-- Voy a demostrar por induccion estructural sobre cualquier pz

Case base pz = Prepizza

¿ cantidadDeAceitunas Prepizza = cantidadDeAceitunas (conDescripcionMejorada Prepizza) ?

-- lado der
cantidadDeAceitunas (conDescripcionMejorada Prepizza)
= -- def conDescripcionMejorada
cantidadDeAceitunas Prepizza
-- lado izq

Caso ind pz = Capa ing p

HI) cantidadDeAceitunas p = cantidadDeAceitunas (conDescripcionMejorada p)
TI) ¿ cantidadDeAceitunas (Capa ing p) = cantidadDeAceitunas (conDescripcionMejorada (Capa ing p)) ?

-- lado der
cantidadDeAceitunas (conDescripcionMejorada (Capa ing p))
= -- def conDescripcionMejorada
cantidadDeAceitunas (comprimirAceitunas ing (conDescripcionMejorada p))
= -- lema cantidadDeAceitunas-comprimirAceitunas
aceitunas ing + cantidadDeAceitunas (conDescripcionMejorada p)

-- lado izq
cantidadDeAceitunas (Capa ing p)
= -- def cantidadDeAceitunas
aceitunas ing + cantidadDeAceitunas p
= -- HI
aceitunas ing + cantidadDeAceitunas (conDescripcionMejorada p)

--------------------------------------------------------------

-- lema cantidadDeAceitunas-comprimirAceitunas

-- para todo pz.
cantidadDeAceitunas (comprimirAceitunas ing pz)
=
aceitunas ing + cantidadDeAceitunas pz

-- Voy a demostrar por casos
Caso ing = Aceitunas n
     pz  = Capa (Aceitunas m) p
--------------------------------

¿
cantidadDeAceitunas (comprimirAceitunas (Aceitunas n) (Capa (Aceitunas m) p))
= -- ¿lema?
aceitunas (Aceitunas n) + cantidadDeAceitunas (Capa (Aceitunas m) p)
?

-- lado izq
cantidadDeAceitunas (comprimirAceitunas (Aceitunas n) (Capa (Aceitunas m) p))
= -- def comprimirAceitunas
cantidadDeAceitunas (Capa (Aceitunas (n+m)) p)
= -- def cantidadDeAceitunas
aceitunas (Aceitunas (n+m)) + cantidadDeAceitunas p
= -- def aceitunas
n + m + cantidadDeAceitunas p

-- lado der
aceitunas (Aceitunas n) + cantidadDeAceitunas (Capa (Aceitunas m) p)
= -- def aceitunas
n + cantidadDeAceitunas (Capa (Aceitunas m) p)
= -- def cantidadDeAceitunas
n + aceitunas (Aceitunas m) + cantidadDeAceitunas p
= -- def  aceitunas
n + m + cantidadDeAceitunas p

Caso cualquier otra combinación de ing y pz
-------------------------------------------

¿
cantidadDeAceitunas (comprimirAceitunas ing pz)
= -- ¿lema?
aceitunas ing + cantidadDeAceitunas pz
?

-- lado izq
cantidadDeAceitunas (comprimirAceitunas ing pz)
= -- def comprimirAceitunas
cantidadDeAceitunas (Capa ing pz)
= -- def cantidadDeAceitunas
aceitunas ing + cantidadDeAceitunas pz
-- lado der
