{-# OPTIONS -Wall -Werror #-}

type Birds = Int
type Pole  = (Birds, Birds)

banana :: Pole -> Either String Pole
banana _ = Left "banana!"

landLeft :: Birds -> Pole -> Either String Pole
landLeft n (left, right)
 | difference < 4 = Right (nextLeft, nextRight)
 | otherwise      = Left $ "left = " ++ show left ++ ", right = " ++ show right ++ ", fell down."
 where
  nextLeft   = left + n
  nextRight  = right
  difference = abs $ nextLeft - nextRight

landRight :: Birds -> Pole -> Either String Pole
landRight n (left, right)
 | difference < 4 = Right (nextLeft, nextRight)
 | otherwise      = Left $ "left = " ++ show left ++ ", right = " ++ show right ++ ", fell down."
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
 putStrLn . show $ do
  start  <- return (0, 0)
  first  <- landLeft  2 start
  _      <- Left "fell down deliberately."
  second <- landRight 2 first
  end    <- landLeft  1 second
  return end

