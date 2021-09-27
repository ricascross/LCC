import Data.Char
import Data.List
import System.Random

elemIndices :: Eq a => a -> [a] -> [Int]
elemIndices _ [] = []
elemIndices x l = elemAux 0 x l

elemAux :: Eq a => Int -> a -> [a] -> [Int]
elemAux _ _ [] = []
elemAux acc x (h:t) | x == h = acc:elemAux (acc+1) x t
                    | otherwise = elemAux (acc+1) x t 

--pergunta1 b
{-isSubsequenceOf :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf [] [] = True
isSubsequenceOf [] l = True
isSubsequenceOf l [] = False
isSubsequenceOf (h:t) (x:xs) | (x==h) = isSubsequenceOf t xs
                             | otherwise = isSubsequenceOf (h:t) xs-}

--pergunta2 
data Btree a = Empty | Node a (Btree a) (Btree a) deriving Show

arv1 = Node 10 (Node 5 (Node 4 Empty Empty) (Node 9 Empty Empty)) (Node 30 (Node 17 Empty Empty) Empty)
arv2 = Node 100 (Node 50 (Node 40 Empty Empty) (Node 90 Empty Empty)) (Node 300 (Node 170 Empty Empty) Empty)

lookupAP :: Ord a => a -> Btree (a,b) -> Maybe b 
lookupAP _ Empty = Nothing
lookupAP n (Node (x,y) e d) | (n == x) = Just y
                            | (n < x) = lookupAP n e 
                            | otherwise = lookupAP n d 

zipWithBT :: (a->b->c) -> Btree a -> Btree b -> Btree c
zipWithBT _ Empty Empty = Empty
zipWithBT f (Node r e d) (Node raiz esq dir) = Node (f r raiz) (zipWithBT f e esq) (zipWithBT f d dir) 

--pergunta3
digitAlpha :: String -> (String,String)
digitAlpha [] = ([],[])
digitAlpha l = digitAlphaAux l ([],[]) 

digitAlphaAux :: String -> (String, String) -> (String,String)
digitAlphaAux [] (l1,l2) = (l1,l2)
digitAlphaAux (h:t) (l1,l2) | isDigit h = digitAlphaAux t (l1++[h], l2)
                            | isAlpha h = digitAlphaAux t (l1, l2++[h])
                            | otherwise = digitAlphaAux t (l1,l2) 

--pergunta4
data Seq a = Nil | Cons a (Seq a) | App (Seq a) (Seq a)

sequencia = (App (App (Cons 7 (Cons 5 Nil)) (Cons 3 Nil)) (Cons 1 Nil))

firstSeq :: Seq a -> a 
firstSeq (Cons x seq) = x 
firstSeq (App seq1 seq2) = firstSeq seq1 



dropSeq :: Int -> Seq a -> Seq a
dropSeq _ Nil = Nil
dropSeq n (Cons x seq) = dropSeq (n-1) seq
dropSeq n (App seq1 seq2) | n > nx = dropSeq (n-nx) seq2
                          | n == nx = seq2
                          | otherwise = App (dropSeq n seq1) seq2 
                          where nx = contaCons seq1

contaCons :: Seq a -> Int
contaCons Nil = 0
contaCons (Cons _ s) = 1 + contaCons s
contaCons (App s1 s2) = contaCons s1 + contaCons s2



auxInstance :: Show a => Seq a -> String
auxInstance Nil = ""
auxInstance (Cons x Nil) = show x
auxInstance (Cons x seq) = (show x) ++ "," ++ auxInstance seq
auxInstance (App seq1 seq2) = auxInstance seq1 ++ "," ++auxInstance seq2



instance Show a => Show (Seq a) where
    show  seq = "<<" ++ (auxInstance seq) ++ ">>"


-- pergunta 5
type Mat a = [[a]] 

mat = [[6,7,2],[1,5,9],[8,3,4]] 


getElem :: Mat a -> IO a 
getElem m = do tamanho <- dimMat m 
               elemLinha <- randomRIO (0, (fst tamanho)-1)
               elemColuna <- randomRIO (0,(snd tamanho)-1)
               return ((m !! elemLinha) !! elemColuna)
               
        

dimMat :: Mat a -> IO (Int,Int)
dimMat [] = return (0,0)
dimMat m = return (length m, length $ head m) 




magic :: Mat Int -> Bool
magic mat = linhasIguaisA n mat && colunasIguaisA n mat && diagonaisIguaisA n mat
    where n = sum (head mat)

linhasIguaisA :: Int -> Mat Int -> Bool
linhasIguaisA n = foldl (\acc l -> sum l == n && acc) True 

colunasIguaisA :: Int -> Mat Int -> Bool
colunasIguaisA n mat = foldl (\acc x -> sum (map (\l -> l !! x) mat) == n && acc) True [0..(length mat - 1)]

diagonaisIguaisA :: Int -> Mat Int -> Bool
diagonaisIguaisA n mat = sum (map (\n -> (mat !! n) !! n) [0..ln]) == n && sum (map (\n -> (mat !! n) !! (ln - n)) [0..ln]) == n
                       where ln = length mat - 1

