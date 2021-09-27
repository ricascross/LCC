data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

arvore = Node 6 (Node 4 (Node 2 Empty Empty) (Node 5 Empty Empty)) (Node 8 (Node 7 Empty Empty) Empty)



--pergunta 1
--a)
altura :: BTree a -> Int
altura Empty = 0
altura (Node r e d) = 1 + max(altura e) (altura d)


--b)
contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node r e d) = 1 + (contaNodos e) + (contaNodos d)

--c)
folhas :: BTree a -> Int
folhas Empty = 1
folhas (Node r e d) = (folhas e) + (folhas d) 

--d)
prune :: Int -> BTree a -> BTree a
prune x Empty = Empty
prune 0 (Node r e d) = Empty
prune x (Node r e d) = (Node r (prune (x-1) e) (prune (x-1) d))

--e)
path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path [] (Node r e d) = [r]
path (False:t) (Node r e d) = r:path t e
path (True:t) (Node r e d) = r:path t d

--f)
mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node r e d) = Node r (mirror d) (mirror e)

--g)
--zipWithBt :: (a->b->c) -> BTree a -> BTree b -> BTree c
--zipWithBt f (Node r e d) (Node x y z) 

--2)
--a)
minimo :: Ord a => BTree a -> a
minimo (Node r Empty Empty) = r 
minimo (Node r e d) = minimo e

--b)
semMinimo :: Ord a => BTree a -> BTree a 
semMinimo (Node r Empty Empty) = Empty
semMinimo (Node r e d) = Node r (semMinimo e) d

--c)
minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node r Empty d) = (r, d)
minSmin (Node r e d) = (m, Node r e' d)
                     where (m,e') = minSmin e

--d)
remove :: Ord a => a -> BTree a -> BTree a
remove _ Empty = Empty
remove x (Node r e d) | x == r = tiraRaiz (Node r e d)
                      | x > r = Node r e (remove x d)
                      | otherwise = Node r (remove x e) d

tiraRaiz :: Ord a => BTree a -> BTree a 
tiraRaiz (Node r Empty d) = d
tiraRaiz (Node r e Empty) = e
tiraRaiz (Node r e d) = Node x e y 
                      where (x,y) = minSmin d


--pergunta3

type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL  deriving Show
data Classificacao = Aprov Int | Rep | Faltou deriving Show
type Aluno = (Numero,Nome,Regime,Classificacao)
type Turma = BTree Aluno  --arvore binaria de procura (ordenada por numero



inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum n (Node (nu,no,re,clas) e d) | n == nu = True
                                     | n < nu = inscNum n e 
                                     | otherwise = inscNum n d

inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome n (Node (nu,no,re,clas) e d) | n == no = True
                                      | n < no = inscNome n e 
                                      | otherwise = inscNome n d

trabEst :: Turma -> [(Numero, Nome)]
trabEst Empty = []
trabEst (Node (nu,no,TE,clas) e d) = [(nu,no)]++trabEst e++trabEst d
trabEst (Node r e d)  = trabEst e ++ trabEst d


nota :: Numero -> Turma -> Maybe Classificacao
nota n Empty = Nothing
nota n (Node (nu,no,re,clas) e d) | n == nu = Just clas
                                  | n < nu = nota n e
                                  |otherwise = nota n d

percFaltas :: Turma -> Float
percFaltas Empty = 0
percFaltas arv = ( (perAux arv) /(perContaNodos arv)) * 100

perContaNodos :: Turma -> Float
perContaNodos Empty = 0
perContaNodos (Node r e d) = 1 + (perContaNodos e) + (perContaNodos d)

perAux :: Turma -> Float
perAux (Node (nu,no,re,Faltou) Empty Empty) = 1
perAux (Node (nu,no,re,Faltou) e d) = 1 + (perAux e) + (perAux d)
perAux (Node r e d) = (perAux e) + (perAux d)
perAux _ = 0


mediaAprov :: Turma -> Float
mediaAprov Empty = 0
mediaAprov (Node (nu,no,re,Aprov x) e d) = ((fromIntegral x) + (mediaAprov e) + (mediaAprov d)) / 
                                           (mediaAux (Node (nu,no,re, Aprov x) e d))  
mediaAprov (Node r e d) = (mediaAprov e)+(mediaAprov d) 

mediaAux :: Turma -> Float
mediaAux Empty = 0
mediaAux (Node (nu,no,re,Aprov x) e d) = 1 + (mediaAux e) + (mediaAux d)
mediaAux (Node r e d) = (mediaAux e)+(mediaAux d) 