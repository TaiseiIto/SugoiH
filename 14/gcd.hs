{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad.Writer

gcd' :: Int -> Int -> Control.Monad.Writer.Writer [String] Int
gcd' a b
 | b == 0    = do
  Control.Monad.Writer.tell ["Finished with " ++ show a]
  return a
 | otherwise = do
  Control.Monad.Writer.tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
  gcd' b $ a `mod` b

printgcd :: Int -> Int -> IO ()
printgcd a b = let
  (result, calcLog) = Control.Monad.Writer.runWriter . gcd' a $ b
 in do
  putStrLn $ "gcd(" ++ show a ++ "," ++ show b ++ ") = " ++ show result
  mapM_ putStrLn calcLog

main :: IO ()
main = printgcd 8 3

