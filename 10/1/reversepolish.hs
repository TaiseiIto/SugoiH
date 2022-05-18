{-# OPTIONS -Wall -Werror #-}

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
 putStrLn . show . map (read :: String -> Element) $ args
 return ()

