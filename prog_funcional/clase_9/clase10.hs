data Binfile = Line NBin Binfile 
                | Eline Binfile
                | End

data Change = Add Int (Maybe Nbin)
                | Remove Int
                | Replace Int (Maybe NBin)
                | Duplicate Int
                | Repeat Int Int (Maybe NBin)

connectNBin :: NBin -> NBin -> NBin

construct :: [Change] -> Binfile
construct [] = End
construct (c:cs) = evalChange c (construct cs)

evalChange :: Change -> Binfile -> Binfile
evalChange (Add n nbin)         bf = addInLine n nbin bf
evalChange (Remove n)           bf = removeLine n bf
evalChange (Replace n nbin)     bf = replaceLine n nbin bf  
evalChange (Duplicate n)        bf = duplicateLine n bf
evalChange (Repeat n1 n2 nbin)  bf = repeatLine n1 n2 nbin bf

addInLine :: Int -> (Maybe NBin) -> Binfile -> Binfile
addInLine line nbin bf = case nbin of
                            Nothing -> bf
                            Just n -> addInLine' line n bf

addInLine' :: Int -> NBin -> Binfile -> Binfile
addInLine' 0 nb (Line nbin bf)   = (Line (connectNBin nbin nb) bf)
addInLine' 0 nb (ELine bf)       = (Line nb bf)
addInLine' 0 nb (End)            = (Line nb End)
addInLine' n nb (Line nbin bf)   = (Line nbin (addInLine' n-1 nb bf))
addInLine' n nb (ELine bf)       = (ELine (addInLine' n-1 nb bf))
addInLine' n nb (End)            = (ELine (addInLine' n-1 nb End)) 

removeLine :: Int -> Binfile -> Binfile
removeLine 0 (Line nbin bf)   = bf
removeLine 0 (ELine bf)       = bf
removeLine 0 (End)            = End
removeLine n (Line nbin bf)   = (Line nbin (removeLine n-1 bf))
removeLine n (ELine bf)       = Eline (removeLine n-1 bf)
removeLine n (End)            = Eline (removeLine n-1 End)

replaceLine :: Int -> (Maybe NBin) -> Binfile -> Binfile
replaceLine n nbin bf = case nbin of
                            Nothing -> bf
                            Just nb -> replaceLine' n nb bf

replaceLine' :: Int -> NBin -> Binfile -> Binfile
replaceLine' 0 nb (Line nbin bf)   = Line nb bf
replaceLine' 0 nb (ELine bf)       = Line nb bf
replaceLine' 0 nb (End)            = Line nb bf
replaceLine' n nb (Line nbin bf)   = (Line nbin (replaceLine' n-1 nb bf))
replaceLine' n nb (ELine bf)       = Eline (replaceLine' n-1 nb bf)
replaceLine' n nb (End)            = Eline (replaceLine' n-1 nb End)

duplicateLine :: Int -> Binfile -> Binfile
duplicateLine 0 (Line nbin bf)   = Line nbin (Line nbin bf)
duplicateLine 0 (ELine bf)       = Eline (Eline bf)
duplicateLine 0 (End)            = Eline End
duplicateLine n (Line nbin bf)   = (Line nbin (duplicateLine n-1 bf))
duplicateLine n (ELine bf)       = Eline (duplicateLine n-1 bf)
duplicateLine n (End)            = Eline (duplicateLine n-1 End)

repeatLine :: Int -> Int -> (Maybe NBin) -> Binfile -> Binfile
repeatLine line quantity nbin bf = case nbin of
                                        Nothing -> bf
                                        Just nb -> repeatLine line quantity nbin bf

repeatLine :: Int -> Int -> NBin -> Binfile -> Binfile
duplicateLine 0 (Line nbin bf)   = Line nbin (Line nbin bf)
duplicateLine 0 (ELine bf)       = Eline (Eline bf)
duplicateLine 0 (End)            = Eline End
duplicateLine n (Line nbin bf)   = (Line nbin (duplicateLine n-1 bf))
duplicateLine n (ELine bf)       = Eline (duplicateLine n-1 bf)
duplicateLine n (End)            = Eline (duplicateLine n-1 End)


