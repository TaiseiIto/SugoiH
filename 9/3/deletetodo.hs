{-# OPTIONS -Wall -Werror #-}

import qualified Data.Map
import qualified System.IO

main :: IO ()
main = do
 System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering
 contents <- System.IO.readFile "todo.txt"
 let
  todoTasks = lines contents
  numberedTasks = Data.Map.fromList . zip ([0..] :: [Int]) $ todoTasks
 putStrLn "These are your TO-DO items:"
 putStrLn . unlines . map (\key -> show key ++ " - " ++ numberedTasks Data.Map.! key) . Data.Map.keys $ numberedTasks
 putStr "Which one do you want to delete? : "
 numberString <- getLine
 let
  number :: Int = read numberString
  newNumberedTasks = Data.Map.filterWithKey (\key _ -> key /= number) numberedTasks
 putStrLn . unlines . map (\key -> show key ++ " - " ++ newNumberedTasks Data.Map.! key) . Data.Map.keys $ newNumberedTasks

