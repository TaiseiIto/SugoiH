{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = do
 todoItems <- System.IO.readFile "todo.txt"
 putStrLn todoItems

