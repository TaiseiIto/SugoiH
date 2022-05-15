{-# OPTIONS -Wall -Werror #-}

import qualified System.IO

main :: IO ()
main = do
 todoItem <- getLine
 System.IO.appendFile "todo.txt" $ todoItem ++ "\n"

