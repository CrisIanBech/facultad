data Point = P Float Float
data Pen = NoColour | Colour Float Float Float
type Angle = Float
type Distance = Float
data Turtle = T Pen Angle Point

data TCommand = Go Distance
                | Turn Angle
                | GrabPen Pen
                | TCommand :#: TCommand


isValidT :: TCommand -> Bool
isValidT Go d = d > 0
isValidT Turn a = True
isValidT GrabPen p = True
isValidT (tc1 :#: tc2) = isValidT tc1 && isValidT tc2

	

compileT :: TCommand -> Turtle -> (LineAssembly,Turtle)
compileT (Go d) (T pen a pnt) = (LA [Line pen pnt d],( T pen a (endPoint pnt a 30)))
compileT (Turn ang) (T pen a pnt) = (LA [],( T pen (a + ang))
compileT (GrabPen p ) (T pen a pnt) = (LA [], (T p a pnt))
compileT (tc1 :#: tc2) (T pen a pnt) = compileT tc1 t ++ compileT tc2 t



	compileT triangle (T pen a p0) =
		let p1 = endPoint p0 a 30
			p2 = endPoint p1 (a+120) 30
			p3 = endPoint p2 (a+240) 30
		in (LA [ Line pen p0 p1, Line pen p1 p2, Line pen p2 p3 ]
		,T pen (a+360) p3)



optimizeT :: TCommand -> TCommand
optimizeT (Go d) = (Go d)
optimizeT (Turn a) = (Turn a)
optimizeT (GrabPen p) = (GrabPen p)
optimizeT (tc1 :#: tc2) = optimizeT (juntarSiIguales tc1 tc2)-- no es asi, es juntarSiIguales (op)


	juntarSiIguales :: TCommand -> TCommand -> TCommand
	juntarSiIguales (Go d) (Go d1) = (Go d + d1)
	juntarSiIguales (Turn a) (Turn a1) = (Turn a + a1)
	juntarSiIguales tc1 tc2 = tc1 :#: tc2



Demostrar que para todo p :: TCommand.
  si  validT p = True
 entonces   validT (optimizeT p) = True

--Elijo p = tc
validT tc = validT (optimizeT tc)

Caso tc = Go d
validT (Go d) = validT (optimizeT (Go d)) 
--lado der.
validT (optimizeT (Go d)
= -- def. optimizeT
validT (Go d) --llego a lado izq.

---------------------------

Caso base2 tc = (Turn a)
validT (Turn a) = validT (optimizeT (Turn a))

--lado der.
validT (optimizeT (Turn a))
= -- optimizeT
validT (Turn a) --llego a lado izq


Caso base3 tc = (GrabPen p)
validT (GrabPen p) = validT (optimizeT (GrabPen p))

--lado der.
validT (optimizeT (GrabPen p))
= -- def. de optimizeT
validT (GrabPen p) --llego a lado izq.




Caso inductivo tc = (tc1 :#: tc2)
validT (tc1 :#: tc2) = validT (optimizeT (tc1 :#: tc2))

HI1) validT tc1 = validT (optimizeT tc1)
HI1) validT tc2 = validT (optimizeT tc2)
TI) ¿validT (tc1 :#: tc2) = validT (optimizeT (tc1 :#: tc2))?

--lado izq.
validT (tc1 :#: tc2)
= --def. de validT
isValidT tc1 && isValidT tc2


--lado der. 
validT (optimizeT (tc1 :#: tc2))
= --def. de optimizeT
validT (juntarSiIguales (optimizeT tc1) (optimizeT tc2)))
= -- LEMA
isValidT (optimizeT tc1) && isValidT(optimizeT tc2)
= -- por HI 1 y 2
validT tc1 && isValidT tc2
---llego a lo mismo


-------LEMA
validT (juntarSiIguales (optimizeT tc1) (optimizeT tc2))) = isValidT (optimizeT tc1) && isValidT(optimizeT tc2)

--Demuestro por casos

Caso tc1 = Go d, tc2 = Go d1

--lado izq.
validT (optimizeT (juntarSiIguales (Go d) (Go d1)))
-- def. de juntarSiIguales
validT (optimizeT (Go d+d1))
= --def. de optimizeT
validT (Go d+d1)
= --def. de validT
d+d1 > 0

--lado der.
isValidT (optimizeT (Go d)) && isValidT(optimizeT (Go d1))
= -- def. de opitimizeT
isValidT (Go d) && isValidT (Go d1))
= --def. de isValidT
d > 0 && d1 > 0
= -- por artimetica
d+d1 > 0
---llego a lo mimsmo


Caso tc1 = (Turn a) , tc2 = (Turn a1)


--lado izq.
validT (optimizeT (juntarSiIguales (Turn a) (Turn a1)))
-- def. de juntarSiIguales
validT (optimizeT (Turn a +a1)
= --def. de optimizeT
validT (Turn a +a1)
= --def. de validT
a+a1 > 0

--lado der.
isValidT (optimizeT (Turn a)) && isValidT(optimizeT (Turn a1)))
= -- def. de opitimizeT
isValidT (Turn a) && isValidT (Turn a1)
= --def. de isValidT
a > 0 && a1 > 0
= -- por artimetica
a+a1 > 0
---llego a lo mimsmo



Caso tc1 /= (Go d) y tc2 /= (Go d1) o tc1 /= (Turn a) y tc2 /= (Turn a2)
(cuando no son los dos Go o los dos Turn)

validT (juntarSiIguales (optimizeT tc1) (optimizeT tc2))) = isValidT (optimizeT tc1) && isValidT(optimizeT tc2)

--lado izq.
validT (juntarSiIguales (optimizeT tc1) (optimizeT tc2)))
= -- def. de juntarSiIguales
validT (tc1 :#: tc2)
= -- def. de validT
isValidT tc1 && isValidT tc2

--lado der.
isValidT (optimizeT tc1) && isValidT (optimizeT tc2)
= -- def. optimizeT
isValidT tc1 && isValidT tc2

--llego a lo mismo

-- lema demostrado
