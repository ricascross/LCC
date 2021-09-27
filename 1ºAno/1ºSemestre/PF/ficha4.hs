import Data.Char

--3)
digitAlpha :: String -> (String,String)
digitAlpha [] = ([], []) 
digitAlpha (h:t) | isDigit h = (x, h:y) 
                 | isAlpha h = (h:x, y)
                 where (x,y) = digitAlpha t

--4)
nzp :: [Int] -> (Int,Int,Int)
nzp [] = (0,0,0)
nzp (h:t) | h < 0 = (1+x,y,z)
          | h == 0 = (x,1+y,z)
          | otherwise = (x,y,1+z)
          where (x,y,z) = nzp t 

--5)
divMods :: Integral a => a -> a -> (a,a)
divMods x y = mods 0 x y

mods :: Integral a => a -> a -> a -> (a,a)
mods acc x y | x >= y = mods (acc+1) (x-y) y 
             | otherwise = (acc,x)


--6)
fromDigits' :: [Int] -> Int
fromDigits' [] = 0
fromDigits' (h:t) = h+10*fromDigits' t

fromDigits :: [Int] -> Int
fromDigits []    = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t




