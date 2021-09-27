import Data.Char

--pergunta1
enumFromTo' :: Int -> Int -> [Int]
enumFromTo' x y | x <= y = x:enumFromTo' (x+1) y
                | otherwise = []
--2)
enumFromThenTo' :: Int -> Int -> Int -> [Int]
enumFromThenTo' min x max | min < max = min:enumFromThenTo' ((x+min)-1) x max
                          | otherwise = []
--3)
(+++) :: [a] -> [a] -> [a]
(+++) [] [] = []
(+++) [] l = l
(+++) (h:t) l = h: (+++) t l

--4)
(!!!) :: [a] -> Int -> a
(!!!) l x = auxPos 0 l x

auxPos :: Int -> [a] -> Int -> a
auxPos acc (h:t) x | acc == x = h
                   | otherwise = auxPos (acc+1) t x

--5)
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (h:t) = (reverse' t) ++ [h]

--6)
take' :: Int -> [a] -> [a]
take' _ [] = []
take' x l | length l < x = l
take' x (h:t) | x>0 = h:take' (x-1) t
              | otherwise = [] 

--7)
drop' :: Int -> [a] -> [a]
drop' _ [] = []
drop' x l | length l <= x = []
drop' x (h:t) | x>0 = drop' (x-1) t 
              | otherwise = (h:t)

--8)
zip' :: [a] -> [b] -> [(a,b)]
zip' [] [] = []
zip' [] l = []
zip' l [] = []
zip' (h:t) (x:xs) = (h,x):zip' t xs

--9)
elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' x (h:t) | x == h = True
              | otherwise = elem' x t

--10)
replicate' :: Int -> a -> [a]
replicate' 0 y = []
replicate' x y = y:replicate' (x-1) y

--11)
intersperce' :: a -> [a] -> [a]
intersperce' _ [] = []
intersperce' _ [x] = [x]
intersperce' x (h:t) = h:x:intersperce' x t 

--12)
group' :: Eq a => [a] -> [[a]]
group' [] = []
group' (h:t) = (groupAux h (h:t)):group' (iguais h t)

groupAux :: Eq a => a -> [a] -> [a]
groupAux x [] = []
groupAux x (h:t) | x==h  = x:groupAux x t 
                 | otherwise = []

iguais :: Eq a => a -> [a] -> [a]
iguais _ [] = []
iguais x (h:t) | x == h = iguais x t 
               | otherwise = (h:t)

--13)
concat' :: [[a]] -> [a]
concat' [] = []
concat' (h:t) = h++concat' t

--14)
inits' :: [a] -> [[a]]
inits' [] = []
inits' l = initsAux l [] 
         where initsAux [] l = [l]
               initsAux (h:t) l = l:(initsAux t (l++[h]))

--15)
tails' :: [a] -> [[a]]
tails' [] = [[]]
tails' (h:t) = (h:t):(tails' t)

--16)
isPrefixOf' :: Eq a => [a] -> [a] -> Bool
isPrefixOf' [] [] = True
isPrefixOf' [] l = True
isPrefixOf' l [] = False
isPrefixOf' (h:t) (x:xs) | h == x = isPrefixOf' t xs
                         | otherwise = False

--17)
isSuffixOf' :: Eq a => [a] -> [a] -> Bool
isSuffixOf' [] [] = True
isSuffixOf' [] l = False
isSuffixOf' l [] = False
isSuffixOf' l1 l2 = isPrefixOf' (reverse l1) (reverse l2)

--18)
isSubsequenceOf' :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf' [] [] = True
isSubsequenceOf' l [] = False
isSubsequenceOf' [] l = True
isSubsequenceOf' (h:t) (x:xs) | h == x = isSubsequenceOf' t xs
                              | otherwise = isSubsequenceOf' (h:t) xs 

--19)
elemIndices' :: Eq a => a -> [a] -> [Int]
elemIndices' _ [] = []
elemIndices' x l = elemAux 0 x l 

elemAux :: Eq a => Int -> a -> [a] -> [Int]
elemAux _ _ [] = []
elemAux acc x (h:t) | x == h = acc:elemAux (acc+1) x t 
                    | otherwise = elemAux (acc+1) x t

--20)
nub' :: Eq a => [a] -> [a]
nub' [] = []
nub' l = nubAux l [] 

nubAux :: Eq a => [a] -> [a] -> [a]
nubAux [] l = l
nubAux (h:t) l | elem' h l = nubAux t l
               | otherwise = nubAux t (l++[h])

--21)
delete' :: Eq a => a -> [a] -> [a]
delete' _ [] = []
delete' x (h:t) | x == h = t 
                | otherwise = h:delete' x t

--22) (//)
remove' :: Eq a => [a] -> [a]-> [a]
remove' [] [] = []
remove' [] l = []
remove' l [] = l 
remove' l (x:xs) = remove' (delete' x l) xs

--23)
union' :: Eq a => [a] -> [a] -> [a]
union' [] [] = []
union' [] l = []
union' l [] = l
union' l (h:t) | elem' h l = union' l t
               | otherwise = (union' l t)++[h]

--24)
intersect' :: Eq a => [a] -> [a] -> [a]
intersect' [] [] = []
intersect' [] l = []
intersect' l [] = l 
intersect' (h:t) l | elem' h l = h:intersect' t l 
                   | otherwise = intersect' t l

--25)
insert' :: Ord a => a -> [a]-> [a]
insert' x [] = [x]
insert' x (h:t) | x <= h = x:h:t 
                | otherwise = h:insert' x t 

--26)
unwords' :: [String] -> String
unwords' [x] = x
unwords' (h:t) = h++" "++ (unwords' t)

--27) 
unlines' :: [String] -> String
unlines' [x] = x++"\n"
unlines' (h:t) = h ++ "\n" ++ (unlines' t)

--28)
pMaior :: Ord a => [a] -> Int
pMaior l = auxpMaior 0 l 

auxpMaior :: Ord a => Int -> [a] -> Int
auxpMaior acc [x] = acc 
auxpMaior acc (h:t) | h > (maximum t) = acc
                    | otherwise = auxpMaior (acc+1) t

--29)
temRepetidos :: Eq a => [a] -> Bool
temRepetidos [] = False
temRepetidos (h:t) = auxRep h t

auxRep :: Eq a => a -> [a] -> Bool
auxRep _ [] = False
auxRep x (h:t) | elem x (h:t) = True
               | otherwise = auxRep h t

--30)
algarismos :: [Char] -> [Char]
algarismos [] = []
algarismos (h:t) | isDigit h = h:algarismos t 
                 | otherwise = algarismos t

--31)
posImpares :: [a] -> [a]
posImpares [] = []
posImpares l = auxImpares 0 l

auxImpares :: Int -> [a] -> [a]
auxImpares _ [] = []
auxImpares p (h:t) | mod p 2 == 0 = auxImpares (p+1) t 
                   | otherwise = h:auxImpares (p+1) t

--32)
posPares :: [a] -> [a]
posPares [] = []
posPares l = auxPares 0 l

auxPares :: Int -> [a] -> [a]
auxPares _ [] = []
auxPares p (h:t) | mod p 2 == 0 = h:auxPares(p+1) t 
                 | otherwise = auxPares (p+1) t

--33)
isSorted :: Ord a => [a] -> Bool
isSorted [x] = True
isSorted (h:t) | h <= (head t) = isSorted t 
               | otherwise = False

--34)
iSort :: Ord a => [a] -> [a]
iSort [] = []
iSort (h:t) = insert' h (iSort t)

--35)
menor :: String -> String -> Bool
menor [] [] = False
menor [] l = True
menor l [] = False
menor (h:t) (x:xs) | h < x = True
                   | h > x = False
                   | otherwise = menor t xs

--36)
elemMSet :: Eq a => a -> [(a,Int)] -> Bool
elemMSet _ [] = False
elemMSet x (h:t) | x == (fst h) = True
                 | otherwise = elemMSet x t

--37)
lengthMSet :: [(a,Int)] -> Int
lengthMSet [(a,x)] = x
lengthMSet (h:t) = (snd h) + lengthMSet t

--38)
convertMSet :: [(a,Int)] -> [a]
convertMSet [] = []
convertMSet (h:t) = (replicate (snd h) (fst h)) ++ convertMSet t

--39)
insereMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
insereMSet x [] = [(x,1)]
insereMSet x (h:t) | x == fst h = ((fst h), (snd h) +1):t 
                   | otherwise = h:insereMSet x t

--40)
removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet _ [] = []
removeMSet x (h:t) | x == (fst h) && (snd h) > 1 = (fst h, (snd h) -1):removeMSet x t 
                   | x == (fst h) && (snd h) == 1 = t
                   | otherwise = h:removeMSet x t

--41) 
constroiMSet' :: Ord a => [a] -> [(a,Int)]
constroiMSet' [] = []
constroiMSet' (h:t) = (h, (auxTamanho h t)):constroiMSet' (auxShift h t)

auxTamanho :: Ord a => a -> [a] -> Int
auxTamanho x [] = 1
auxTamanho x (h:t) | x==h = 1 + (auxTamanho x t)
                   | otherwise = 1


auxShift :: Ord a => a-> [a] -> [a]
auxShift _ [] = []
auxShift x (h:t) | h == x = auxShift h t 
                 | otherwise = (h:t)

--42)
partitionEithers ::  [Either a b] -> ([a],[b])
partitionEithers [] = ([], [])
partitionEithers' ((Left x):t) = (x:fst(partitionEithers' t), snd(partitionEithers' t))
partitionEithers' ((Right x):t) = (l1,x:l2)
                               where (l1,l2) = partitionEithers' t 

--43)
catMaybes :: [Maybe a] -> [a]
catMaybes [] = []
catMaybes ((Just x):t) = x:catMaybes t 
catMaybes (Nothing:t) = catMaybes t

--44)
data Movimento = Norte | Sul | Este | Oeste deriving Show

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao x [] = x 
posicao (x,y) (Norte:t) = posicao (x,y+1) t
posicao (x,y) (Sul:t) = posicao (x,y-1) t 
posicao (x,y) (Este:t) = posicao (x+1,y) t
posicao (x,y) (Oeste:t) = posicao (x-1,y) t

--45)
caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x,y) (x2,y2) | y < y2 = Norte:caminho (x,y+1) (x2,y2)
                      | y > y2 = Sul: caminho (x,y-1) (x2,y2)
                      | x < x2 = Este:caminho ((x+1), y) (x2,y2)
                      | x > x2 = Oeste:caminho ((x-1),y) (x2,y2)
                      |otherwise = [] 

--46)
vertical :: [Movimento] -> Bool
vertical [] = True
vertical (Norte:t) = vertical t 
vertical (Sul:t) = vertical t
vertical (_:t) = False

--47)
data Posicao = Pos Int Int deriving Show

maisCentral :: [Posicao] -> Posicao
maisCentral [x] = x
maisCentral ((Pos x y):(Pos z w):t) | distanciaPontos (Pos x y) (Pos 0 0) 
                                    < distanciaPontos (Pos z w) (Pos 0 0)
                                    = maisCentral ((Pos x y):t)
                                    | otherwise = maisCentral ((Pos z w):t)

distanciaPontos :: Posicao -> Posicao -> Float
distanciaPontos (Pos x y) (Pos z w) = sqrt(fromIntegral(((z-x)^2)+((w-y)^2)))

--48)
vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos x [] = []
vizinhos (Pos x y) ((Pos z w):t) | (z-1) == x || (z+1) == x || (w-1)==y || (w+1)==y  = (Pos z w):vizinhos (Pos x y) t 
                                 |otherwise = vizinhos (Pos x y) t

--49)
mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [x] = True
mesmaOrdenada ((Pos x y):(Pos z w):t) | y == w = mesmaOrdenada ((Pos z w):t)
                                      | otherwise = False

--50)
data Semaforo = Verde | Amarelo | Vermelho deriving Show

interseccaoOK :: [Semaforo] -> Bool
interseccaoOK [] = True
interseccaoOK (Vermelho:t) = interseccaoOK t 
interseccaoOK (_:t) = cautela t 
                    where cautela [] = True
                          cautela (Vermelho:t) = interseccaoOK t 
                          cautela (_:t) = False