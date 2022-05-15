{-# OPTIONS -Wall -Werror #-}

import qualified Data.Map
import qualified System.IO

main :: IO ()
main = do
 contents <- System.IO.readFile "todo.txt"
 let
  todoTasks = lines contents
  numberedTasks = Data.Map.fromList $ zip ([0..] :: [Int]) todoTasks
 putStrLn "These are your TO-DO items:"
 putStrLn . unlines . map (\key -> show key ++ " - " ++ numberedTasks Data.Map.! key) $ Data.Map.keys numberedTasks

