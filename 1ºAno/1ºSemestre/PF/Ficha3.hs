module Ficha3 where
import Ficha1

--data Horas = H Int Int deriving Show

type Etapa = (Horas,Horas)

type Viagem = [Etapa] 

testaEtapa :: Etapa -> Bool
testaEtapa (x,y) | (horaValida' x) && (horaValida' y) && (comparacaoHora x y) = True
                 | otherwise = False

testaViagem :: Viagem -> Bool
testaViagem [] = True
testaViagem ((x,y):(z,w):t) | testaEtapa (x,y) && testaEtapa (z,w) && (horasToMin y < horasToMin z) = testaViagem t 
                            | otherwise = False

partidaChegada :: Viagem -> Etapa
partidaChegada [] = (H 0 0,H 0 0)
partidaChegada l = (fst (head l), snd (last l))

viagemEfetiva :: Viagem -> Horas 
viagemEfetiva [] = H 0 0
viagemEfetiva l = minToHoras(horasToMin (snd (last l)) - horasToMin (fst (head l))) 

tempoEspera :: Viagem -> Int
tempoEspera [x] = 0
tempoEspera ((x,y):(z,w):t) = (diferenca' y z) + tempoEspera ((z,w):t)


data Contato = Casa Integer | Trab Integer | Tlm Integer | Email String deriving Show

type Nome = String

type Agenda = [(Nome, [Contato])]

acrescEmail :: Nome -> String -> Agenda -> Agenda
acrescEmail x y [] = [(x,[Email y])]
acrescEmail n e ((h,l):t) | n == h = ((h, l++[Email e]):t) 
                          | otherwise =  acrescEmail n e ((h, l):t)

consTelefs :: [Contato] -> [Integer]
consTelefs (Casa x:t) = x:consTelefs t 
consTelefs (Tlm x:t) = x:consTelefs t 
consTelefs (Trab x:t) = x:consTelefs t
consTelefs _ = []

casa :: Nome -> Agenda -> Maybe Integer
casa n ((h, (Casa x):xs):t) | n == h = Just x
                            | otherwise = casa n ((h,(Casa x:xs)):t) 
casa _ _= Nothing


--pergunta4
type Dia = Int
type Mes = Int
type Ano = Int


--data Data = D Dia Mes Ano deriving Show

type TabDN = [(Nome, Data)]

procura :: Nome -> TabDN -> Maybe Data 
procura n ((h,d):t) | n == h = Just d 
                    | otherwise = procura n t 


idade :: Data -> Nome -> TabDN -> Maybe Int
idade _ _ [] = Nothing
idade (D d m a) n ((h,(D di me an)):t) | n == h = Just (a-an)
                                       | otherwise = idade (D d m a) n t 

anterior :: Data -> Data -> Bool
anterior (D d m a) (D di me an) | d<=di && m<=me && a<an = True
                                | d<=di && m<=me && a==an = True
                                | d > di && m <=me && a == an = True
                                | otherwise = False

ordena :: TabDN -> TabDN
ordena [] = []
ordena ((n,(D d m a)):(no,(D di me an)):t) | anterior (D d m a) (D di me an) = (n,(D d m a)):ordena ((no,(D di me an)):t)
                                           | otherwise = (n,(D di me an)):ordena t


--pergunta5
data Movimento = Credito Float | Debito Float deriving Show
 
data Data = D Int Int Int deriving Show

data Extracto = Ext Float [(Data, String, Movimento)] deriving Show

extr = (Ext 2000 [(D 2 2 2, "r", Credito 2),(D 2 2 2, "q", Debito 2),(D 2 2 2, "r", Credito 1)])

extValor :: Extracto -> Float -> [Movimento]
extValor (Ext s []) _ = []
extValor (Ext s ((_,_,Credito x):t)) val | x > val = (Credito x):extValor (Ext s t) val 
                                         | otherwise = extValor (Ext s t) val

extValor (Ext s ((_,_,Debito x):t)) val | x > val = (Debito x):extValor (Ext s t) val 
                                        | otherwise = extValor (Ext s t) val


filtro :: Extracto -> [String] -> [(Data,Movimento)]
filtro (Ext s []) _ = []
filtro (Ext s ((date,str,mov):t)) l | (elem str l) = (date,mov): filtro (Ext s t) l
                                    | otherwise = filtro (Ext s t) l

creDeb :: Extracto -> (Float,Float)
creDeb (Ext x lm) = foldl (\(c,d) (_,_,mov) -> case mov of Credito x -> (c + x, d)
                                                           Debito x -> (c, d + x)) (0,0) lm                              

saldo :: Extracto -> Float
saldo (Ext x lm) = foldl (\acc (_,_,mov) -> case mov of Credito n -> (acc + n)
                                                        Debito n -> (acc - n)) x lm  