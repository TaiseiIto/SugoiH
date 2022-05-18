{-# OPTIONS -Wall -Werror #-}

-- Usage
-- $ ./reversepolish 1 2 \* 3 4 \* + 5 /
-- 2.8

import qualified System.Environment

data Element = 
 Add |
 Sub |
 Mul |
 Div |
 Val Float

instance Read Element where
 readsPrec _ ('+' : remain) = [(Add, remain)]
 readsPrec _ ('-' : remain) = [(Sub, remain)]
 readsPrec _ ('*' : remain) = [(Mul, remain)]
 readsPrec _ ('/' : remain) = [(Div, remain)]
 readsPrec _ string = case (reads :: String -> [(Float, String)]) string of
  (val, remain) : _ -> [(Val val, remain)]
  _                 -> []

instance Show Element where
 show Add = "+"
 show Sub = "-"
 show Mul = "*"
 show Div = "/"
 show (Val val) = show val

main :: IO ()
main = do
 args <- System.Environment.getArgs
 putStrLn . show . solve . map (read :: String -> Element) $ args
 return ()

solve :: [Element] -> Element
solve = head . foldl step []

step :: [Element] -> Element -> [Element]
step (Val a : Val b : stack) Add = Val (a + b) : stack
step (Val a : Val b : stack) Sub = Val (a - b) : stack
step (Val a : Val b : stack) Mul = Val (a * b) : stack
step (Val a : Val b : stack) Div = Val (a / b) : stack
step stack (Val val) = Val val : stack
step _ _ = []

