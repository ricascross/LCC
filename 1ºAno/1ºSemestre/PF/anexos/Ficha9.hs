import System.Random


geraLista :: Int -> [Int] -> IO [Int]
geraLista 0 l = return []
geraLista x [] = return []
geraLista n l = do r <- randomRIO(0,(n-1))
                   let (a,x:b) = splitAt r l
                   xs <- geraLista (n-1) (a++b)
                   return(x:xs)

apresentaResultado :: [Int] -> IO ()
apresentaResultado (h:t) = do {putStrLn "Prima Enter";
                              getChar;
	                          print h;
                              apresentaResultado t}
apresentaResultado [] = return ()


bingo :: IO ()
bingo = do putStrLn "Jogo do Bingo"
           c <- geraLista 90 [1..90]
           apresentaResultado c 


-- euromilhoes
data Aposta = Ap [Int] (Int,Int) 

aposta1 = Ap [12,34,50,23,2] (2,3)
aposta2 = Ap [4,10,20,32,40] (4,8)
aposta3 = Ap [5,32,12,50,23] (3,2)

valida :: Aposta -> Bool
valida (Ap [] _) = False
valida (Ap l (x,y)) = (length l == 5) && (testaNumeros l) && (x >=1) && (x<=12) && (y>=1) && (y<=12) && (y/=x)

testaNumeros :: [Int] -> Bool
testaNumeros [] = True
testaNumeros (h:t) = h>=1 && h<=50 && not(elem h t) &&testaNumeros t

comuns :: Aposta -> Aposta -> (Int,Int)
comuns (Ap l1 e1) (Ap l2 e2) = ((comunsNum 0 l1 l2), (comunsEst e1 e2))

comunsNum :: Int -> [Int] -> [Int] -> Int
comunsNum cont [] [] = cont
comunsNum cont [] l = cont 
comunsNum cont l [] = cont
comunsNum cont (h:t) l | (elem h l) = comunsNum (cont+1) t l 
                       | otherwise = comunsNum cont t l 

comunsEst :: (Int,Int) -> (Int,Int) -> Int 
comunsEst (e1,e2) (e3,e4) | (e1 == e3 && e2 == e4) || (e1 == e4 && e2==e3) = 2 
                          | (e1 /= e3) && (e1 /= e4) && (e2 /= e3) && (e3 /= e4)  = 0
                          | otherwise = 1 

comparar :: Aposta -> Aposta -> Bool
comparar ap1 ap2 | (comuns ap1 ap2 == (0,0)) = False
                 |otherwise = True


instance Eq Aposta where
	(==) = comparar

premio :: Aposta -> Aposta -> Maybe Int
premio ap1 ap2 = case (comuns ap1 ap2) of
	                  (5,2) -> Just 1
	                  (5,1) -> Just 2
	                  (5,0) -> Just 3
	                  (4,2) -> Just 4
	                  (4,1) -> Just 5
	                  (3,2) -> Just 6
	                  (4,0) -> Just 7
	                  (2,2) -> Just 8
	                  (3,1) -> Just 9
	                  (3,0) -> Just 10
	                  (1,2) -> Just 11
	                  (2,1) -> Just 12
	                  (2,0) -> Just 13
	                  _     -> Nothing


leAposta :: IO Aposta 
leAposta = do putStrLn "Introduza a Sua Aposta:\n"
              putStrLn "1º Digite os Números: "
              num <- getLine
              putStrLn "\n2º Digite as Estrelas: "
              est <- getLine
              let ap = Ap (read num) (read est)
              if valida ap then return ap 
              else do putStrLn "\n Erro: Insira uma nova Aposta!\n"
                      leAposta

joga :: Aposta -> IO ()
joga ap = do apostaUt <- leAposta;
             case (premio ap apostaUt) of
             	  Just x -> putStrLn (("\nParabens Voce Ganhou o ")++(show x)++" premio!")
             	  Nothing -> putStrLn ("\nVoce Perdeu! Nao Desista!\n")

geraChave :: IO Aposta
geraChave = do num <- geraNum 5 []
               est <- geraEst 2 []
               return (Ap num est)


geraNum :: Int -> [Int] -> IO [Int]
geraNum 0 l = return l
geraNum n l = do num <- randomRIO(1,50)
                 if (elem num l) then geraNum n l 
                 else geraNum (n-1) (l++[num])

geraEst :: Int -> [Int] -> IO (Int,Int)
geraEst 0 (h:t) = return (h, auxGeraEst t)
geraEst n l = do est <- randomRIO(1,12)
                 if (elem est l) then geraEst n l 
                 else geraEst (n-1) (l++[est])

auxGeraEst :: [Int] -> Int 
auxGeraEst [] = 999
auxGeraEst (h:t) = h

main :: IO ()
main = do ch <- geraChave
          ciclo ch

ciclo :: Aposta -> IO ()
ciclo ap = do opcao <- menu 
              if opcao == "1" then joga ap
              else if opcao == "2" then do {apNew <- geraChave;
           	                              ciclo apNew}
              else if opcao == "0" then putStrLn "Voce saiu do jogo"
              else ciclo ap 
              ciclo ap

menu :: IO String
menu = do { putStrLn menutxt
          ; putStr "Opcao: "
          ; c <- getLine
          ; return c
          }
          where menutxt = unlines ["",
                                   "Apostar ........... 1",
                                   "Gerar nova chave .. 2",
                                   "",
                                   "Sair .............. 0"]
