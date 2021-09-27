unlines' :: [String] -> String
unlines' [x] = x
unlines' (h:t) = h ++ "\n" ++ unlines' t


delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' x (h:t) | x == h = t 
                | otherwise = h:delete' x t

remove' :: (Eq a) => [a] -> [a] -> [a]
remove' [] [] = []
remove' [] l  = []
remove' l [] = l
remove' l (y:ys) = remove' (delete' y l) ys

data Seq a = Nil | Inicio a (Seq a) | Fim (Seq a) a deriving Show

primeiro :: Seq a -> a
primeiro (Inicio x Nil) = x
primeiro (Inicio x seq) = primeiro seq
primeiro (Fim seq x) = primeiro seq 

semUltimo :: Seq a -> Seq a
semUltimo (Inicio x Nil) = Nil
semUltimo (Inicio x seq) = Inicio x (semUltimo seq)
semUltimo (Fim seq x) = seq


data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

prune ::  Int -> BTree a -> BTree a
prune _ Empty = Empty
prune n (Node r e d) | n> 0 = Node r (prune (n-1) e) (prune (n-1) d)
                     | otherwise = Empty 

semMinimo :: (Ord a) => BTree a -> BTree a
semMinimo (Node r Empty d) = d
semMinimo (Node r e d) = Node r (semMinimo e) d 

type Tabuleiro = [String]



 


