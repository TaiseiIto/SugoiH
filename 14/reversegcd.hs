{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad.Writer

newtype DiffList a = DiffList
 {
  getDiffList :: [a] -> [a]
 }

toDiffList :: [a] -> DiffList a
toDiffList = DiffList . (++)

fromDiffList :: DiffList a -> [a]
fromDiffList = ($ []) . getDiffList

instance Semigroup (DiffList a) where
 (<>) = (DiffList .) . (. getDiffList) . (.) . getDiffList

instance Monoid (DiffList a) where
 mempty  = DiffList id

gcd' :: Int -> Int -> Control.Monad.Writer.Writer (DiffList String) Int
gcd' a b
 | b == 0    = do
  Control.Monad.Writer.tell . toDiffList $ ["Finished with" ++ show a]
  return a
 | otherwise = do
  result <- gcd' b $ a `mod` b
  Control.Monad.Writer.tell . toDiffList $ [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
  return result

printgcd :: Int -> Int -> IO ()
printgcd a b = let
  (result, calcLog) = Control.Monad.Writer.runWriter . gcd' a $ b
 in do
  putStrLn $ "gcd(" ++ show a ++ "," ++ show b ++ ") = " ++ show result
  mapM_ putStrLn . fromDiffList $ calcLog

main :: IO ()
main = printgcd 8 3

