import Data.List
import Data.Char
data Frac = F Integer Integer

mdc :: Integer -> Integer -> Integer
mdc x y | x > y = mdc (x-y) y 
        | x == y = x
        | otherwise = mdc x (y-x) 

normaliza :: Frac -> Frac
normaliza (F 0 0 ) = error "Fracao invalida"
normaliza (F 0 b) = F 0 1
normaliza (F a b) = let d = mdc (abs a) (abs b)
                        s = (signum a) * (signum b)
                    in F (s*(div (abs a) d)) (div (abs b) d)

igual :: Frac -> Frac -> Bool
igual (F a b) (F c d) = a==c && b==d 

instance Eq Frac where
	(==) = igual 

compara :: Frac -> Frac -> Bool
compara (F a b) (F c d) = (a<=c) && (b<=d)

instance Ord Frac where
	(<=) = compara  

instance Show Frac where
	show  (F a b)= "(" ++ (show a) ++ "/" ++ (show b) ++ ")" 

soma :: Frac -> Frac -> Frac
soma (F a b) (F c d) = normaliza(F ((a*d) + (c*b)) (b*d))

mult :: Frac -> Frac -> Frac
mult (F a b) (F c d) = normaliza (F (a*c) (b*d))

sub :: Frac -> Frac -> Frac
sub (F a b) (F c d) = normaliza(F ((a*d) - (c*b)) (b*d))

instance Num Frac where
	(+) f1 f2= soma f1 f2
	(*) f1 f2 = mult f1 f2
	(-) f1 f2 = sub f1 f2
	(negate) (F a b) = F (-a) b
	(abs) (F a b) = normaliza (F (abs a) (abs b))
	(signum) (F a b) | a > 0 = 1
	                 | a == 0 = 0
	                 | otherwise = (-1)
	fromInteger x = F x 1



sel :: Frac -> [Frac] -> [Frac]
sel (F a b) ((F c d):t) | (b == d) && (c >(2*a)) = (F c d):sel (F a b) t
                        | (b /= d) && (c*b > (2*a*d)) = (F c d):sel (F a b) t
                        | otherwise = sel (F a b) t
sel _ [] = [] 

data Exp a = Const a
           | Simetrico (Exp a)
           | Mais (Exp a) (Exp a)
           | Menos (Exp a) (Exp a)
           | Mult (Exp a) (Exp a)

calcula :: (Num a) =>  Exp a -> a
calcula (Const x) = x
calcula (Simetrico x) = - (calcula x)
calcula (Mais a b) = (calcula a) + (calcula b)
calcula (Menos a b) = (calcula a) - (calcula b)
calcula (Mult a b) = (calcula a) * (calcula b) 

infixa :: (Show a) => Exp a -> String
infixa (Const x) = show x
infixa (Simetrico x) = "("++"-"++(infixa x)++")"
infixa (Mais a b) = "("++(infixa a)++ "+" ++(infixa b)++")"
infixa (Menos a b) = "("++(infixa a)++ "-" ++(infixa b)++")"
infixa (Mult a b) = "("++(infixa a)++ "*" ++(infixa b)++")"

instance Show a => Show (Exp a) where
	show = infixa 

comparar :: (Num a, Eq a) => Exp a -> Exp a -> Bool
comparar a b = (calcula a) == (calcula b)

instance (Num a,Eq a) => Eq (Exp a) where
	(==) = comparar 

somar :: Num a => Exp a -> Exp a -> Exp a 
somar a b = Const (calcula a + calcula b)

subtra :: Num a => Exp a -> Exp a -> Exp a 
subtra a b = Const (calcula a - calcula b)

multi :: Num a => Exp a -> Exp a -> Exp a 
multi a b = Const (calcula a * calcula b)

absExp :: Num a => Exp a -> Exp a 
absExp a = Const (abs(calcula a))

negateExp :: Num a => Exp a -> Exp a 
negateExp a = Const (-(calcula a))

signumExp :: Num a => Exp a -> Exp a 
signumExp a  = Const (signum(calcula a))

fromIntegerExp :: Num a => Integer -> Exp a 
fromIntegerExp a = Const (fromInteger a)

instance Num a => Num (Exp a) where
	(+) = somar
	(-) = subtra 
	(*) = multi
	(abs) a = absExp a
	(negate) a = negateExp a
	(signum) a = signumExp a 
	(fromInteger) x = fromIntegerExp x



data Movimento = Credito Float | Debito Float deriving Show
data Data = D Int Int Int 
data Extracto = Ext Float [(Data, String, Movimento)] 

ext = (Ext 2 [((D 1 2 3),"sd", Credito 3),((D 2 3 4),"sdd", Credito 30),((D 1 2 1),"sd", Debito 3)])

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext s []) _ = []
extValor (Ext s ((_,_,Credito x):t)) val | x > val = (Credito x):extValor (Ext s t) val 
                                         | otherwise = extValor (Ext s t) val 
extValor (Ext s ((_,_,Debito x):t)) val | x > val = (Debito x):extValor (Ext s t) val 
                                        | otherwise = extValor (Ext s t) val 

filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro _ [] = []
filtro (Ext s []) _ = []
filtro (Ext s ((date, str, mov):t)) (x:xs) | str == x = (filtroAux (Ext s ((date, str, mov):t)) x)++(filtro (Ext s t) xs)
                                           | otherwise = filtro (Ext s t) xs

filtroAux :: Extracto -> String -> [(Data, Movimento)]
filtroAux (Ext s []) _ = []
filtroAux (Ext s ((date, str, mov):t)) x | x == str = (date,mov):filtroAux  (Ext s t) x
                                         | otherwise = filtroAux  (Ext s t) x

creDeb :: Extracto -> (Float,Float)
creDeb (Ext s l) = ((cred l), (debi l))

cred :: [(Data, String, Movimento)] -> Float
cred [] = 0
cred ((_,_,Credito x):t) = x+ cred t
cred ((_,_,Debito x):t) = cred t

debi :: [(Data, String, Movimento)] -> Float
debi [] = 0
debi ((_,_,Debito x):t) = x + (debi t) 
debi ((_,_,Credito x):t) = debi t

saldo :: Extracto -> Float
saldo (Ext s []) = s 
saldo (Ext s l) = s + credi - debi 
                where (credi, debi) = creDeb (Ext s l)

iguals :: Data -> Data -> Bool
iguals (D a m d) (D y mes dia) = (a == y) && (m == mes) && (d == dia) 

instance Eq Data where
    (==) = iguals                



instance Ord Data where
	compare (D ano1 mes1 dia1) (D ano2 mes2 dia2) | ano1 > ano2 || ano1 == ano2 && (mes1 > mes2 || mes1 == mes2 && dia1 > dia2) = GT
                                                  | ano1 == ano2 && mes1 == mes2 && dia1 == dia2 = EQ
                                                  | otherwise = LT
instance Show Data where
	show (D a m d) = (show a) ++ "/" ++ (show m) ++ "/" ++ (show d)   

ordena :: Extracto -> Extracto 
ordena (Ext s l) = Ext s (sortBy (\(data1,_,_) (data2,_,_) -> compare data1 data2) l)


instance Show Extracto where
	show (Ext n l)= "Saldo anterior: " ++ show n ++
                    "\n---------------------------------------" ++
                    "\nData       Descricao   Credito   Debito" ++
                    "\n---------------------------------------\n" ++ concatMap (\(dat,str,mov) -> show dat ++ replicate (11 - (length (show dat))) ' ' ++ map (toUpper) str  ++ "    \n") l ++
                    "---------------------------------------" ++
                    "\nSaldo actual: " ++ show (saldo (Ext n l))