{-# OPTIONS -Wall -Werror #-}

import qualified Data.Char
import qualified System.IO

main :: IO ()
main = do
 System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering
 putStr "Your first name : "
 firstName <- getLine
 putStr "Your last name : "
 lastName <- getLine
 let
  bigFirstName = map Data.Char.toUpper firstName
  bigLastName = map Data.Char.toUpper lastName
 putStrLn $ "Hey " ++ bigFirstName ++ " " ++ bigLastName ++ ", how are you?"

