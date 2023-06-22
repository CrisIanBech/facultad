type Record a b = [(a,b)]

type Table a b = [ Record a b ]

select :: (Record a b -> Bool) -> Table a b -> Table a b
select = flip (foldr fr (const []))
            where fr r h p = if(p r) then r : (h p) else h p

project :: (a -> Bool) -> Table a b -> Table a b
project = flip (foldr fr (const []))
                where fr r h p = case (recordsWhich p r) of
                                    []      -> h p
                                    r       -> r : (h p)

recordsWhich :: (a -> Bool) -> Record a b -> Record a b
recordsWhich = flip (foldr fc (const []))
                    where fc c h p = if(p (fst c)) then c : (h p) else h p

conjunct :: (a -> Bool) -> (a -> Bool) -> a -> Bool
conjunct p q e = p e && q e

crossWith :: (a -> b -> c) -> [a] -> [b] -> [c]
crossWith = flip (foldr fl (\_ _ -> []))
                where fl x h p ys = (map (p x) ys) ++ (h p ys)

-- product :: Table a b -> Table a b -> Table a b

similar :: (Eq a, Eq b) => Record a b -> Record a b
similar = foldr fc []
            where fc c cs = if(elem c cs) then cs else c : cs