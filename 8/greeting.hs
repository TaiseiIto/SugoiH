{-# OPTIONS -Wall -Werror #-}

import Data.Char
import System.IO

main :: IO ()
main = do
 hSetBuffering stdout NoBuffering
 putStr "Your first name : "
 firstName <- getLine
 putStr "Your last name : "
 lastName <- getLine
 let
  bigFirstName = map toUpper firstName
  bigLastName = map toUpper lastName
 putStrLn $ "Hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"

