data Ltree a = Tip a | Fork (Ltree a) (Ltree a)

instance (Show a) => Show (Ltree a) where
	show  = prof 

prof :: (Show a) =>  Ltree a -> String
prof  (Tip x) = "." ++(show x) 
prof  (Fork t1 t2) = "."++(prof t1) ++(prof t2)

