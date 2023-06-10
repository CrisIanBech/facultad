data ExpA = Cte Int
    | Suma ExpA ExpA
    | Prod ExpA ExpA

evalExpA :: ExpA -> Int
evalExpA (Cte n) = n
evalExpA (Suma exp1 exp2) = evalExpA exp1 + evalExpA exp2
evalExpA (Prod exp1 exp2) = evalExpA exp1 * evalExpA exp2

simplificarExpA :: ExpA -> ExpA
simplificarExpA (Cte n) = (Cte n)
simplificarExpA (Suma exp1 exp2) = sinSumaDeCero simplificarExpA exp1 simplificarExpA exp2
simplificarExpA (Prod exp1 exp2) = sinProdRedundante simplificarExpA exp1 simplificarExpA exp2

sinSumaDeCero :: ExpA -> ExpA -> ExpA
sinSumaDeCero (Cte 0) exp = exp
sinSumaDeCero exp (Cte 0) = exp
sinSumaDeCero exp1 exp2 = (Suma exp1 exp2)

sinProdRedundante :: ExpA -> ExpA -> ExpA
sinProdRedundante (Cte 0) exp = (Cte 0)
sinProdRedundante exp (Cte 0) = (Cte 0)
sinProdRedundante (Cte 1) exp = exp
sinProdRedundante exp (Cte 1) = exp
sinProdRedundante exp1 exp2 = Prod exp1 exp2 

cantidadDeSumaCero :: ExpA -> Int
cantidadDeSumaCero (Cte n) = 0
cantidadDeSumaCero (Prod exp1 exp2) = 0 + cantidadDeSumaCero exp1 + cantidadDeSumaCero exp2
cantidadDeSumaCero (Sum exp1 exp2) = unoSiSumaCeroCeroSino exp1 exp2 + cantidadDeSumaCero exp1 + cantidadDeSumaCero exp2

unoSiSumaCeroCeroSino (Cte 0) exp2 = 1
unoSiSumaCeroCeroSino exp1 (Cte 0) = 1
unoSiSumaCeroCeroSino _ _          = 0

data ExpS = CteS N
    | SumS ExpS ExpS
    | ProdS ExpS ExpS

evalES :: ExpS -> Int
evalES (CteS n) = evalN n
evalES (SumS exp1 exp2) = evalES exp1 + evalES exp2
evalES (ProdS exp1 exp2) = evalES exp1 * evalES exp2

es2ExpA :: ExpS -> ExpA
es2ExpA (CteS n) = (Cte evalN n)
es2ExpA (SumS exp1 exp2) = (Suma es2ExpA exp1 es2ExpA exp2)
es2ExpA (ProdS exp1 exp2) = (Prod es2ExpA exp1 es2ExpA exp2)

expA2es :: ExpA -> ExpS
expA2es (Cte n) = (CteS int2N n)
expA2es (Suma exp1 exp2) = (SumS expA2es exp1 expA2es exp2)
expA2es (Prod exp1 exp2) = (ProdS expA2es exp1 expA2es exp2)

Ej 2)

    
    Prop.: ¿evalExpA . simplificarExpA = evalExpA?
    Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
    ¿para todo x :: ExpA. evalExpA . simplificarExpA x = evalExpA x?

    Sea e :: ExpA
    Por ppio. de inducción en la estructura de NBin:
    ¿evalExpA . simplificarExpA e = evalExpA e?

    Caso base: e = Cte n )
        ¿evalExpA . simplificarExpA (Cte n) = evalExpA (Cte n)?

    Caso inductivo 1: n = (Suma ex1 ex2) )
        HI 1) ¿evalExpA . simplificarExpA ex1 = evalExpA ex1!
        HI 2) ¿evalExpA . simplificarExpA ex2 = evalExpA ex2!
        TI) ¿evalExpA . simplificarExpA (Suma ex1 ex2) = evalExpA (Suma ex1 ex2)?

    Caso inductivo 2: n = (Prod ex1 ex2) )
        HI 1) ¿evalExpA . simplificarExpA ex1 = evalExpA ex1!
        HI 2) ¿evalExpA . simplificarExpA ex2 = evalExpA ex2!
        TI) ¿evalExpA . simplificarExpA (Prod ex1 ex2) = evalExpA (Prod ex1 ex2)?

    Dem. caso base:
        LI:
        evalExpA . simplificarExpA (Cte n)
        = def. op. .
        evalExpA (simplificarExpA (Cte n))
        = def. simplificarExpA.1
        evalExpA (Cte n)
        = def. evalExpA.1
        n

        LD:
        evalExpA (Cte n)
        = def. evalExpA.1
        n

        Se llega al mismo resultado. Se cumple para este caso

    Dem.: caso inductivo 1:
        LI:
        evalExpA . simplificarExpA (Suma ex1 ex2)
        = def. op. .
        evalExpA (simplificarExpA (Suma ex1 ex2))
        = def. simplificarExpA.2
        evalExpA (sinSumaDeCero (simplificarExpA ex1) (simplificarExpA ex2))
        = LEMA 1
        evalExpA . simplificarExpA ex1 + evalExpA . simplificarExpA ex2
        = HI 1 e HI 2
        evalExpA ex1 + evalExpA ex2

        LD:
        evalExpA (Suma ex1 ex2)
        = def. evalExpA.2
        evalExpA ex1 + evalExpA ex2



        LEMA 1:
        evalExpA (sinSumaDeCero ex1 ex2) = evalExpA ex1 + evalExpA ex2

        Análisis por casos:

        Caso 1: ex1 = (Cte 0), ex2 = m
        Caso 2: ex1 = m, ex2 = (Cte 0)
        Caso 3, ex1 y ex2 != (Cte 0)

        Dem. caso 1:
        LI:
        evalExpA (sinSumaDeCero (Cte 0) ex2)
        = def. sinSumaDeCero.1
        evalExpA ex2

        LD:
        evalExpA (Cte 0) + evalExpA ex2
        = def. evalExpA.1
        0 + evalExpA ex2
        = s. neutro de suma
        evalExpA ex2

        Dem.caso 2:
        LI:
        evalExpA (sinSumaDeCero ex1 (Cte 0))
        = def. sinSumaDeCero.1
        evalExpA ex1

        LD:
        evalExpA ex1 + evalExpA (Cte 0)
        = def. evalExpA.1
        evalExpA ex1 + 0
        = s. neutro de suma
        evalExpA ex1
        
        Dem. caso 3:
        LI:
        evalExpA (sinSumaDeCero n m)
        = def. sinSumaDeCero.1
        evalExpA (Suma n m)
        =
        evalExpA n + evalExpA m

        LD:
        evalExpA n + evalExpA m

        ii.
        Prop.: ¿cantidadSumaCero . simplificarExpA = const 0?
        Dem.: Por ppio. de extensionalidad, y siendo x :: ExpA es equivalente demostrar que:
            ¿cantidadSumaCero . simplificarExpA x = const 0 x?
            Por ppio. de inducción en la estructura de x:

            Caso base 1: x = (Cte n)

            Caso inductivo 1: x = (Suma e1 e2)
                HI.1) ¡cantidadDeSumaCero . simplificarExpA e1 = const 0 e1!
                HI.2) ¡cantidadDeSumaCero . simplificarExpA e2 = const 0 e2!
                TI) ¿cantidadSumaCero . simplificarExpA (Suma e1 e2) = const 0 (Suma e1 e2)?
                
            Caso inductivo 2: x = (Prod e1 e2)
                HI.1) ¡cantidadDeSumaCero . simplificarExpA e1 = const 0 e1!
                HI.2) ¡cantidadDeSumaCero . simplificarExpA e2 = const 0 e2!
                TI) ¿cantidadSumaCero . simplificarExpA (Prod e1 e2) = const 0 (Prod e1 e2)?

        Dem. caso base:
        LI:
        cantidadSumaCero . simplificarExpA (Cte n)
        = def. op. .
        cantidadSumaCero (simplificarExpA (Cte n))
        = def. simplificarExpA.1
        cantidadSumaCero (Cte n)
        =
        0

        LD:
        const 0 (Cte n)
        = def. const
        0

        Se llega al mismo resultado en ambos lados. Se cumple para esta propiedad.

        Dem. caso inductivo 1:
        LI:
        cantidadSumaCero . simplificarExpA (Suma e1 e2)
        = def. op. .
        cantidadSumaCero (simplificarExpA (Suma e1 e2))
        = def. simplificarExpA.2
        cantidadDeSumaCero (sinSumaDeCero (simplificarExpA exp1) (simplificarExpA exp2))
        = LEMA 2
        cantidadSumaCero . simplificarExpA e1 + cantidadDeSumaCero . simplificarExpA e2
        = HI 1 y HI 2
        const 0 e1 + const 0 e2
        = def. const
        0 + 0
        = aritmetica
        0

        LD:
        const 0 (Suma e1 e2)
        = def. const
        0

    Dem. caso inductivo 2:
        LI:
        cantidadSumaCero . simplificarExpA (Prod e1 e2)
        = def. op. .
        cantidadSumaCero (simplificarExpA (Prod e1 e2))
        = LEMA 3
        cantidadSumaCero . simplificarExpA e1 * cantidadDeSumaCero . simplificarExpA e2
        = HI 1 y HI 2
        const 0 e1 * const 0 e2
        = def. const
        0 * 0
        = aritmetica
        0

        LD:
        const 0 (Prod e1 e2)
        = def. const
        0

    Dem. caso inductivo 3:
        LI:
        cantidadSumaCero . simplificarExpA (Prod e1 e2)
        = def. op. .
        cantidadSumaCero (simplificarExpA (Prod e1 e2))
        = def. simplificarExpA.3
        cantidadSumaCero (sinProdRedundante (simplificarExpA e1) (simplificarExpA e2))
        = LEMA 3.
        cantidadSumaCero . simplificarExpA e1 + cantidadSumaCero . simplificarExpA e2
        = HI 1 y HI 2
        const 0 e1 + const 0 e2
        = def. const
        0 + 0
        = aritmetica
        0

        LEMA 1:
        cantidadDeSumaCero (sinSumaDeCero e1 e2) = cantidadDeSumaCero e1 + cantidadDeSumaCero e2

        Por análisis de casos:
        Caso 1: e1 = (Cte 0)
        Caso 2: e2 = (Cte 0)
        Caso 3: e1 y e2 != (Cte 0)

        Dem. caso 1:
        LI:
        cantidadSumaCero (sinSumaDeCero (Cte 0) e2)
        = def. sinSumaDeCero.1
        cantidadSumaCero e2

        LD:
        cantidadDeSumaCero (Cte 0) + cantidadDeSumaCero e2
        = Def. cantidadDeSumaCero.1
        0 + cantidadDeSumaCero e2
        = neutro suma
        cantidadDeSumaCero e2

        -- El caso 2 es igual que el 1 pero al revés, no lo voy a hacer

        Dem. caso 3:
        LI:
        cantidadSumaCero (sinSumaDeCero e1 e2)
        = def. sinSumaDeCero.3
        cantidadDeSumaCero (Suma e1 e2)
        = def. cantidadDeSumaCero.2
        unoSiSumaCeroCeroSino e1 e2 + cantidadDeSumaCero e1 + cantidadDeSumaCero e2
        = def. unoSiSumaCeroCeroSino.
        0 + cantidadDeSumaCero e1 + cantidadDeSumaCero e2
        = neutro suma
        cantidadDeSumaCero e1 + cantidadDeSumaCero e2
        
        LD:
        cantidadDeSumaCero e1 + cantidadDeSumaCero e2

        Se cumple la propiedad.

        EJ 2)

        b.
        Prop.: ¿evalExpA . es2ExpA = evalES?
        Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
        ¿para todo x :: ExpS. evalExpA . es2ExpA x = evalES x?

        Sea e :: Exps
        Por ppio. de inducción en la estructura de NBin:
        ¿evalExpA . es2ExpA e = evalES e?

        Caso base: e = CteS n)
            ¿evalExpA . es2ExpA (CteS n) = evalES (CteS n)?

        Caso inductivo 1: n = (SumS ex1 ex2) )
            HI 1) ¿evalExpA . es2ExpA ex1 = evalES ex1!
            HI 2) ¿evalExpA . es2ExpA ex2 = evalES ex2!
            TI) ¿evalExpA . es2ExpA (SumS ex1 ex2) = evalES (SumS ex1 ex2)?

        Caso inductivo 2: n = (ProdS ex1 ex2) )
            HI 1) ¿evalExpA . es2ExpA ex1 = evalES ex1!
            HI 2) ¿evalExpA . es2ExpA ex2 = evalES ex2!
            TI) ¿evalExpA . es2ExpA (ProdS ex1 ex2) = evalES (ProdS ex1 ex2)?

        Dem. caso bsae:
            LI:
            evalExpA . es2ExpA (CteS n)
            = def. op. .
            evalExpA (es2ExpA (CteS n))
            = def. es2ExpA.1
            evalExpA (Cte evalN n)
            = def. evalExpA.1
            evalN n
            

            LD:
            evalES (CteS n)
            = def. evalES
            evalN n

            Se llega al mismo resultado, se cumple la propiedad.

        Dem. caso inductivo 1:
            LI:
            evalExpA . es2ExpA (SumS ex1 ex2)
            = def. op. .
            evalExpA (es2ExpA (SumS ex1 ex2))
            = def. es2ExpA.2
            evalExpA (Suma (es2ExpA exp1) (es2ExpA exp2))
            = def. evalExpA.2
            evalExpA (es2ExpA exp1) + evalExpA (es2ExpA exp2)
            = def. op. .
            evalExpA . es2ExpA exp1 + evalExpA . es2ExpA exp2
            = HI
            evalES ex1 + evalES ex2

            LD:
            evalES (SumS ex1 ex2)
            = def. evalES.2
            evalES exp1 + evalES ex2


         Dem. caso inductivo 2:
            LI:
            evalExpA . es2ExpA (ProdS ex1 ex2)
            = def. op. .
            evalExpA (es2ExpA (ProdS ex1 ex2))
            = def. es2ExpA.3
            evalExpA (Prod (es2ExpA exp1) (es2ExpA exp2))
            = def. evalExpA.3
            evalExpA (es2ExpA exp1) * evalExpA (es2ExpA exp2)
            = def. op. .
            evalExpA . es2ExpA exp1 * evalExpA . es2ExpA exp2
            = HI 1 y HI 2
            evalES ex1 * evalES ex2

            LD:
            evalES (ProdS ex1 ex2)
            = def. evalES.2
            evalES exp1 * evalES ex2


        ii.
            Prop.: ¿evalES . expA2es = evalExpA?
            Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
            ¿para todo x :: ExpA. evalES . expA2es x = evalExpA x?

            Sea e :: ExpA
            Por ppio. de inducción en la estructura de NBin:
            ¿evalES . expA2es e = evalExpA e?

            Caso base: e = Cte n)
                ¿evalES . expA2es (Cte n) = evalExpA (Cte n)?

            Caso inductivo 1: n = (Suma ex1 ex2) )
                HI 1) evalES . expA2es ex1 = evalExpA ex1?
                HI 2) evalES . expA2es ex2 = evalExpA ex2?
                TI) ¿evalES . expA2es (Suma ex1 ex2) = evalExpA (Suma ex1 ex2)?

              Caso inductivo 2: n = (Prod ex1 ex2) )
                HI 1) evalES . expA2es ex1 = evalExpA ex1?
                HI 2) evalES . expA2es ex2 = evalExpA ex2?
                TI) ¿evalES . expA2es (Prod ex1 ex2) = evalExpA (Prod ex1 ex2)?

            Dem. caso base:
            LI:
            evalES . expA2es (Cte n)
            = def. op. .
            evalES (expA2es (Cte n))
            = def. expA2es.1
            evalES (CteS int2N n)
            = def. evalES.1
            evalN (int2N n)
            = def. op .
            evalN . int2N n
            = S) Seccion II, ej 2, b) iv.
            id n
            = def. id
            n

            LD:
            evalExpA (Cte n)
            = def. evalExpA.1
            n

            Se llega al mismo resultado en ambas partes. Se cumple para este caso

            Caso inductivo 1:
            LI:
            evalES . expA2es (Suma ex1 ex2)
            = def. op. .
            evalES (expA2es (Suma ex1 ex2))
            = def. expA2es.2
            evalES (SumS expA2es ex1 expA2es ex2)
            = def. evalES.2
            evalES (expA2es ex1) + evalES (expA2es ex2)
            = def. op. .
            evalES . expA2es ex1 + evalES . expA2es ex2
            = HI 1 y HI 2
            evalExpA ex2 + evalExpA ex2

            LD:
            evalExpA (Suma ex1 ex2)
            =
            evalExpA ex1 + evalExpA ex2    

            Ambas llegan al mismo resultado. Se cumple la propiedad


            Caso inductivo 2:

            LI:
            evalES . expA2es (Prod ex1 ex2)
            = def. op. .
            evalES (expA2es (Prod ex1 ex2))
            = def. expA2es.3
            evalES (ProdS expA2es ex1 expA2es ex2)
            = def. evalES.3
            evalES (expA2es ex1) * evalES (expA2es ex2)
            = def. op. .
            evalES . expA2es ex1 * evalES . expA2es ex2
            = HI 1 y HI 2
            evalExpA ex1 * evalExpA ex2

            
            LD:
            evalExpA (Prod ex1 ex2)
            = def. evalExpA.3
            evalExpA ex1 * evalExpA ex2

            Se cumplen todos los casos. Se cumple la propiedad


        iii.
            Prop.: ¿es2ExpA . expA2es = id?
            Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
            ¿para todo x :: ExpA. es2ExpA . expA2es x = id x?

            Sea e :: ExpA
            Por ppio. de inducción en la estructura de NBin:
            ¿es2ExpA . expA2es = id?

            Caso base: e = Cte n)
                ¿es2ExpA . expA2es (Cte n) = id (Cte n)?

            Caso inductivo 1: n = (Suma ex1 ex2) )
                HI 1) ¡es2ExpA . expA2es ex1 = id ex1!
                HI 2) ¡es2ExpA . expA2es ex2 = id ex2!
                TI) ¿es2ExpA . expA2es (Suma ex1 ex2) = id (Suma ex1 ex2)?

              Caso inductivo 2: n = (Prod ex1 ex2) )
                HI 1) ¡es2ExpA . expA2es ex1 = id ex1!
                HI 2) ¡es2ExpA . expA2es ex2 = id ex2!
                TI) ¿es2ExpA . expA2es (Prod ex1 ex2) = id (Prod ex1 ex2)?

            Dem. caso base:

            LI:
            es2ExpA . expA2es (Cte n)
            = def. op. .
            es2ExpA (expA2es (Cte n))
            = def. expA2es
            es2ExpA (CteS int2N n)
            = def. es2ExpA.1
            (Cte evalN (int2N n))
            = def. op. .
            Cte evalN . int2N n
            = Seccion 2. Ej 1. b. iv.
            Cte id n
            = def. id
            Cte n

            LD:
            id (Cte n)
            = def. id
            Cte n

            Se llega al mismo valor en ambas partes. Se cumple
            la propiedad para este caso.

            Caso inductivo 1: 

            LI:
            es2ExpA . expA2es (Suma ex1 ex2)
            = def. op. .
            es2ExpA (expA2es (Suma ex1 ex2))
            = def. expA2es. 2
            es2ExpA (Sums expA2es ex1 expA2es ex2)
            = def. es2ExpA
            Suma es2ExpA (expA2es ex1) es2ExpA (expA2es ex2)
            = def. op. .
            Suma (es2ExpA . expA2es ex1) (es2ExpA . expA2es ex2)
            = HI 1 y HI 2
            Suma (id ex1) (id ex2)
            = def. id
            Suma ex1 ex2

            LD:

            id (Suma ex1 ex2)
            = def. id
            Suma ex1 ex2

            Caso inductivo 2: 

            LI:
            es2ExpA . expA2es (Prod ex1 ex2)
            = def. op. .
            es2ExpA (expA2es (Prod ex1 ex2))
            = def. expA2es. 3
            es2ExpA (ProdS expA2es ex1 expA2es ex2)
            = def. es2ExpA
            Prod es2ExpA (expA2es ex1) es2ExpA (expA2es ex2)
            = def. op. .
            Prod (es2ExpA . expA2es ex1) (es2ExpA . expA2es ex2)
            = HI 1 y HI 2
            Prod (id ex1) (id ex2)
            = def. id
            Prod ex1 ex2

            LD:

            id (Prod ex1 ex2)
            = def. id
            Prod ex1 ex2

            Se cumple para todos los casos. Se cumple la propiedad.

            Prop.: ¿expA2es . es2ExpA = id?
            Dem.: Según ppio. de extensionalidad, es equivalente demostrar que:
            ¿para todo x :: ExpS. expA2es . es2ExpA x = id x?

            Sea e :: ExpS
            Por ppio. de inducción en la estructura de NBin:
            ¿expA2es . es2ExpA e = id e?

            Caso base: e = CteS n)
                ¿expA2es . es2ExpA (CteS n) = id (CteS n)?

            Caso inductivo 1: n = (SumS ex1 ex2) )
                HI 1) ¡expA2es . es2ExpA ex1 = id ex1!
                HI 2) ¡expA2es . es2ExpA ex2 = id ex2!
                TI) ¿expA2es . es2ExpA (SumS ex1 ex2) = id (SumS ex1 ex2)?

             Caso inductivo 2: n = (ProdS ex1 ex2) )
                HI 1) ¡expA2es . es2ExpA ex1 = id ex1!
                HI 2) ¡expA2es . es2ExpA ex2 = id ex2!
                TI) ¿expA2es . es2ExpA (ProdS ex1 ex2) = id (ProdS ex1 ex2)?

            Dem. caso base:

            LI:
            expA2es . es2ExpA (CteS n)
            = def. op. .
            expA2es (es2ExpA (CteS n))
            = def. expA2es.1
            expA2es (Cte evalN n)
            = expA2es.1
            CteS int2N (evalN n)
            = def. op. .
            CteS int2N . evalN n
            = Seccion 2, ej2. b. iii.
            CteS (id n)
            = def. op. .
            CteS n

            LD:
            id (CteS n)
            = def.op. .
            CteS n

            Se llega al mismo resultado en ambas partes. Se cumple la propiedad

            Dem. caso inductivo 1:

            LI:
            expA2es . es2ExpA (SumS ex1 ex2)
            = def. op. .
            expA2es (es2ExpA (SumS ex1 ex2))
            = def. es2ExpA.2
            expA2es (Suma es2ExpA ex1 es2ExpA ex2)
            = def. expA2es.2
            SumS (expA2es (es2ExpA ex1)) (es2ExpA (es2ExpA ex2))
            = def. op. .
            SumS (expA2es . es2ExpA ex1) (es2ExpA . es2ExpA ex2)
            = HI 1 y HI 2
            SumS (id ex1) (id ex2)
            = def. id 
            SumS ex1 ex2

            LD:
            id (SumS ex1 ex2)
            = def. id
            SumS ex1 ex2

            Se cumple para este caso.

            Dem. caso inductivo 2:

            LI:
            expA2es . es2ExpA (ProdS ex1 ex2)
            = def. op. .
            expA2es (es2ExpA (ProdS ex1 ex2))
            = def. es2ExpA.3
            expA2es (Prod es2ExpA ex1 es2ExpA ex2)
            = def. expA2es.3
            ProdS (expA2es (es2ExpA ex1)) (es2ExpA (es2ExpA ex2))
            = def. op. .
            ProdS (expA2es . es2ExpA ex1) (es2ExpA . es2ExpA ex2)
            = HI 1 y HI 2
            ProdS (id ex1) (id ex2)
            = def. id 
            ProdS ex1 ex2

            LD:
            id (ProdS ex1 ex2)
            = def. id
            ProdS ex1 ex2

            Se cumple para todos los casos. Por lo tanto, se cumple la propiedad.



