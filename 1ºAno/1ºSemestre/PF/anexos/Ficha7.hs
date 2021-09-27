data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt

calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) = (calcula x)
calcula (Mais a b) = (calcula a) + (calcula b)
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b)

infixa :: ExpInt -> String
infixa (Const x) = (show x)
infixa (Simetrico x) = "-"++(infixa x)
infixa (Mais a b) = "("++(infixa a)++" "++"+"++ " "++(infixa b)++")"
infixa (Menos a b) = "("++(infixa a)++ " "++"-"++ " "++(infixa b)++")"
infixa (Mult a b) = "("++(infixa a)++" "++ "*"++ " "++ (infixa b)++")"
 
posfixa :: ExpInt -> String
posfixa (Const x) = (show x)
posfixa (Simetrico x) = "-"++(posfixa x)
posfixa (Mais a b) = (posfixa a) ++ " "++ (posfixa b) ++ " "++ "+"
posfixa (Menos a b) = (posfixa a) ++ " "++ (posfixa b) ++ " "++ "-"
posfixa (Mult a b) = (posfixa a) ++ " "++ (posfixa b) ++ " "++ "*"


--pergunta2
data RTree a = R a [RTree a] deriving Show

soma :: Num a => RTree a -> a
soma (R x []) = x 
soma (R x l) = x + sum (map soma l)

altura :: RTree a -> Int 
altura (R x []) = 1
altura (R x l) = 1 + maximum(map altura l)

prune :: Int -> RTree a -> RTree a 
prune 1 (R x l) = R x []
prune n (R x l) = R x (map (prune (n-1)) l)

mirror :: RTree a -> RTree a 
mirror (R x l) = R x (map mirror (reverse l))

postorder :: RTree a -> [a]
postorder (R e []) = [e]
postorder (R e es) = concatMap postorder es ++ [e]

--pergunta3
data LTree a = Tip a | Fork (LTree a) (LTree a) deriving Show

ltSum :: Num a => LTree a -> a
ltSum (Tip a) = a
ltSum (Fork x y) = (ltSum x) + (ltSum y)

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork x y) = (listaLT x) ++ (listaLT y)

ltHeights :: LTree a -> Int
ltHeights (Tip x) = 1
ltHeights (Fork e d) = (max(ltHeights e) (ltHeights d)) +1

--pergunta4
data FTree a b = Leaf b | No a (FTree a b) (FTree a b) deriving Show
data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show 

ftree1 = No 8 (No 1 (Leaf 5) (No 2 (Leaf 6) (Leaf 4))) (No 9 (No 10 (Leaf 3) (Leaf 7)) (Leaf 5))

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree (Leaf n) = (Empty, Tip n)
splitFTree (No a b c) = (Node a (fst (splitFTree b)) (fst (splitFTree c)), Fork (snd (splitFTree b)) (snd (splitFTree c)))

joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees (Empty) (Tip n) = Just (Leaf n)
joinTrees (Node e l r) (Fork a b) = Just (No e aux aux2)
                                  where Just aux = joinTrees l a
                                        Just aux2 = joinTrees r b
joinTrees _ _ = Nothing