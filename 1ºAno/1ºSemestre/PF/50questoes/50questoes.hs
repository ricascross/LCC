
import Data.List
import Data.Char
import Data.Either
import Data.Maybe 

-- constroi uma lista de inteiros compreendidos entre dois limites
enumFromTo2 :: Int -> Int -> [Int]
enumFromTo2 x y | y == x = [x]
                | y < x = []
                | otherwise = x : enumFromTo2 (x+1) y 

-- constroi uma lista de inteiros compreendido entre dois limite e espaçdos por um valor constante
enumFromThenTo2 :: Int -> Int -> Int -> [Int]
enumFromThenTo2 x y z | x == z = [x]
					  | z < x = []
					  | otherwise = x : enumFromThenTo2 (x+(y-1)) y z

-- junta duas listas
somas :: [a] -> [a] -> [a]
somas [] l = l
somas l [] = l
somas (x:xs) l = x : ( somas xs l)

-- dado um inteiro e uma lista define onde o elemento em que se encontra na posiçao do inteiro dado
escalmaca2 :: [a] -> Int -> a
escalmaca2 (x:xs) y  | y == 0 = x
					 | otherwise = escalmaca2 xs (y-1)

-- dada uma lista devolve lista inversa
reverse2 :: [a] -> [a]
reverse2 [] = []
reverse2 (x:xs) = (reverse2 xs ) ++ [x]

--dada uma lista e um inteiro n , devolve uma lista com os primeiros elemtos n da mesma
take2 :: Int -> [a] -> [a]
take2 y [] = []
take2 y (x:xs) | y == 0 = []
			   | otherwise = x : take2 (y-1) xs

-- dado uma lista e numero inteiro n , a lista deixa os primeiros n elementos da lista
drop2 :: Int -> [a] -> [a]
drop2 n [] = []
drop2 n (x:xs) | n == 0 = (x:xs)
			   | otherwise = drop2 (n-1) xs 

-- dadas duas listas , devolve os tupos de cada elemnto da lista
zip2 :: [a] -> [b] -> [(a,b)]
zip2 [] l = []
zip2 l [] = []
zip2 (x:xs) (y:ys) = (x,y) : zip2 xs ys

-- dado um elemento e uma lista testa se esse elemento esta presente na lista 
elem2 :: Eq a => a -> [a] -> Bool
elem2 e [] = False
elem2 e (x:xs) | x == e    = True
			   | otherwise = elem2 e xs 

-- recebe um inteiro e um elemento e produz uma lista com esse elemnto n vezs
replicate2 :: Int -> a -> [a] 
replicate2 x y | x == 0 = []
			   | otherwise = y : replicate2 (x-1) y 

-- da um elemnto que coloca se nos espaços de uma lista 
intersperse2 :: a -> [a] -> [a]
intersperse2 e [] = []
intersperse2 e [x] = [x]
intersperse2 e (x:xs) = x:e: intersperse2 e xs

--uma funçao que agroupa os elementos iguais 
group2 :: Eq a => [a] -> [[a]]
group2 [] = []
group2 l = groupAux l : group2 ( (\\) l (groupAux l)) where

groupAux [x]= [x]
groupAux (x:y:xs)| y == x = x : groupAux (y: xs) 
		         | otherwise = [x]

--dada uma lista de lista junta todas numa so lista
concat2 :: [[a]] -> [a]
concat2 [] = []
concat2 (x:xs) = x ++ concat2 (xs)

-- calcula a lista de prefixo
inits2:: [a] -> [[a]]
inits2 [] = [[]]
inits2 l = reverse (inits2Aux2 l) where
	inits2Aux [x] = []
	inits2Aux (x:xs) = x : inits2Aux xs 
	inits2Aux2 [] = [[]]
	inits2Aux2 l = (l:(inits2Aux2 (inits2Aux l)))

--calcula os sufixos de uma lista
tails2 :: [a] -> [[a]]
tails2 [] = [[]]
tails2 (x:xs) = (x:xs) : (tails2 xs)

--testa se uma lista é prefixo de outra
isPrefixOf2 :: Eq a => [a] -> [a] -> Bool
isPrefixOf2 [] [] = True
isPrefixOf2 [] l  = True
isPrefixOf2 l  [] = False
isPrefixOf2 (x:xs) (y:ys) | (x == y)  = isPrefixOf2 xs ys
						  | otherwise = False

-- testa se uma lista e suficxo de outra
isSuffixOf2 :: Eq a => [a] -> [a] -> Bool
isSuffixOf2 l1 l2 = isPrefixOf (reverse l1) (reverse l2) -- nesta funçao se for no teste de agr , tem de se defenir a isPrefixOf pois ela nao esta incluida no prelude, tem de se fazer o import Data.List 

-- testa se elementos de uma lista ocorrem noutra na respetiva ordem 
isSubsequenceOf2 :: Eq a => [a] -> [a] -> Bool
isSubsequenceOf2 [] [] = True 
isSubsequenceOf2 l  [] = False
isSubsequenceOf2 [] l  = True
isSubsequenceOf2 (x:xs) (y:ys) | x == y = isSubsequenceOf2 xs ys
					           | otherwise = isSubsequenceOf2 (x:xs) ys

-- calcula a lsita de indicis que um elemento se encontra numa lista
elemIndices2 :: Eq a => a -> [a] -> [Int]
elemIndices2 elem [] = []
elemIndices2 elem l = (elemIndices2Aux 0 elem l) where
				elemIndices2Aux x y [] = []
				elemIndices2Aux x y (h:xs) | (y == h) = x : (elemIndices2Aux (x+1) y xs)
						  				   | otherwise = (elemIndices2Aux (x+1) y xs)

-- recebe uma lsita e devolve a sem repetiçoes
nub2 :: Eq a => [a] -> [a]
nub2 [] = []
nub2 (x:xs) = x : (nub2 (nub2Aux x xs))
nub2Aux x [] = []
nub2Aux x ( y:ys) | x == y = nub2Aux x ys
				 | otherwise = y : nub2Aux x ys

-- elimina a primeira ocorrencia de um elemento dado a uma lista
delete2 :: Eq a => a -> [a] -> [a]
delete2 _ [] = []
delete2 y (x:xs) | y == x = xs 
				 | otherwise = x :delete2 y xs

-- elimina os elemntos da segunda lista dada na primeira , ha primeira ocorrencia 
elimina :: Eq a => [a] -> [a] -> [a]
elimina [] [] = []
elimina [] l  = []
elimina l  [] = l 
elimina l (y:ys) = elimina ( delete2 y l ) ys

-- acrescenta a uma lista os elementos que nao ocorrem na segunda
union2 :: Eq a =>  [a] -> [a] -> [a]
union2 [] [] = []
union2 l  [] = l
union2 [] l  = l
union2 (x:xs) (y:ys) | elem y (x:xs)= union2 (x:xs) ys
					 | otherwise = union2 (reverse2 (y: reverse2 (x : xs))) ys

--elimina a primeira lista os elementos que nao pertecem a segunda
intersect2 :: Eq a => [a] -> [a] -> [a]
intersect2 [] [] = []
intersect2 [] l  =[]
intersect2 l  [] = [] 
intersect2 (x:xs) l | elem x l = x: intersect2 xs l
					| otherwise = intersect2 xs l  

-- insere um elemnto numa lista ordenada 
insert2 :: Ord a => a -> [a] -> [a]
insert2 x [] = [x]
insert2 x (y:ys) | x <= y = (x:y:ys) 
  				 | otherwise = y : insert2 x ys 

-- junta uma lista de strings para uma string separada por espaços 
unwords2 :: [String] -> String 
unwords2 [] = []
unwords2 [x] = x
unwords2 (x:xs) = x ++ [' '] ++ unwords2 xs 

-- junta uma lissta de strins para uma pstrins e separadas po '/n'
unlines2 :: [String] -> String
unlines2 [] = []
unlines2 (x:xs) = x ++ ['\n'] ++ unlines2 xs

--dada uma lista nao vazia devolve a posiçao do elemento maior
pMaior2 :: Ord a => [a] -> Int
pMaior2 (x:xs) = pMaior2Aux 0 (maximum (x:xs)) (x:xs)   where
			pMaior2Aux y x  [] = y
			pMaior2Aux y x  (h:hs) | x == h = y 
						   	       | otherwise = pMaior2Aux (y+1) x hs

-- testa se uma lista tem elementos repetidos
temRepetidos2 :: Eq a => [a] -> Bool
temRepetidos2 [] = False
temRepetidos2 (x:xs) | elem x xs = True
					 | otherwise = temRepetidos2 xs 

-- determina a lista de algarismos de uma lista
algarismos2 :: [Char] -> [Char]
algarismos2 [] = []
algarismos2 (x:xs) | isDigit x = x : algarismos2 xs
				   | otherwise = algarismos2 xs 

-- dado uma lista devolve a lista em que os elementos da primeira estao em sitios impares 

posImpares :: [a] -> [a]
posImpares [] = []
posImpares [x] = []
posImpares [x,y] = [y]
posImpares (x:y:xs) = y : posImpares xs 

-- dado uma lista , devolve a lista em que os elementos da primeira estao em posiçoes pares
posPares :: [a] -> [a]
posPares [] = []
posPares [x] = [x]
posPares [x,y] = [x]
posPares (x:y:xs) = x : posPares xs 

-- testa se uma lista esta ordenada por ordem crescente 
isSorted2 :: Ord a => [a] -> Bool
isSorted2 [] = True
isSorted2 [x] = True
isSorted2 (x:xs) | x > (head xs) = False
			     | otherwise = isSorted2 xs

-- ordena uma lista
iSort2 :: Ord a => [a] -> [a]
iSort2 [] = []
iSort2 l = (minimum l) : (iSort2 (delete2 (minimum l) l))

-- dadas duas listas da verdade se a primeira for mais pequena que a segunda 
menor2 :: String -> String -> Bool
menor2 [] [] = False
menor2 [] l  = True
menor2 l  [] = False
menor2 (x:xs) (y:ys) | (toLower x) < (toLower y) = True
					 | (toLower x) > (toLower y) = False
					 | otherwise = menor2 xs ys

-- testa se um elemento pertence a um multiconjunto 
elemMSet2 :: Eq a => a -> [(a,Int)] -> Bool
elemMSet2 x [] = False
elemMSet2 x ((y,_):ys) | x == y = True
				 	   | otherwise = elemMSet2 x ys

--calcula um tamanho de um multiconjunto 
lengthMSet2 :: [(a,Int)] -> Int
lengthMSet2 [] = 0
lengthMSet2 ((_,y):ys) = y + lengthMSet2 ys

--converte um multiconjunto na lista de seu elementos
converteMSet2 :: [(a,Int)] -> [a]
converteMSet2 [] = []
converteMSet2 ((x,y):ys) = (replicate y x ) ++ converteMSet2 ys

--acrescenta um elemento a um multiconjunto
insereMSet2 :: Eq a => a -> [(a,Int)] -> [(a,Int)] 
insereMSet2 x [] = [(x,1)]
insereMSet2  x ((y,z):ys) | x == y = ((y,z+1):ys)
					      | otherwise = (y,z) : insereMSet2 x ys
 
--remove um elemento a um multiconjunto 
removeMSet2 :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet2 x [] = []
removeMSet2 x ((y,z):ys) | (x == y) && (z > 1)  = ((y , z-1) : ys)
						 | (x==y) && (z==1) = ys 
						 | otherwise = (y,z): removeMSet2 x ys

--dada uma lista ordenada por ordem crescente calcula o multiconjunto dos seus elementos
-- nesta maneira a lista nao precisa de estar ordenada 
constroiMSet2 :: Ord a => [a] -> [(a,Int)]
constroiMSet2 [] = []
constroiMSet2 (y:ys) = (y,p1) : constroiMSet2 (p2)
	where
		p1 =(length (filter (==y) (y:ys))) -- da o tamanho da lista dos elementos de y 
		p2 =filter (/=y) (y:ys) -- da a lista sem o y

--para esta funçao tem de se defenir ou a rights ou lefts , que sao do Data.Either recusivamente no test
--partitionEithers [ Left "foo", Right 3, Left "bar", Right 7, Left "baz" ] = (["foo","bar"," 1"],[3,7])
partitionEithers2 :: [Either a b] -> ([a],[b])
partitionEithers2 [] = ([],[])
partitionEithers2 l = (lefts l, rights2 l) where 
rights2 [] = []
rights2 ((Right y):xs) = y : rights2 xs 
rights2 ((Left y) :xs) = rights2 xs 

-- coleciona os Just
--catMaybes [Just 1, Nothing, Just 3] = [1,3]
catMaybes2 :: [Maybe a] -> [a] 
catMaybes2 [] = []
catMaybes2 (x:xs) | isJust x = (fromJust x ): catMaybes2 xs -- isJust do modulo Data.Maybes, assim com a fromJust
				  | otherwise = catMaybes2 xs 
--ou
catMaybes3 ::[Maybe a] -> [a]
catMaybes3 [] = []
catMaybes3 ((Just x):xs) = x :catMaybes3 xs
catMaybes3 ((Nothing):xs) = catMaybes3 xs 

data Movimento = Norte | Sul | Este | Oeste
		deriving Show 

data Posicao = Pos Int Int 
		deriving Show

--dada uma posiçao inicial e uma lista de moviemtnso delvolve a posiçao onde ira estar com lista de mvimentso 
posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) [] = (x,y)
posicao (x,y) (Norte:hs) = posicao (x,y+1) hs
posicao (x,y) (Sul  :hs) = posicao (x,y-1) hs
posicao (x,y) (Este :hs) = posicao (x+1,y) hs
posicao (x,y) (Oeste:hs) = posicao (x-1,y) hs

--dado a posicao inicial e final  da o caminho para chegar la 
caminho :: (Int,Int) -> (Int,Int) -> [Movimento]
caminho (x,y) (z,w) | x > z = Oeste : caminho (x-1,y) (z,w)
				    | x < z = Este  : caminho (x+1,y) (z,w)
				    | y > w = Sul   : caminho (x,y-1) (z,w)
				    | y < w = Norte : caminho (x,y+1) (z,w)
				    | otherwise = []

--testa se uma lista de movimentos so e composta por movimentos verticais 
vertical :: [Movimento] -> Bool
vertical [] = True
vertical (Norte:xs) = vertical xs 
vertical (Sul  :xs)	= vertical xs
vertical (Este :xs) = False
vertical (Oeste:xs) = False

-- dada uma lista de posiçoes diz a mais proxima da origem 
maisCentral :: [Posicao] -> Posicao
maisCentral [x] = x
maisCentral ((Pos x y):(Pos z d):xs) | (maisCentralAux (Pos 0 0) (Pos x y)) < (maisCentralAux (Pos 0 0) (Pos z d)) = maisCentral ((Pos x y):xs)
						      	     | otherwise = maisCentral ((Pos z d):xs) where
maisCentralAux (Pos a b) (Pos c d) = sqrt (( ((fromIntegral c)-(fromIntegral a))^2) + (((fromIntegral d)-(fromIntegral b))^2))

--dada uma posiçao e uma lista de posiçoes , devolve uma lista de posiçoes adjancentes 
vizinhos :: Posicao -> [Posicao] -> [Posicao]
vizinhos x [] = []
vizinhos (Pos x y) ((Pos w z):xs) | (x == (w-1)) || (x == (w + 1)) || (y == (z-1)) || (y== (z+1)) = (Pos w z ) : (vizinhos (Pos x y) xs)
								  | otherwise = vizinhos (Pos x y) xs

-- testa se uma lista de posiçao tem todas ordenadas iguais
mesmaOrdenada :: [Posicao] -> Bool
mesmaOrdenada [x] = True
mesmaOrdenada ((Pos x y):(Pos w z ) : xs) | y == z = mesmaOrdenada ((Pos x y):xs)
					                      | otherwise = False

data Semaforo = Verde | Amarelo | Vermelho 
				deriving (Show,Eq)

-- testa se um estado de um cruzamemnto e seguro 
interseccaook :: [Semaforo] -> Bool
interseccaook [] = True
interseccaook l = (length ((filter (==Verde) l) ++ (filter (==Amarelo) l)) == 1)
               







