f x = let (y,z) = (x,x) in y
ff (x,y) = let z = x + y in g (z,y) where g (a,b) = a - b
fff p = case p of (x,y) -> x
ffff = \p -> let (x,y) = p in y