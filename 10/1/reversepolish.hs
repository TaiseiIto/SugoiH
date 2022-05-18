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
 Nul |
 Val Float

instance Read Element where
 readsPrec _ ('+' : remain) = [(Add, remain)]
 readsPrec _ ('-' : remain) = [(Sub, remain)]
 readsPrec _ ('*' : remain) = [(Mul, remain)]
 readsPrec _ ('/' : remain) = [(Div, remain)]
 readsPrec _ ('?' : remain) = [(Nul, remain)]
 readsPrec _ string = case (reads :: String -> [(Float, String)]) string of
  (val, remain) : _ -> [(Val val, remain)]
  _                 -> []

instance Show Element where
 show Add = "+"
 show Sub = "-"
 show Mul = "*"
 show Div = "/"
 show Nul = "?"
 show (Val val) = show val

main :: IO ()
main = do
 args <- System.Environment.getArgs
 putStrLn . show . solve . map (read :: String -> Element) $ args
 return ()

solve :: [Element] -> Element
solve []                = Nul
solve [Val val]         = Val val
solve (element : stack) = solve . step element $ stack

step :: Element -> [Element] -> [Element]
step Add (Val a : Val b : stack) = Val (a + b) : stack
step Sub (Val a : Val b : stack) = Val (a - b) : stack
step Mul (Val a : Val b : stack) = Val (a * b) : stack
step Div (Val a : Val b : stack) = Val (a / b) : stack
step (Val val) stack = Val val : stack
step _ _ = [Nul]

