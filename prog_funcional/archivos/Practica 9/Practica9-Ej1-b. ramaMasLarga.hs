Ejercicio 3) B
Demostrar:

heightT = length . ramaMasLarga
por ppio. de ext. para todo a Arbol, heightT a = (length . ramaMasLarga) a 
por def. de (.) (length . ramaMasLarga) a = length(ramaMasLarga a)
Elijo: a = ar 

Caso base ar = EmptyT

--lado izq.
heightT EmptyT 
= --def. de height
0

--lado der.
length (ramaMasLarga EmptyT)
= --def. ramaMasLarga
length []
= --def. de length
0

Caso inductivo ar = (NodeT x t1 t2)
HI1)- heightT t1 = length(ramaMasLarga t1)
HI2)- heightT t2 = length(ramaMasLarga t2)
TI)- ¿heightT (NodeT x t1 t2) = length(ramaMasLarga (NodeT x t1 t2))?

--lado izq.
heightT (NodeT x t1 t2)
= --def. de heightT
1 + max (heightT t1) (heightT t2)
= --por HI 1 y 2
1 + max (length(ramaMasLarga t1)) (length(ramaMasLarga t2))
= --LEMA Aux.               ----------- Ver siempre como te conviene tener los tipos, si en lista o en arbol o en int
1 + length(mayorRama (ramaMasLarga t1) (ramaMasLarga t2))
= --def. de length
length(x : mayorRama (ramaMasLarga t1) (ramaMasLarga t2))
= --def. de ramaMasLarga
length(ramaMasLarga (NodeT x t1 t2))
--------llegue a lado der.


--LEMA Aux:
max (length(ramaMasLarga t1)) (length(ramaMasLarga t2)) = length(mayorRama (ramaMasLarga t1) (ramaMasLarga t2))

ramaMasLarga t1 = xs -----puedo decir esto porque ramaMasLarga me devuelve una lista, entonces llamo xs a esa lista resultante
ramaMasLarga t2 = ys 

--Demuestro por casos

Caso xs > ys
--lado izq.
max (length xs) (length ys)
= --def. de max
(length xs)

--lado der.
length(mayorRama xs ys)
= --def. de mayorRama
length xs

------------------------------

Caso xs <= ys
--lado izq.
max (length xs) (length ys)
= --def. de max
(length ys)

--lado der.
length(mayorRama xs ys)
= --def. de mayorRama
length ys
---------------------------lema demostrado
