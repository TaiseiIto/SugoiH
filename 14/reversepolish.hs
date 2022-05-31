{-# OPTIONS -Wall -Werror #-}

-- Usage
-- $ ./reversepolish 1 2 \* 3 4 \* + 5 /
-- Just 2.8

import qualified Control.Monad
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
 putStrLn . show . solve . map (readMaybe :: String -> Maybe Element) $ args
 return ()

readMaybe :: Read a => String -> Maybe a
readMaybe string = case reads string of
 [(x, "")] -> Just x
 _         -> Nothing

solve :: [Maybe Element] -> Maybe Element
solve elements = do
 [result] <- Control.Monad.foldM step [] elements
 return result

step :: [Element] -> Maybe Element -> Maybe [Element]
step (Val a : Val b : stack) (Just Add) = return $ Val (b + a) : stack
step (Val a : Val b : stack) (Just Sub) = return $ Val (b - a) : stack
step (Val a : Val b : stack) (Just Mul) = return $ Val (b * a) : stack
step (Val a : Val b : stack) (Just Div) = return $ Val (b / a) : stack
step stack (Just (Val val)) = return $ Val val : stack
step _ _ = Nothing

