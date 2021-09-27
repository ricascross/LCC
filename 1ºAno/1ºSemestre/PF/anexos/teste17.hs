insert' ::  Ord a => a -> [a] -> [a]
insert' x [] = [x]
insert' x (h:t) | x <= h = x:h:t
                | otherwise = h:insert' x t

catMaybes' :: [Maybe a] -> [a]
catMaybes' [] = []
catMaybes' (Just x:t) = x:catMaybes' t
catMaybes' (Nothing:t) = catMaybes' t  

data Exp a = Const a
           | Var   String
           | Mais (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

auxExp :: Show a => Exp a -> String
auxExp (Const x) = show x
auxExp (Var x) = x
auxExp (Mais a b) = "("++ (auxExp a) ++ " " ++ "+" ++ " " ++ (auxExp b) ++  ")"
auxExp (Mult a b) = "("++  (auxExp a) ++ " " ++ "*" ++ " " ++ (auxExp b) ++ ")"


instance Show a => Show (Exp a) where
	show = auxExp 

sortOn :: Ord b => (a -> b) -> [a] -> [a]
sortOn f [x] = [x]
sortOn f (h:x:t) | f h <= f x = h:sortOn f (x:t)
                 | otherwise = x:sortOn f (h:t)

amplitude :: [Int] -> Int
amplitude [] = 0
amplitude l = (maximum l) - (minimum l)

data Imagem = Quadrado Int
            | Mover (Int,Int) Imagem
            | Juntar [Imagem]

conta :: Imagem -> Int
conta (Quadrado x) = 1 
conta (Mover _ img) = conta img
conta (Juntar l) = sum(map conta l) 

apaga :: Imagem -> IO Imagem
apaga im = do
    let indquad = indices_quadrados im
    randNum <- randomRIO (1,length indquad)
    let indtoremove = indquad !! (randNum - 1)
    return $ apaga_indice indtoremove im 

indices_quadrados :: Imagem -> [Int]
indices_quadrados (Quadrado n) = [n]
indices_quadrados (Mover (_,_) im) = indices_quadrados im
indices_quadrados (Juntar l) = concatMap indices_quadrados l

apaga_indice :: Int -> Imagem -> Imagem
apaga_indice x (Quadrado n) = if x == n then Juntar [] else Quadrado n
apaga_indice x (Mover (a,b) im) = Mover (a,b) (apaga_indice x im)
apaga_indice x (Juntar l) = Juntar (map (apaga_indice x) l)
