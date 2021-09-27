--pergunta1a)
any' :: (a->Bool) -> [a] -> Bool
any' f (h:t) | f h = True
             | otherwise = any' f t 
any' _ _ = False

--1b)
zipWith' :: (a->b->c) -> [a] -> [b] -> [c]
zipWith' f (h:t) (x:xs) = f h x: zipWith' f t xs 
zipWith' _ _ _ = []

--c)
takeWhile' :: (a->Bool) -> [a] -> [a]
takeWhile' f (h:t) | f h = h:takeWhile' f t
                   | otherwise = []
takeWhile' _ _ = []

dropWhile' :: (a->Bool) -> [a] -> [a]
dropWhile' f (h:t) | f h = dropWhile' f t 
                   | otherwise = h: dropWhile' f t
dropWhile' _ _ = []

span' :: (a->Bool) -> [a] -> ([a], [a])
span' f l = (takeWhile' f l,dropWhile' f l)

deleteBy' :: (a->a->Bool) -> a -> [a] -> [a]
deleteBy' f x (h:t) | f x h = deleteBy' f x t 
                    | otherwise = h:deleteBy' f x t
deleteBy' _ _ _= []

sortOn' :: Ord b => (a->b)-> [a]-> [a]
sortOn' f [x] = [x] 
sortOn' f (h:x:t) | f h <= f x = h:x:t
                  | otherwise = x:sortOn' f (h:t)
sortOn' _ _ = []


--pergunta2
type Polinomio = [Monomio]
type Monomio = (Float, Int)



selgrau :: Int -> Polinomio -> Polinomio
selgrau n ps = filter (\x -> snd x == n) ps 

conta :: Int -> Polinomio -> Int
conta n l = length( filter (\x -> snd x == n) l)

grau :: Polinomio -> Int
grau ps = maximum (map snd ps)

eriv :: Polinomio -> Polinomio
deriv ps = filter (/= (0,0)) $ map (\(b,e) -> if e > 0 then (b * fromIntegral e, e - 1) else (0,0)) ps

calcula :: Float -> Polinomio -> Float
calcula a = foldl (\acc (b,e) -> acc + b * (a ^ e)) 0

simp :: Polinomio -> Polinomio
simp = filter (\(b,e) -> e /= 0) 

mult :: Monomio -> Polinomio -> Polinomio
mult (x,y) = map (\(b,e) -> (b*x,y+e))

ordena :: Polinomio -> Polinomio
ordena = sortOn (snd)

normaliza :: Polinomio -> Polinomio
normaliza [] = []
normaliza ((b,e):ps) = (sum [bs | (bs,es) <- selgrau e ps] + b,e):normaliza [(bo,eo) | (bo,eo) <- ps, eo /= e]

soma :: Polinomio -> Polinomio -> Polinomio
soma p r = normaliza $ (++) p r


--pergunta3

type Mat a = [[a]]

dimOk :: Mat a -> Bool
dimOk [x] = True
dimOk (h:x:t) | dimAux h == dimAux x = dimOk (x:t)
              | otherwise = False

dimAux :: [a] -> Int
dimAux [] = 0
dimAux l = length l

--pergunta b)
dimMat ::Mat a -> (Int,Int)
dimMat [] = (0,0)
dimMat (h:t) | dimOk (h:t) = (length (h:t), length h)
             | otherwise = (0,0)

--c)
{-addMat :: Num a => Mat a -> Mat a -> Mat a 
addMat [] [] = []
addMat [l] [] = [l]
addMat [] [l] = [l]
addMat (h:t) (x:xs) | dimMat (h:t) == dimMat (x:xs) = (addAux h x): (addMat t xs) 
                    | otherwise = []

addAux :: Num a => [a] -> [a] -> [a]
addAux [] [] = []
addAux l [] = l
addAux [] l = l
addAux (h:t) (x:xs) = (h+x) : addAux t xs-}

addMat :: Num a => Mat a -> Mat a -> Mat a 
addMat [] [] = []
addMat [l] [] = [l]
addMat [] [l] = [l]
addMat (h:t) (x:xs) | dimMat (h:t) == dimMat (x:xs) = (zipWith' (+) h x) : (addMat t xs)
                    | otherwise = []
--d)
transpose :: Mat a -> Mat a 
transpose [] = []
transpose l = [(transposeAux n l) | n <-[0..(fst(dimMat l)-1)]]

transposeAux :: Int -> Mat a -> [a]
transposeAux _ [] = []
transposeAux cont (h:t) = [h !! cont] ++ transposeAux cont t

--e)
multMat :: Num a => Mat a -> Mat a -> Mat a 
multMat [] [] = []
multMat [l] [] = [l]
multMat [] [l] = [l]
multMat (h:t) (x:xs) | snd(dimMat (h:t)) == fst(dimMat (x:xs)) = (zipWith' (*) h x) : (multMat t (x:xs))
                     | otherwise = []


{-zipWMat :: (a->b->c) -> Mat a -> Mat b -> Mat c 
zipWMat f ((h:t):l) ((x:xs):z) = [f h x] ++ zipWMat f (t:l) (xs:z)
zipWMat _ _ _ = [[]]-}






