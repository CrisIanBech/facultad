data MSExp a = EmptyMS
			 | AddMS a (MSExp a)
			 | UnionMS (MSExp a) (MSExp a)
			 | RemoveMS a (MSExp a)
			 | MapMS (a -> a) (MSExp a)


-- f EmptyMS =
-- f (AddMS x exp) = f exp
-- f (UnionMS exp1 exp2) = f exp1 ... f exp2
-- f (RemoveMS x exp) = f exp
-- f (MapMS g exp) = f exp

foldMS :: b
       -> (a -> b -> b)
       -> (b -> b -> b)
       -> (a -> b -> b)
       -> ((a -> a) -> b -> b)
       -> MSExp a
       -> b
foldMS ze fa fu fr fm EmptyMS = ze
foldMS ze fa fu fr fm (AddMS x exp) = 
	fa x (foldMS ze fa fu fr fm exp)
foldMS ze fa fu fr fm (UnionMS exp1 exp2) =
	fu (foldMS ze fa fu fr fm exp1)
	   (foldMS ze fa fu fr fm exp2)
foldMS ze fa fu fr fm (RemoveMS x exp) =
	fr x (foldMS ze fa fu fr fm exp)
foldMS ze fa fu fr fm (MapMS g exp) =
	fm g (foldMS ze fa fu fr fm exp)

recMS :: b
       -> (a -> MSExp a -> b -> b)
       -> (MSExp a -> MSExp a -> b -> b -> b)
       -> (a -> MSExp a -> b -> b)
       -> ((a -> a) -> MSExp a -> b -> b)
       -> MSExp a
       -> b
recMS ze fa fu fr fm EmptyMS = ze
recMS ze fa fu fr fm (AddMS x exp) = 
	fa x exp (recMS ze fa fu fr fm exp)
recMS ze fa fu fr fm (UnionMS exp1 exp2) =
	fu exp1 exp2 (recMS ze fa fu fr fm exp1)
	             (recMS ze fa fu fr fm exp2)
recMS ze fa fu fr fm (RemoveMS x exp) =
	fr x exp (recMS ze fa fu fr fm exp)
recMS ze fa fu fr fm (MapMS g exp) =
	fm g exp (recMS ze fa fu fr fm exp)

occursMSE :: Eq a => a -> MSExp a -> Int
occursMSE e exp = occursMESWith e id exp

occursMESWith :: Eq a => a -> (a -> a) -> MSExp a -> Int
occursMESWith e f EmptyMS = 0
occursMESWith e f (AddMS x exp) =
	if e == f x
	   then 1 + occursMESWith e f exp
	   else occursMESWith e f exp
occursMESWith e f (UnionMS exp1 exp2) = 
	occursMESWith e f exp1 + occursMESWith e f exp2
occursMESWith e f (RemoveMS x exp) =
	if e == f x && occursMESWith e f exp > 0
	   then 1 - occursMESWith e f exp
	   else occursMESWith e f exp
occursMESWith e f (MapMS g exp) = 
	occursMESWith e (f . g) exp

occursMESWith' e f exp = foldMS ze ga gu gr gm exp f
	where ze f = 0
	      ga x r f   = if e == f x
	                    then 1 + r f
	                    else r f
	      gr x r f   = if e == f x && r f > 0
	                    then 1 - r f
	                    else r f
	      gu r1 r2 f = r1 f + r2 f
	      gm g r f   = r (f . g)

-- ejemplo con MapMS
-- occursMESWith 2 id (MapMS (+1) (Add 1 EmptyMS))
-- -> -- occursMESWith
-- occursMESWith 2 (id . (+1)) (Add 1 EmptyMS)
-- -> -- occursMESWith
-- if 2 == (id . (+1)) 1
--    then 1 + occursMESWith 2 (id . (+1)) exp
--    else occursMESWith 2 (id . (+1)) exp

filterMSE :: (a -> Bool) -> MSExp a -> MSExp a
filterMSE p EmptyMS = EmptyMS
filterMSE p (AddMS x exp) =
	if p x
	   then AddMS x (filterMSE p exp)
	   else filterMSE p exp
filterMSE p (UnionMS exp1 exp2) =
	UnionMS (filterMSE p exp1) (filterMSE p exp2)
filterMSE p (RemoveMS x exp) =
	if p x
	   then RemoveMS x (filterMSE p exp)
	   else filterMSE p exp
filterMSE p (MapMS g exp) =
	MapMS g (filterMSE (p . g) exp)

filterMSE' p exp = foldMS ze ga gu gr gm exp p
	where ze p = EmptyMS
	      ga x r  p = if p x
	                    then AddMS x (r p)
	                    else r p
	      gr x r  p = if p x
	                    then RemoveMS x (r p)
	                    else r p
	      gu r1 r2 p = UnionMS (r1 p) (r2 p)
	      gm g r   p = MapMS g (r (p . g))

-- ejemplo con MapMS
-- filterMSE (>1) (MapMS (+1) (Add 1 EmptyMS))
-- -> -- filterMSE
-- filterMSE ((>1) . (+1)) (Add 1 EmptyMS)
-- -> -- filterMSE
-- if ((>1) . (+1)) 1
--    then Add 1 (filterMSE ((>1) . (+1)) exp)
--    else filterMSE ((>1) . (+1)) exp

isValidMSE :: Eq a => MSExp a -> Bool
isValidMSE EmptyMS = True
isValidMSE (AddMS x exp) = isValidMSE exp
isValidMSE (UnionMS exp1 exp2) =
	isValidMSE exp1 && isValidMSE exp2
isValidMSE (RemoveMS x exp) =
	occursMSE x exp > 0 && isValidMSE exp
isValidMSE (MapMS g exp) = isValidMSE exp


isValidMSE' exp = recMS ze ga gu gr gm exp 
	where ze             = True
	      ga x e r       = r
	      gr x e r       = occursMSE x e > 0 && r
	      gu e1 e2 r1 r2 = r1 && r2
	      gm g e r       = r

evalMSE :: Eq a => MSExp a -> [a]
evalMSE EmptyMS = []
evalMSE (AddMS x exp) = x : evalMSE exp
evalMSE (UnionMS exp1 exp2) =
	evalMSE exp1 ++ evalMSE exp2
evalMSE (RemoveMS x exp) =
	remove x (evalMSE exp)
evalMSE (MapMS g exp) = 
	map g (evalMSE exp)

evalMSE' :: Eq a => MSExp a -> [a]
evalMSE' = foldMS ze ga gu gr gm
	where ze       = []
	      ga x r   = x : r
	      gr x r   = remove x r
	      gu r1 r2 = r1 ++ r2
	      gm g r   = map g r

-- evalMS (RemoveMS 1 (AddMS 1 EmptyMS))
-- evalMS (RemoveMS 1 ([1]))
-- remove 1 [1]

recr = undefined

remove e = recr (\x xs r -> if e == x then xs else x : r) []

simpMSE :: Eq a => MSExp a -> MSExp a
simpMSE EmptyMS = EmptyMS
simpMSE (AddMS x exp) = AddMS x (simpMSE exp)
simpMSE (UnionMS exp1 exp2) =
	simpUnionMS (simpMSE exp1) (simpMSE exp2)
simpMSE (RemoveMS x exp) =
	simpRemoveMS x (simpMSE exp)
simpMSE (MapMS g exp) =
	simpMapMS g (simpMSE exp)

simpMSE' :: Eq a => MSExp a -> MSExp a
simpMSE' = foldMS ze ga gu gr gm
	where ze       = EmptyMS
	      ga x r   = AddMS x r
	      gr x r   = simpRemoveMS x r
	      gu r1 r2 = simpUnionMS r1 r2
	      gm g r   = simpMapMS g r

simpUnionMS EmptyMS e2 = e2
simpUnionMS e1 EmptyMS = e1
simpUnionMS e1 e2      = UnionMS e1 e2

simpRemoveMS x (AddMS y e) =
	if x == y
	   then e
	   else RemoveMS x (AddMS y e)
simpRemoveMS x e = RemoveMS x e

simpMapMS g EmptyMS = EmptyMS
simpMapMS g e       = MapMS g e

-- evalMSE . simpMSE = evalMSE

