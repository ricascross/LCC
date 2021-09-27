any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' f (h:t) | f h = True
             | otherwise = any' f t

zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f (h:t) (x:xs) = (f h x):zipWith' f t xs
zipWith' _ _ _ = []

takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f (h:t) | f h = h:takeWhile' f t
                   | otherwise = []
takeWhile' _ _ = []

dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f (h:t) | f h = dropWhile' f t
                   | otherwise = h:t
dropWhile' _ _ = []

span' :: (a-> Bool) -> [a] -> ([a],[a])
span' f (h:t) | f h = (h:takeWhile f t, dropWhile f t)
              | otherwise = ([],(h:t))

span' _ _ = ([],[])

deleteBy' :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy' f x (h:t) | f x h = t 
                    | otherwise = h:deleteBy' f x t 
deleteBy' _ _ _ = []


sortOn' :: (Ord b) => (a -> b) -> [a] -> [a]
sortOn' f [] = []
sortOn' f (h:t) = insere (h) (sortOn' f t)
                where insere x [] = [x]
                      insere x (a:b) = if f x > f a then a:insere x b else x:a:b

--pergunta2
type Polinomio = [Monomio]
type Monomio = (Float,Int)

pol = [(2,3), (3,4), (5,3), (4,5)]

selgrau :: Int -> Polinomio -> Polinomio
selgrau _ [] = []
selgrau n l = filter (\x -> snd x == n) l

conta :: Int -> Polinomio -> Int
conta _ [] = 0
conta n l = length  (filter (\x -> n == snd x) l)

grau :: Polinomio -> Int
grau l = maximum (map snd l)

deriv :: Polinomio -> Polinomio
deriv l = map(\(b,e) -> if (e>0) then (b*fromIntegral e, e-1) else (0,0)) l

calcula :: Float -> Polinomio -> Float
calcula x = foldl (\acc (b,e) -> acc + b * (x ^ e)) 0

simp :: Polinomio -> Polinomio
simp l = filter (\x->snd x /=0) l

mult :: Monomio -> Polinomio -> Polinomio
mult (x,y) l = map (\(b,e) -> (b*x,y+e)) l

ordena :: Polinomio -> Polinomio
ordena l = sortOn' snd l

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((x,y):t) = (sum [x' | (x',y') <- selgrau y t] + x,y):normaliza [(z,w) | (z,w) <- t, y/=w]  

soma :: Polinomio -> Polinomio -> Polinomio
soma pol1 pol2 = normaliza $ (++) pol1 pol2

produto :: Polinomio -> Polinomio -> Polinomio
produto pol1 pol2 = foldl (\acc x -> soma(mult x pol2) acc) [] pol1

--pergunta3
type Mat a = [[a]]

mat1 = [[1,2,3], [0,4,5], [0,0,6]]
mat2 = [[10,20,30], [1,40,50], [1,2,60]]

dimOK :: Mat a -> Bool
dimOK mat = not(any (/= comp) (map length mat))
          where comp = length $ head mat

dimMat :: Mat a -> (Int,Int)
dimMat [] = (0,0)
dimMat l = (length (head l), length l)

addMat :: Num a => Mat a -> Mat a -> Mat a
addMat [] [] = []
addMat (x:xs) (y:ys) = zipWith' (+) x y: addMat xs ys

transpose' :: Mat a -> Mat a 
transpose' [] = []
transpose' m = if (length (head m) > 1) then (map head m) : (transpose' (map tail m)) else [(map head m)]

multMat :: Num a => Mat a -> Mat a -> Mat a
multMat m1 m2 = (map (\x -> (sum (zipWith (*) (head m1) x))) (transpose' m2)) : (multMat (tail m1) m2)

zipWMat :: (a -> b -> c) -> Mat a -> Mat b -> Mat c
zipWMat _ [] [] = []
zipWMat f [] l = []
zipWMat f l [] = []
zipWMat f m1 m2 = zipWith f (head m1) (head m2):zipWMat f (tail m1) (tail m2)

--g)
triSup :: (Eq a,Num a) => Mat a -> Bool
triSup [] = False
triSup m = tAux 0 m 
          where
              tAux x [] = True
              tAux x (h:ts) = if ((length (fst (span (0 ==) h))) >= x) then tAux (x + 1) ts else False

--h)
rotateLeft :: Mat a -> Mat a
rotataLeft [] = []
rotateLeft m = if (length (head m)) > 1 then (rotateLeft (map (drop 1) m)) ++ [map head m] else [map head m]

