module Ficha8 where
import Data.List
import Data.Char


data Frac = F Integer Integer 

--a)

mdc :: Integer -> Integer -> Integer
mdc a b | a==b = a
        | a>b = mdc (a-b) b 
        | a<b = mdc a (b-a)

normaliza :: Frac -> Frac
normaliza (F a 0) = error "fracao invalida"
normaliza (F 0 b) = F 0 1
normaliza (F a b) = let d = mdc (abs a) (abs b)
                        s = (signum a)*(signum b)
                    in F (s * (div (abs a) d)) (div (abs b) d)


comparaIgual ::  Frac -> Frac -> Bool
comparaIgual (F a1 b1) (F a2 b2) = (a1 == a2) && (b1 == b2)

instance Eq Frac where
	(==) = comparaIgual
	--(/=) = not(comparaIgual)

instance Ord Frac where
	x <= y = let F a1 b1 = normaliza x
	             F a2 b2 = normaliza y
	         in a1*b2 <= a2*b1 

instance Show Frac where
	show (F a b) = "(" ++ (show a) ++ "/" ++ (show b)  ++ ")"



instance Num Frac where
	(+) (F a b) (F c d) = normaliza (F (a*d + b*c) (b*d))
	(-) (F a b) (F c d) = normaliza (F (a*d - b*c) (b*d))
	(*) (F a b) (F c d) = normaliza (F (a*c) (b*d))
	(negate) (F a b) = F (negate a) b
	(abs) (F a b) = F (abs a) (abs b)
	(fromInteger) n = F n 1
	(signum) (F a b) | a == 0 = 0
	                 | a > 0 = 1
	                 | otherwise = (-1)

sel :: Frac -> [Frac] -> [Frac]
sel a (h:t) = if h > 2*a then h : sel a t
                         else sel a t
sel a [] = []

data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Simetrico x) = - (calcula x)
calcula (Mais a b) = (calcula a) + (calcula b)
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b) 

infixa :: Show a => Exp a -> String
infixa (Const x) = show x
infixa (Simetrico x) = "("++"-"++(infixa x)++")"
infixa (Mais a b) = "("++(infixa a)++ "+" ++(infixa b)++")"
infixa (Menos a b) = "("++(infixa a)++ "-" ++(infixa b)++")"
infixa (Mult a b) = "("++(infixa a)++ "*" ++(infixa b)++")"
	
instance Show a => Show (Exp a) where
	show = infixa

compara :: (Num a, Eq a) => Exp a -> Exp a -> Bool
compara a b = (calcula a) == (calcula b)

instance (Num a, Eq a) => Eq (Exp a) where
	(==) = compara 

somaExp :: Num a => Exp a -> Exp a -> Exp a
somaExp a b = Const (calcula a + calcula b)

subExp :: Num a => Exp a -> Exp a -> Exp a
subExp a b = Const (calcula a - calcula b)

multExp :: Num a => Exp a -> Exp a -> Exp a
multExp a b = Const (calcula a * calcula b)

negExp :: Num a => Exp a -> Exp a 
negExp a = Const (-(calcula a))

absExp :: Num a => Exp a -> Exp a 
absExp a =  Const (abs (calcula a))

fromIntegerExp :: Num a => Integer -> Exp a 
fromIntegerExp a = Const (fromInteger a)

signumExp :: Num a => Exp a -> Exp a
signumExp a = Const (signum (calcula a))



instance Num a => Num (Exp a) where
	(+) = somaExp 
	(-) = subExp
	(*) = multExp
	(negate) a = negExp a
	(abs) a = absExp a
	(fromInteger) a = fromIntegerExp a
	(signum) a = signumExp a




--banco

data Movimento = Credito Float | Debito Float
data Data = D Int Int Int deriving Eq
data Extracto = Ext Float [(Data, String, Movimento)]

extr = (Ext 2000 [(D 2 2 2, "r", Credito 2),(D 2 2 2, "q", Debito 2),(D 2 2 2, "r", Credito 1)])

instance Ord Data where
    compare (D dia1 mes1 ano1) (D dia2 mes2 ano2) | ano1 > ano2 || ano1 == ano2 && (mes1 > mes2 || mes1 == mes2 && dia1 > dia2) = GT
                                                  | ano1 == ano2 && mes1 == mes2 && dia1 == dia2 = EQ
                                                  | otherwise = LT

instance Show Data where 
    show (D dia mes ano) = concat $ intersperse "/" $ map (show) [dia,mes,ano]

ordena :: Extracto -> Extracto
ordena (Ext n l) = (Ext n (sortBy (\(data1,_,_) (data2,_,_) -> compare data1 data2) l))

instance Show Extracto where
    show (Ext n l) = "Saldo anterior: " ++ show n ++ 
                     "\n---------------------------------------" ++
                     "\nData       Descricao   Credito   Debito" ++
                     "\n---------------------------------------\n" ++ concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str ++ "    \n") l ++
                     "---------------------------------------" ++
                     "\nSaldo actual: " ++ show (saldo (Ext n l))

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm

