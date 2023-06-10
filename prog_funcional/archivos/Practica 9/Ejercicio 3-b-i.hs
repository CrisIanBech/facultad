Ejercicio 3-b 

i)
para todo xs :: AppList a. para todo ys :: AppList a.
        lenAL (appendAL xs ys) = lenAL xs + lenAL ys

Elijo xs = a1, ys = a2

lenAL (appendAL a1 a2) = lenAL a1 + lenAL a2

--lado izq.
lenAL (appendAL a1 a2)
= --def. de appendAL
lenAL (Append a1 a1 )
= --def. lenAL
lenAL a1 + lenAL a1 ---- Llego a lado derecho? (esta bien esto asi?)







---------------------------------------------------------------------

Caso base xs = (Single a)
--lado izq.
 lenAL (appendAL (Single a) ys)
 = --def. de appendAL
 lenAL (Append (Single a) ys)
 = --def. de lenAL
lenAL (Single a) + lenAL ys

--lado der.
lenAL (Single a) + lenAL ys

Caso inductivo xs = (Append al1 al2)
HI1) lenAL (appendAL al1 ys) = lenAL a1 + lenAL ys
HI2) lenAL (appendAL al2 ys) = lenAL a2 + lenAL ys
TI) ¿lenAL (appendAL (Append al1 al2) ys) = lenAL (Append al1 al2) + lenAL ys?

--lado izq.
lenAL (appendAL (Append al1 al2) ys)
= --def. de appendAL
lenAL (Append (Append al1 al2) ys )
= --def. de lenAL
lenAL (Append al1 al2) + lenAL (Append al1 al2)










