data Programa = Prog Bloque
type Bloque = [Comando]
data Comando = Assign Nombre NExp
                | If BExp Bloque Bloque
                | While BExp Bloque

evalProg :: Programa -> Memoria -> Memoria
evalProg (Prog bloque) = evalBlq bloque

evalBlq :: Bloque -> Memoria -> Memoria
evalBlq []      = \mem -> mem
evalBlq (c:cs)  = \mem -> let mem' = evalCom c
                    in evalBlq cs mem'

evalCom :: Comando -> Memoria -> Memoria
evalCom (Assign n exp)  = \mem -> recordar n (evalNExp exp mem) mem
evalCom (If bexp b1 b2) = \mem -> if(evalBExp bexp mem)
                            then evalBlq b1 mem
                            else evalBlq b2 mem
evalCom (While bexp b)  = evalCom (If bexp (b ++ [While bexp b]) [])

optimizeCF :: Programa -> Programa
optimizeCF (Prog bq) = optimizeCFBQ bq

optimizeCFBQ :: Bloque -> Bloque
optimizeCFBQ [] = []
optimizeCFBQ (cm:cms) = optimizeCFCM cm (optimizeCFBQ cms)

optimizeCFCM :: Comando -> Comando
optimizeCFCM (Assign n nexp) bq = (Assign n nexp) : bq
optimizeCFCM (If bexp b1 b2) bq = optimizeCFIF bexp b1 b2 bq
optimizeCFCM (While bexp b) bq = optimizeCFWH bexp b bq

optimizeCFIF :: BExp -> Bloque -> Bloque -> Bloque -> Comando
optimizeCFIF bexp b1 b2 bq = case cfBExp bexp of 
                             (BCte True) -> b1 : bq 
                             (BCte False) -> b2 : bq 
                             bexp' -> (If bexp' b1 b2) : bq

optimizeCFWH :: BExp -> Bloque -> Bloque -> Comando
optimizeCFWH bexp bloq bqs = case cfBExp bexp of
                                (BCte True) -> error "loop infinito" 
                                (BCte False) -> bqs
                                bexp' -> (While bexp' bloq) : bqs