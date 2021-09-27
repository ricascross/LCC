data BTree a = Empty | Node a (BTree a) (BTree a) deriving Show

arv = Node 2 (Node 3 (Node 4 Empty (Node 6 Empty Empty)) (Node 7 Empty Empty)) (Node 6 Empty Empty)
arv1 = Node 20 (Node 30 (Node 40 Empty (Node 60 Empty Empty)) (Node 70 Empty Empty)) (Node 60 Empty Empty)
altura :: BTree a -> Int
altura Empty = 0
altura (Node r e d) = 1 + max (altura e) (altura d)

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node r e d) = 1 + (contaNodos e) + (contaNodos d)

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node r Empty Empty) = 1 
folhas (Node r e d) = (folhas e) + (folhas d)

prune :: Int -> BTree a -> BTree a
prune _ Empty = Empty
prune 0 _ = Empty
prune n (Node r e d) = Node r (prune (n-1) e) (prune (n-1) d)

path :: [Bool] -> BTree a -> [a]
path [] _ = []
path _ Empty = []
path (False:t) (Node r e d) = r:path t e 
path (True:t) (Node r e d) = r:path t d  


mirror :: BTree a -> BTree a
mirror Empty = Empty
mirror (Node r e d) = Node r (mirror d) (mirror e)

zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT _ Empty Empty = Empty
zipWithBT f (Node r e d) (Node root esq dir) = Node (f r root) (zipWithBT f e esq) (zipWithBT f d dir)

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty,Empty,Empty)
unzipBT (Node (a,b,c) e d) = (Node a unzipL1 unzipR1,Node b unzipL2 unzipR2,Node c unzipL3 unzipR3)
                           where (unzipL1,unzipL2,unzipL3) = unzipBT e
                                 (unzipR1,unzipR2,unzipR3) = unzipBT d

--pergunta2
minimo :: Ord a => BTree a -> a
minimo (Node r Empty _) = r
minimo (Node r e d) = minimo e 

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node _ Empty _) = d
semMinimo (Node r e d) = Node r (semMinimo e) d

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node e Empty _) = (e,Empty)
minSmin (Node e l r) = (a,Node e b r)
                     where (a,b) = minSmin l


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
type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL  deriving Show
data Classificacao = Aprov Int | Rep | Faltou deriving Show
type Turma = BTree Aluno  --  ́arvore bin ́aria de procura (ordenada por n ́umero

tur = (Node (5,"r",TE,Aprov 18) (Node (3,"c",MEL,Faltou) Empty (Node (4,"d",ORD,Rep) Empty Empty)) (Node (6,"g",TE,Aprov 13) Empty Empty))

inscNum :: Numero -> Turma -> Bool
inscNum _ Empty = False
inscNum x (Node (n,_,_,_) e d) | x == n = True
                               | x < n = inscNum x e 
                               | otherwise = inscNum x d 

inscNome :: Nome -> Turma -> Bool
inscNome _ Empty = False
inscNome x (Node (_,n,_,_) e d) | x == n = True
                                | x < n = inscNome x e 
                                | otherwise = inscNome x d 

trabEst :: Turma -> [(Numero,Nome)]
trabEst (Node (n,name,TE,_) e d) = (n,name):trabEst e ++ (trabEst d)
trabEst _ = []

nota :: Numero -> Turma -> Maybe Classificacao
nota num (Node (n,_,_,classi) e d) | num == n = Just classi
                                   | num < n = nota num e 
                                   | otherwise = nota num d 
nota  _ _ = Nothing  

percFaltas :: Turma -> Float
percFaltas ar = (fromIntegral(numFaltaram ar)/ fromIntegral(numTurma ar)) * 100

numFaltaram :: Turma -> Int
numFaltaram (Node (_,_,_,Faltou) e d) = 1 + (numFaltaram e) + (numFaltaram d)
numFaltaram (Node r e d) = 0 + (numFaltaram e) + (numFaltaram d) 
numFaltaram Empty = 0

numTurma :: Turma -> Int 
numTurma Empty = 0
numTurma (Node r e d) = 1 + (numTurma e) + (numTurma d)

mediaAprov :: Turma -> Float
mediaAprov ar = fromIntegral(aprov ar)/fromIntegral(nAprov ar)

aprov :: Turma -> Int 
aprov (Node (_,_,_,Aprov x) e d) = x + (aprov e) + (aprov d)
aprov (Node r e d) = 0 + (aprov e) + (aprov d)
aprov Empty = 0

nAprov :: Turma -> Int 
nAprov (Node (_,_,_,Aprov x) e d) = 1 + (nAprov e) + (nAprov d)
nAprov (Node r e d) = 0 + (nAprov e) + (nAprov d)
nAprov Empty = 0

aprovAv :: Turma -> Float
aprovAv Empty = 0
aprovAv turma = a / b
             where (a,b) = aux turma
                   aux Empty = (0,0)
                   aux (Node (_,_,_,clas) l r) = case clas of Aprov nota -> (x+1,y) ; Rep -> (x,y+1) ; otherwise -> (x,y)
                                               where (x,y) = (c+e,d+f)
                                                     (c,d) = aux l
                                                     (e,f) = aux r
