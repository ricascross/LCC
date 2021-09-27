

data ExpInt = Const Int
            | Simetrico ExpInt
            | Mais ExpInt ExpInt
            | Menos ExpInt ExpInt
            | Mult ExpInt ExpInt
            deriving Show


calcula :: ExpInt -> Int
calcula (Const x) = x
calcula (Simetrico x) = - (calcula x)
calcula (Mais a b) = (calcula a) + (calcula b)
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b) 

infixa :: ExpInt -> String
infixa (Const x) = show x
infixa (Simetrico x) = "("++"-"++(infixa x)++")"
infixa (Mais a b) = "("++(infixa a)++ "+" ++(infixa b)++")"
infixa (Menos a b) = "("++(infixa a)++ "-" ++(infixa b)++")"
infixa (Mult a b) = "("++(infixa a)++ "*" ++(infixa b)++")"

posfixa :: ExpInt -> String
posfixa (Const x) = show x
posfixa (Simetrico x) = (posfixa x)++"-"
posfixa (Mais a b) = (posfixa a) ++ (posfixa b)++"+"
posfixa (Menos a b) = (posfixa a)++(posfixa b)++"-"
posfixa (Mult a b) =(posfixa a) ++(posfixa b)++"*"

--2)
data RTree a = R a [RTree a] deriving Show

rose = R 1 [R 2 [R 4 []],R 3 [R 5 [],R 6 [],R 7 []]]

soma :: Num a => RTree a -> a  
soma (R x []) = x
soma (R x l) = x + sum (map soma l)

altura :: RTree a -> Int 
altura (R x []) = 1
altura (R x l) = 1 + maximum(map altura l)

prune :: Int -> RTree a -> RTree a
prune 1 (R x l) = R x []
prune n (R x l) | n>1 =  R x (map (prune (n-1)) l)

mirror :: RTree a -> RTree a 
mirror (R x []) = R x []
mirror (R x l) = R x (reverse (map mirror l))

postorder :: RTree a -> [a]
postorder (R x []) = [x]
postorder (R x l) = concat (map postorder l) ++ [x]

--3)
data LTree a = Tip a | Fork (LTree a) (LTree a)

tree = Fork (Fork (Fork (Tip 3) (Tip 4))  (Tip 6)) (Fork (Tip 2) (Tip 3))

ltSum :: Num a => LTree a -> a
ltSum (Tip x) = x
ltSum (Fork e d) = (ltSum e) + (ltSum d)

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork e d) = (listaLT e)++(listaLT d)

ltHeight :: LTree a -> Int
ltHeight (Tip x) = 1
ltHeight (Fork e d) = (max(ltHeight e) (ltHeight d)) +1

