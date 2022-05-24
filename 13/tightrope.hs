{-# OPTIONS -Wall -Werror #-}

type Birds = Int
type Pole  = (Birds, Birds)

banana :: Pole -> Maybe Pole
banana _ = Nothing

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
 | difference < 4 = Just (nextLeft, nextRight)
 | otherwise      = Nothing
 where
  nextLeft   = left + n
  nextRight  = right
  difference = abs $ nextLeft - nextRight

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
 | difference < 4 = Just (nextLeft, nextRight)
 | otherwise      = Nothing
 where
  nextLeft   = left
  nextRight  = right + n
  difference = abs $ nextLeft - nextRight

main :: IO ()
main = do
 putStrLn . show $ return (0, 0) >>= landRight 2 >>= landLeft 2 >>= landRight 2
 putStrLn . show $ return (0, 0) >>= landLeft 1 >>= landRight 4 >>= landLeft (-1) >>= landRight (-2)
 putStrLn . show $ return (0, 0) >>= landLeft 1 >>= banana >>= landRight 1
 putStrLn . show $ do
  start  <- return (0, 0)
  first  <- landLeft  2 start
  second <- landRight 2 first
  end    <- landLeft  1 second
  return end

