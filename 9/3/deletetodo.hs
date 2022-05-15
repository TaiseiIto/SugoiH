{-# OPTIONS -Wall -Werror #-}

import qualified Data.Map
import qualified System.IO

main :: IO ()
main = do
 contents <- System.IO.readFile "todo.txt"
 let
  todoTasks = lines contents
  numberedTasks = Data.Map.fromList $ zip ([0..] :: [Int]) todoTasks
 print numberedTasks

