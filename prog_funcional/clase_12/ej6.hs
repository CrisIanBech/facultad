data Dir = Left_ | Right_ | Straight
            deriving (Show)
data Mapa a = Cofre [a]
                | Nada (Mapa a)
                | Bifurcacion [a] (Mapa a) (Mapa a)
                    deriving (Show)

mapaTest = Nada (Nada (Bifurcacion [1, 2, 3] 
                            (Nada 
                                (Cofre [4, 5, 6, 7])
                            )
                            (Nada
                                (Nada 
                                    (Cofre [8, 9, 10])
                                )
                            )
                      )
                )

foldM :: ([a] -> b)
            -> (b -> b)
            -> ([a] -> b -> b -> b)
            -> Mapa a
            -> b
foldM fc fn fb (Cofre is)               = fc is
foldM fc fn fb (Nada m)                 = fn (foldM fc fn fb m)
foldM fc fn fb (Bifurcacion is ml mr)   = fb is (foldM fc fn fb ml) (foldM fc fn fb mr)

recM :: ([a] -> b)
            -> (b -> Mapa a -> b)
            -> ([a] -> b -> b -> Mapa a -> Mapa a -> b)
            -> Mapa a
            -> b
recM fc fn fb (Cofre is)                = fc is
recM fc fn fb (Nada m)                  = fn (recM fc fn fb m) m
recM fc fn fb (Bifurcacion is ml mr)    = fb is (recM fc fn fb ml) (recM fc fn fb mr) ml mr

objects :: Mapa a -> [a]
objects = foldM fc fn fb
            where   fc is           = is

                    fn is           = is

                    fb is isl isr   = is ++ isl ++ isr


mapM :: (a -> b) -> Mapa a -> Mapa b
mapM = flip (foldM fc fn fb)
            where   fc is t         = Cofre (map t is)

                    fn m t          = Nada (m t)

                    fb is isl isr t = Bifurcacion (map t is) (isl t) (isr t)

has :: (a -> Bool) -> Mapa a -> Bool
has = flip (foldM fc fn fb)
            where   fc is p         = any p is
                    fn m p          = m p
                    fb is isl isr p = (any p is) || isl p || isr p

hasObjectAt :: (a->Bool) -> Mapa a -> [Dir] -> Bool
hasObjectAt = flip (foldM fc fn fb)
                    where   fc is p []      = any p is
                            fc is p (d:ds)  = False

                            fn m p []               = False
                            fn m p (Straight:ds)    = m p ds
                            fn m p _                = False

                            fb is hl hr p []          = any p is
                            fb is hl hr p (Left_:ds)  = hl p ds
                            fb is hl hr p (Right_:ds) = hr p ds
                            fb _  _  _  _ _           = False

longestPath :: Mapa a -> [Dir]
longestPath = foldM fc fn fb
                where   fc _         = []
                        
                        fn ds        = Straight:ds

                        fb _ dsl dsr = if(length dsl > length dsr) then Left_ : dsl else Right_ : dsr 

objectsOfLongestPath :: Mapa a -> [a]
objectsOfLongestPath = recM fc fn fb
                            where   fc is               = is
                            
                                    fn is _             = is 

                                    fb is isl isr ml mr = is ++ if(hasLongerPath ml mr)
                                                                    then isl
                                                                    else isr

hasLongerPath :: Mapa a -> Mapa b -> Bool
hasLongerPath ml mr = length (longestPath ml) > length (longestPath mr)

allPaths :: Mapa a -> [[Dir]]
allPaths = foldM fc fn fb
                where fc _           = [[]]
                    
                      fn dss         = map (Straight :) dss

                      fb _ dssl dssr = (map (Left_ :) dssl) ++ (map (Right_ :) dssr)

