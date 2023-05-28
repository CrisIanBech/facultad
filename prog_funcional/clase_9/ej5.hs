data QuadTree a = LeafQ a
    | NodeQ (QuadTree a) (QuadTree a) (QuadTree a) (QuadTree a)

data Color = RGB Int Int Int

type Image = QuadTree Color

heightQT :: QuadTree a -> Int
heightQT (LeafQ e) = 1
heightQT (NodeQ qt1 qt2 qt3 qt4) = 1 + max (heightQT qt1) (max (heightQT qt2) (max (heightQT qt3) (heightQT qt4)))

countLeavesQT :: QuadTree a -> Int
countLeavesQT (LeafQ e) = 1 
countLeavesQT (NodeQ qt1 qt2 qt3 qt4) = countLeavesQT qt1 + countLeavesQT qt2 + countLeavesQT qt3 + countLeavesQT qt4

sizeQT :: QuadTree a -> Int
sizeQT (LeafQ e) = 1
sizeQT (NodeQ qt1 qt2 qt3 qt4) = 1 + sizeQT qt1 + sizeQT qt2 + sizeQT qt3 + sizeQT qt4

compress :: QuadTree a -> QuadTree a
compress (LeafQ e) = LeafQ e
compress (NodeQ qt1 qt2 qt3 qt4) compress' (compress qt1) (compress qt2) (compress qt3) (compress qt4)

compress' :: QuadTree a -> QuadTree a -> QuadTree a -> QuadTree a -> QuadTree a
compress' (LeafQ e1) (LeafQ e2) (LeafQ e3) (LeafQ e4) = juntarHojaSiIguales e1 e2 e3 e4
compress' qt1 qt2 qt3 qt4 = NodeQ qt1 qt2 qt3 qt4

juntarHojaSiIguales :: a -> a -> a -> a -> QuadTree a
juntarHojaSiIguales e1 e2 e3 e4 = if(e1 == e2 and e2 == e3 and e3 == e4)
                                                            then LeafQ e1
                                                            else NodeQ (LeafQ e1) (LeafQ e2)
                                                                        (LeafQ e3) (LeafQ e4)

uncompress :: QuadTree a -> QuadTree a
uncompress qt = uncompress' (heightQT qt) qt

uncompress' :: Int -> QuadTree a -> QuadTree a
uncompress' 1 qt = qt
uncompress' n (LeafQ e) = uncompress' n - 1 (elementToNodeQ e)
uncompress' n (NodeQ qt1 qt2 qt3 qt4) = let nextN = n - 1
                                            in NodeQ (uncompress' nextN qt1)
                                                     (uncompress' nextN qt2)
                                                     (uncompress' nextN qt3)
                                                     (uncompress' nextN qt4)

elementToNodeQ :: a -> QuadTree a
elementToNodeQ e = NodeQ (LeafQ e) (LeafQ e) (LeafQ e) (LeafQ e)

render :: Image -> Int -> Image
render qtC 0 = qtC
render (LeafQ e) n = render (elementToNodeQ e) n - 4
render (NodeQ qtC1 qtC2 qtC3 qtC4) n = let nextN = n - 4
                                        in NodeQ (render qtC1 nextN)
                                                 (render qtC2 nextN)
                                                 (render qtC3 nextN)
                                                 (render qtC4 nextN)