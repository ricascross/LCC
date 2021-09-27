module Ficha1 where
--pertgunta 1
--a)

perimetro :: Double -> Double
perimetro r = 2*pi*r

--b)

dist :: (Double,Double) -> (Double,Double) -> Double
dist (x1,y1) (x2,y2) = sqrt((x2-x1)^2 + (y2-y1)^2)

--c)

primUlt :: [a] -> (a,a)
primUlt l = (head l, last l)

--d)

multiplo :: Int -> Int -> Bool 
multiplo m n = if mod m n == 0 then True else False

--e)
truncaImpar :: [a] -> [a]
truncaImpar l = if mod (length l) 2 /= 0 then tail l else l 

--f)
max2 :: Int -> Int -> Int
max2 a b = if a>b then a else b

--g)

max3 :: Int -> Int -> Int -> Int
max3 a b c = if c > max2 a b then c else max2 a b


--pergunta2
--a)
nRaizes :: Double -> Double -> Double -> Int
nRaizes a b c | b^2 -4*a*c > 0 = 2
              | b^2 -4*a*c < 0 = 1
              | otherwise = 0



--pergunta 3
type Hora = (Int,Int)


--a
horaValida :: Hora -> Bool 
horaValida (h,m) | (h >= 0 && m>=0 && h <= 23 && m <=59) = True
                 | otherwise = False

--b)
comparacao :: Hora -> Hora -> Bool
comparacao (h,m) (horas,min) | horaValida (h,m) && horaValida (horas,min) && horas > h = True
                             | horaValida (h,m) && horaValida (horas,min) && horas == h && min> m = True
                             | otherwise =  False

--c)
horasToMinutos :: Hora -> Int
horasToMinutos (h,m) = if horaValida (h,m)  == True then h*60+m else 0

--d)
minutosToHoras :: Int -> Hora
minutosToHoras min = (div min 60, mod min 60)

--e)

diferenca :: Hora -> Hora -> Int
diferenca (h,m) (horas,min) = if horaValida (h,m) && horaValida (horas,min) == True 
                              then horasToMinutos(horas,min)-horasToMinutos(h,m)
                              else 0

--f)

adicionarMin :: Hora -> Int -> Hora
adicionarMin (h,m) min = if horaValida (h,m) == True
                         then minutosToHoras(horasToMinutos(h,m)+min)
                         else (0,0)


--pergunta4
data Horas = H Int Int deriving (Show,Eq)

--a)

horaValida' :: Horas -> Bool
horaValida' (H h m) = if h >=0 && m>=0 && h<=23 && m<=59 
                    then True
                    else False  
--b)
comparacaoHora :: Horas -> Horas -> Bool
comparacaoHora (H h m) (H horas min) | horaValida'(H h m) && horaValida' (H horas min) && horas > h = True
                                     | horaValida' (H h m) && horaValida' (H horas min) && horas == h && min > m = True
                                     | otherwise = False
                                 
--c)
horasToMin :: Horas -> Int
horasToMin (H h m) | horaValida' (H h m) = h*60 + m
                   | otherwise = -1

--d)
minToHoras :: Int -> Horas
minToHoras min = H (div min 60) (mod min 60)

--e)

diferenca' :: Horas -> Horas -> Int
diferenca' (H h m) (H horas min) | horaValida' (H h m) && horaValida' (H horas min) = horas*60+min - h*60+m
                                 | otherwise = -99999999999

--f)

adicionaMin :: Horas -> Int -> Horas
adicionaMin (H h m) min | horaValida' (H h m) = minToHoras(horasToMin(H h m)+min)
                        | otherwise = H (-999) (-999)


-- pergunta5
data Semaforo = Verde | Amarelo | Vermelho deriving (Show, Eq)

next :: Semaforo -> Semaforo
next x | x== Verde = Amarelo
       | x==Amarelo = Vermelho
       |otherwise = Verde


--b)
stop :: Semaforo -> Bool
stop x | x == Verde = False
       | otherwise = True

--c)

safe :: Semaforo -> Semaforo -> Bool
safe semaforo_1 semaforo_2 | semaforo_1 == Verde && semaforo_2 == Vermelho = True
                           | semaforo_2 == Verde && semaforo_1 == Vermelho = True
                           | otherwise = False

-- pergunta6
data Ponto = Cartesiano Double Double | Polar Double Double deriving (Show, Eq)


--pergunta7

data Figura = Circulo Ponto Double | Retangulo Ponto Ponto | Triangulo Ponto Ponto Ponto deriving (Show, Eq)

--a)

