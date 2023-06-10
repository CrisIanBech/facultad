data Programa = Prog Bloque
type Bloque = [Comando]
data Comando = Assign Nombre NExp
				| If BExp Bloque Bloque
				| While BExp Bloque


evalProg :: Programa -> Memoria -> Memoria
evalProg (Prog bl) = \mem -> evalBloque b1 mem


evalBloque :: Bloque -> Memoria -> Memoria
evalBloque [] = \mem -> mem
evalBloque (x:xs) = \mem -> let mem' = evalComando x mem 
									in evalBloque xs mem'

evalComando :: Comando -> Memoria -> Memoria
evalComando (Assign nom ne) = \mem -> recordar nom (evalNExp ne mem) mem
evalComando (If be b1 b2) = \mem -> if (evalBExp be mem)
									then (evalBloque b1 mem)
									else (evalBloque b2 mem)
evalComando (While be b1) = evalComando (If be (b1 ++ [While be b1]) [])

optimizeCf :: Programa -> Programa
optimizeCf (Prog bl) = Prog (optimizeBl bl)

optimizeBl :: Bloque -> Bloque
optimizeBl [] = []
optimizeBl (x:xs) =	optimizeComand x : optimizeBl xs

optimizeComand :: Comando -> Comando
optimizeComand (Assign n ne) = Assign n (cfNExp ne)
optimizeComand (If be bl1 bl2) = If (cfBExp be) (optimizeBl bl1) (optimizeBl bl2)
optimizeComand (While be bl) = While (cfBExp be) (optimizeBl bl)