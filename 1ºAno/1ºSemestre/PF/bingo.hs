import System.Random


bingo :: IO ()
bingo = do putStrLn "JOGO DO BINGO"
           l <- geraLista 90 [1..90] 
           apresenta l

apresenta :: [Int] -> IO ()
apresenta (x:xs) = do putStrLn "Prima ENTER"
                      getChar -- so ta aqui para parar a funçao
                      --putStrLn (Show x) é igual a fazer print, o print é 1 putStrLn apos o show
                      print x
                      apresenta xs

apresenta [] = return ()

geraLista :: Int -> [Int] -> IO [Int]
geraLista 0 l  = return  []
geraLista n [] = return []
geraLista n l  = do p <- randomRIO (0,n-1)
                    let (a,x:b) = splitAt p l
                    xs <- geraLista (n-1) (a++b)
                    return (x:xs)


data Aposta = Ap [Int] (Int,Int) deriving Show

type ValorPremio = Int

type Saldo = Int

valorPremio = 20000000


aposta1 = Ap [12,34,50,23,2] (2,3)
aposta2 = Ap [4,10,20,32,40] (4,8)
aposta3 = Ap [5,32,12,50,23] (3,2)


valida :: Aposta -> Bool -- valida tudo
valida (Ap [] _) = False
valida (Ap l (x,y)) = (length l ==5) && (validaNum l) && (x/=y) && (x>=1) && (x<=12) && (y>=1) && (y<=12)  

validaNum :: [Int] -> Bool --valida os numeros da chave
validaNum [] = True
validaNum (x:xs) = x>=1 && x<=50 && not(elem x xs) && validaNum xs

--calcula quantos numeros e quantas estrelas tem em comum
comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap l1 (a,b)) (Ap l2 (c,d)) = ((comunsNum 0 l1 l2), (comunsNum 0 [a,b] [c,d]))


comunsNum :: Int -> [Int] -> [Int] -> Int
comunsNum cont [] [] = cont
comunsNum cont [] l = cont
comunsNum cont l [] = cont
comunsNum cont (x:xs) l | (elem x l) = comunsNum (cont+1) xs l
                        | otherwise = comunsNum cont xs l 

comparar :: Aposta -> Aposta -> Bool
comparar ap1 ap2 | (comuns ap1 ap2) == (0,0) = False
                 | otherwise = True

instance Eq Aposta where
	ap1 == ap2 = comparar ap1 ap2

premio :: Aposta-> Aposta -> Maybe Int
premio chave ap = case (comuns chave ap) of
	                  (5,2) -> Just 1
	                  (5,1) -> Just 2
	                  (5,0) -> Just 3
	                  (4,2) -> Just 4
	                  (4,1) -> Just 5
	                  (4,0) -> Just 6
	                  (3,2) -> Just 8
	                  (3,1) -> Just 9 
	                  (3,0) -> Just 10
	                  (2,2) -> Just 11
	                  (2,1) -> Just 12
	                  (2,0) -> Just 13
	                  _     -> Nothing

leAposta :: IO Aposta
leAposta = do putStrLn "\nDigite aqui sua aposta\n"
              putStrLn "Primeiro os numeros: "
              num <- getLine
              putStrLn "\nDigite agora as estrelas: "
              es <- getLine
              let ap = Ap (read num) (read es)
              if (valida ap) then return ap 
              else  do putStrLn ("\n"++"--------------------"
              	                ++"Erro: Chave Invalida"++"--------------------")
                       leAposta 

intToIO :: Aposta -> Aposta -> IO (Int, Int)
intToIO chave ap = return (comuns chave ap)

joga :: Aposta -> IO ()
joga chave = do ap <- leAposta
                com <- intToIO chave ap
                case (premio chave ap) of
                     Just n -> putStrLn ("\nGanhou, Muitos Parabens!" ++ "\nVoce ganhou o "++(show n) 
                                         ++ "\nAcertaste em :"++(show com))
                     Nothing -> putStrLn ("\nPerdeu! Continua, nao desistas!\n"
                                         ++ "\n" ++ "A tua chave: " ++ (show ap) ++ "\nAcertaste em: " ++ (show com)) 


geraChave :: IO Aposta
geraChave = do num <- (geraNum 5 [])
               es <- (geraEstrelas 2 [])
               return (Ap num es)


geraNum :: Int -> [Int] -> IO [Int]
geraNum 0 l = return l
geraNum n l = do p <- randomRIO(1,50)
                 if (elem p l) 
                 then geraNum n l 
                 else geraNum (n-1) ([p]++l)

geraEstrelas :: Int -> [Int] -> IO (Int,Int)
geraEstrelas 0 (h:t) = return (h,auxGeraEstrelas t)
geraEstrelas n l = do e <- randomRIO(1,12)
                      if (elem e l)
                      then geraEstrelas n l 
                      else geraEstrelas (n-1) ([e]++l)

auxGeraEstrelas :: [Int] -> Int
auxGeraEstrelas [] = 999
auxGeraEstrelas (h:t) = h

 
main :: IO ()
main = do ch <- geraChave
          ciclo ch 

ciclo :: Aposta -> IO ()
ciclo ap = do op <- menu
              if op == "1" then joga ap 
              else if op == "2" then do apos <- geraChave
                                        ciclo apos
              else ciclo ap
              ciclo ap
             


menu :: IO String
menu = do { putStrLn ("---------------\n" ++ "| Euromilhoes |" ++ "\n"++"---------------"++"\n")
          ; putStrLn menutxt
          ; putStr "Opcao: "
          ; c <- getLine
          ; return c
          }
          where menutxt = unlines ["",
                                   "Apostar ..........1",
                                   "Gerar Chave ......2",
                                   "",
                                   "Sair .............0"]

