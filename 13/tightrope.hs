{-# OPTIONS -Wall -Werror #-}

type Birds = Int
type Pole  = (Birds, Birds)

landLeft :: Birds -> Pole -> Pole
landLeft n (left, right) = (left + n, right)

landRight :: Birds -> Pole -> Pole
landRight n (left, right) = (left, right + n)

main :: IO ()
main = do
 putStrLn . show . landLeft 2 $ (0, 0)
 putStrLn . show . landRight 1 $ (1, 2)
 putStrLn . show . landRight (-1) $ (1, 2)

