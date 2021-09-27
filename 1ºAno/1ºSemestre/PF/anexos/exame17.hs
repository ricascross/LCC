import Data.Char

(!!!) :: [a] -> Int -> a
(!!!) [x] 0 = x
(!!!) (h:t) n | n > 0 = (!!!) t (n-1)
              | otherwise = h

data Movimento = Norte | Sul | Este | Oeste deriving Show

posicao :: (Int,Int) -> [Movimento] -> (Int,Int)
posicao (x,y) (Norte:t) = posicao (x,y+1) t
posicao (x,y) (Sul:t) = posicao (x,y-1) t
posicao (x,y) (Este:t) = posicao (x+1,y) t
posicao (x,y) (Oeste:t) = posicao (x-1,y) t
posicao (x,y) [] = (x,y)

type Mat a = [[a]]

triSup :: (Eq a,Num a) => Mat a -> Bool
triSup [] = False
triSup l = triSupAux 0 l

triSupAux :: (Eq a,Num a) => Int -> Mat a -> Bool
triSupAux x [] = True
triSupAux x (h:ts) = if ((length (fst (span (==0) h))) >= x) then triSupAux (x + 1) ts else False



apresenta :: IO ()
apresenta = do pos <- movimenta
               putStrLn ("\nPosicao Final: " ++ (show pos))

movimenta :: IO (Int,Int)
movimenta = do pos <- posicao' (0,0)
               return pos

posicao' :: (Int,Int) -> IO (Int,Int)
posicao' (x,y) = do opcao <- text
                    case (toUpper opcao) of 
           	             'N' -> posicao' (x,y+1)
          	             'S' -> posicao' (x,y-1)
          	             'E' -> posicao' (x+1,y)
          	             'O' -> posicao' (x-1,y)
          	             '0' -> return (x,y)
          	             ' ' -> posicao' (x,y)

text ::  IO Char
text = do putStrLn menutext
          putStrLn "Opcao: "
          opcao <- getChar
          return opcao
          where menutext = unlines ["\nNorte ..... N",
                                    "Sul ....... S",
                                    "Este ...... E",
                                    "Oeste ..... O",
                                    "\n",
                                    "Sair ...... 0"]


data Imagem = Quadrado Int | Mover (Int,Int) Imagem | Juntar [Imagem]



                
          	         
                  
