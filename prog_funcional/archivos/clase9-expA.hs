data ExpA = Cte Int
          | Suma ExpA ExpA
          | Prod ExpA ExpA

f (Cte n) =
f (Suma ea1 ea2) =
	...
	f ea1
	...
	f ea2
f (Prod ea1 ea2) =
	...
	f ea1
	...
	f ea2

evalExpA :: ExpA -> Int
evalExpA (Cte n) = n
evalExpA (Suma ea1 ea2) =
	evalExpA ea1 + evalExpA ea2
evalExpA (Prod ea1 ea2) =
	evalExpA ea1 * evalExpA ea2

simpExpA :: ExpA -> ExpA
simpExpA (Cte n) = n
simpExpA (Suma ea1 ea2) =
	simpSuma (simpExpA ea1) (simpExpA ea2)
simpExpA (Prod ea1 ea2) =
	simpProd (simpExpA ea1) (simpExpA ea2)

simpSuma (Cte 0) m  = m
simpSuma n (Cte 0)  = n
simpSuma n m        = Suma n m

simpProd (Cte 0) m  = Cte 0
simpProd n (Cte 0)  = Cte 0
simpProd (Cte 1) m  = m
simpProd n (Cte 1)  = n
simpProd n m        = Prod n m

cantSumaCero :: ExpA -> Int
cantSumaCero (Cte n) = 0
cantSumaCero (Suma ea1 ea2) =
	  unoSiCero ea1
	+ unoSiCero ea2
	+ cantSumaCero ea1
	+ cantSumaCero ea2
cantSumaCero (Prod ea1 ea2) =
 	cantSumaCero ea1 + cantSumaCero ea2

unoSiCero (Cte 0) = 1
unoSiCero _       = 0

---------------------------------------

-- para todo ea
evalExpA (simpExpA ea) = evalExpA ea

-- Voy a demostrar por ind estr sobre ea

Caso base ea = Cte n

-- trivial

Caso ind ea = Suma ea1 ea2

HI.1) evalExpA (simpExpA ea1) = evalExpA ea1
HI.2) evalExpA (simpExpA ea2) = evalExpA ea2
TI) ¿ evalExpA (simpExpA (Suma ea1 ea2)) 
      = evalExpA (Suma ea1 ea2) ?

-- lado derecho
evalExpA (Suma ea1 ea2)
= -- def evalExpA
evalExpA ea1 + evalExpA ea2
= -- HI
evalExpA (simpExpA ea1) + evalExpA (simpExpA ea2)


-- lado izq
evalExpA (simpExpA (Suma ea1 ea2))
= -- def simpExpA
evalExpA (simpSuma (simpExpA ea1) 
	               (simpExpA ea2))
= -- por Lema dist evalEA-simpSuma
evalExpA (simpExpA ea1) + evalExpA (simpExpA ea2)


-- Lema dist evalEA-simpSuma
-- para todo ea1, ea2
evalExpA ea1 + evalExpA ea2
=
evalExpA (simpSuma ea1 ea2)


Caso 1
ea1 = (Cte 0)
ea2 = m

¿
evalExpA (Cte 0) + evalExpA m
=
evalExpA (simpSuma (Cte 0) m)
?

-- lado izq
evalExpA (Cte 0) + evalExpA m
=
0 + evalExpA m
=
evalExpA m

-- lado der
evalExpA (simpSuma (Cte 0) m)
=
evalExpA m

Caso 2
ea1 = n
ea2 = Cte 0

¿
evalExpA n + evalExpA (Cte 0)
=
evalExpA (simpSuma n (Cte 0))
?

-- Lo mismo que el anterior pero con el otro

Caso 3
ea1 = n y ea1 /= Cte 0
ea2 = m y ea2 /= Cte 0

¿
evalExpA n + evalExpA m
=
evalExpA (simpSuma n m)
?

-- lado der
evalExpA (simpSuma n m)
= -- def simpSuma
evalExpA (Suma n m)
=
evalExpA n + evalExpA m








Caso ind ea = Prod ea1 ea2

----------------------------------

-- para todo ea
cantSumaCero (simpExpA ea) = 0

-- Voy a demostrar por ind sobre ea

Caso base ea = Cte n

-- trivial

Caso ind ea = Suma ea1 ea2

HI.1) cantSumaCero (simpExpA ea1) = 0
HI.2) cantSumaCero (simpExpA ea2) = 0
TI) ¿ cantSumaCero (simpExpA (Suma ea1 ea2)) = 0 ?

cantSumaCero (simpExpA (Suma ea1 ea2))
= -- def simpExpA
cantSumaCero (simpSuma (simpExpA ea1) 
	                   (simpExpA ea2))

Caso 1
ea1 = Cte 0
ea2 = Cte 0

cantSumaCero (simpSuma (simpExpA (Cte 0)) 
	                   (simpExpA (Cte 0)))
= -- def simpExpA
cantSumaCero (simpSuma (Cte 0) (Cte 0))
= -- simpSuma
cantSumaCero (Cte 0)
=
0

Caso 2
ea1 = Cte 0
ea2 /= Cte 0

cantSumaCero (simpSuma (simpExpA (Cte 0)) 
	                   (simpExpA ea2))
= -- def simpExpA
cantSumaCero (simpSuma (Cte 0) (simpExpA ea2))
= -- def simpSuma
cantSumaCero (simpExpA ea2)
= -- HI)
0

Caso 3
ea1 /= Cte 0
ea2 = Cte 0

cantSumaCero (simpSuma (simpExpA ea1) 
	                   (simpExpA (Cte 0))
=
...
= -- def simpSuma
cantSumaCero (simpExpA ea1)
= -- HI
0

Caso 4
ea1 /= Cte 0
ea2 /= Cte 0

cantSumaCero (simpSuma (simpExpA ea1) 
	                   (simpExpA ea2))
= -- Lema cantSumaCero-simpSuma-Cuando-no-ceros
cantSumaCero (simpExpA ea1) 
+ cantSumaCero (simpExpA ea2)
=
0

------------------------------------
-- Lema cantSumaCero-simpSuma-Cuando-no-ceros

¿
Si
   ea1 /= Cte 0
y  ea2 /= Cte 0

entonces

cantSumaCero (simpSuma ea1 ea2)
=
cantSumaCero ea1 + cantSumaCero ea2
?

Demuestro suponiendo 
   ea1 /= Cte 0
y  ea2 /= Cte 0

cantSumaCero (simpSuma ea1 ea2)
= -- def simpSuma, caso 3, por la suposición que hice
cantSumaCero (Suma ea1 ea2)
= -- def cantSumaCero
  unoSiCero ea1
+ unoSiCero ea2
+ cantSumaCero ea1
+ cantSumaCero ea2
= -- def unoSiCero es 0, por la suposición que hice
  0
+ 0
+ cantSumaCero ea1
+ cantSumaCero ea2
= -- el cero es neutro de +
cantSumaCero ea1 + cantSumaCero ea2

--------------------------

Caso ind ea = Prod ea1 ea2

---------------------------------------

