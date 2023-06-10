data NExp = Var Variable
		  | NCte Int
		  | NBOp NBinOp NExp NExp

data NBinOp = Add | Mul

type Variable = String

f (Var v) =
f (NCte n) =
f (NBOp op e1 e2) =
	f e1
	f e2

evalNExp :: NExp -> Memoria -> Int
evalNExp (Var v)  m = fromJust (cuantoVale v m)
evalNExp (NCte n) m = n
evalNExp (NBOp op e1 e2) m =
	evalOp op (evalNExp e1 m) (evalNExp e2 m)

evalOp Add n1 n2 = n1 + n2
evalOp Mul n1 n2 = n1 * n2

fromJust (Just x) = x
fromJust Nothing  = error "no hay valor"

cfNExp :: NExp -> NExp
cfNExp (Var v)  = Var v
cfNExp (NCte n) = NCte n
cfNExp (NBOp op e1 e2) =
	simpBOp op (cfNExp e1) (cfNExp e2)

simpBOp Add e1 e2 = simpAdd e1 e2
simpBOp Mul e1 e2 = simpMul e1 e2

simpAdd (NCte 0) e2       = e2
simpAdd e1 (NCte 0)       = e1
simpAdd (NCte n) (NCte m) = NCte (n+m)
simpAdd e1 e2             = NBOp Add e1 e2

simpMul (NCte 1) e2       = e2
simpMul e1 (NCte 1)       = e1
simpMul (NCte 0) e2       = NCte 0
simpMul e1 (NCte 0)       = NCte 0
simpMul (NCte n) (NCte m) = NCte (n*m)
simpMul e1 e2             = NBOp Mul e1 e2

---------------------------------------------

evalNExp . cfNExp ​=​ evalNExp

-- ppio de ext.

-- para todo e
(evalNExp . cfNExp) e ​=​ evalNExp e

-- por definición de (.) es equivalente a
evalNExp (cfNExp e) ​=​ evalNExp e

-- dem. por inducción sobre e

Caso base e = Var v

¿evalNExp (cfNExp (Var v)) ​=​ evalNExp (Var v)?

-- lado izq
evalNExp (cfNExp (Var v))
= -- def cfNExp
evalNExp (Var v)
-- lado der

Caso base e = NCte n

¿evalNExp (cfNExp (NCte n)) ​=​ evalNExp (NCte n)?

-- lado izq
evalNExp (cfNExp (NCte n))
= -- def cfNExp
evalNExp (NCte n)
-- lado der

Caso ind. e = NBOp op e1 e2

HI.1) evalNExp (cfNExp e1) ​=​ evalNExp e1
HI.2) evalNExp (cfNExp e2) ​=​ evalNExp e2

TI) ¿evalNExp (cfNExp (NBOp op e1 e2)) ​=​ evalNExp (NBOp op e1 e2)?

Caso 1: op = Add

-- lado izq
evalNExp (cfNExp (NBOp Add e1 e2))
= -- def cfNExp
evalNExp (simpBOp Add (cfNExp e1) (cfNExp e2))
= -- def simpBOp
evalNExp (simpAdd (cfNExp e1) (cfNExp e2))
= -- lema 1
evalNExp (cfNExp e1) + evalNExp (cfNExp e2)

-- lado der
evalNExp (NBOp Add e1 e2)
= -- def evalNExp
evalOp Add (evalNExp e1) (evalNExp e2)
= -- def evalOp
evalNExp e1 + evalNExp e2
= -- HI)
evalNExp (cfNExp e1) + evalNExp (cfNExp e2)


Caso 2: op = Mul

-- lado izq
evalNExp (cfNExp (NBOp Mul e1 e2))
= -- def cfNExp
evalNExp (simpBOp Mul (cfNExp e1) (cfNExp e2))
= -- def simpBOp
evalNExp (simpMul (cfNExp e1) (cfNExp e2))
= -- lema 2
evalNExp (cfNExp e1) * evalNExp (cfNExp e2)

-- lado der
evalNExp (NBOp Mul e1 e2)
= -- def evalNExp
evalOp Mul (evalNExp e1) (evalNExp e2)
= -- def evalOp
evalNExp e1 * evalNExp e2
= -- HI)
evalNExp (cfNExp e1) * evalNExp (cfNExp e2)

-- lado der

----------------------------------------------

-- lema 1

evalNExp (simpAdd e1 e2) = evalNExp e1 + evalNExp e2

-------------------------------------------
Caso e1 = (NCte 0) y e2 cualquier expresion
-------------------------------------------

¿evalNExp (simpAdd (NCte 0) e2) = evalNExp (NCte 0) + evalNExp e2?

-- lado izq
evalNExp (simpAdd (NCte 0) e2)
= -- def simpAdd
evalNExp e2

-- lado der
evalNExp (NCte 0) + evalNExp e2
= -- def evalNExp
0 + evalNExp e2
= -- arit.
evalNExp e2

-------------------------------------------
Caso e1 cualquier expresion diferente al caso anterior y e2 = NCte 0
-------------------------------------------

¿evalNExp (simpAdd e1 (NCte 0)) = evalNExp e1 + evalNExp (NCte 0)?

-- lo mismo pero me va a quedar evalNExp e1

-------------------------------------------
Caso e1 = NCte n y e2 = NCte m
-------------------------------------------

¿evalNExp (simpAdd (NCte n) (NCte m)) = evalNExp (NCte n) + evalNExp (NCte m)?

evalNExp (simpAdd (NCte n) (NCte m))
= -- def simpAdd
evalNExp (NCte (n+m))
= -- def evalNExp
n + m

evalNExp (NCte n) + evalNExp (NCte m)
= -- def evalNExp x 2
n + m

-------------------------------------------
Caso e1 y e2 cualquier expresion diferente a los casos anteriores
-------------------------------------------

¿evalNExp (simpAdd e1 e2) = evalNExp e1 + evalNExp e2?

-- lado izq
evalNExp (simpAdd e1 e2)
= -- def simpAdd
evalNExp (NBOp Add e1 e2)
= -- def evalNExp
evalOp Add (evalNExp e1) (evalNExp e2)
= -- def evalOp
evalNExp e1 + evalNExp e2