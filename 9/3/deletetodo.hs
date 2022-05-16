{-# OPTIONS -Wall -Werror #-}

import qualified Control.Exception
import qualified Data.Map
import qualified System.Directory
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
  number = (read :: String -> Int) numberString
  newNumberedTasks = Data.Map.filterWithKey (\key _ -> key /= number) numberedTasks
 Control.Exception.bracketOnError
  (System.IO.openTempFile "." "temp")
  (
   \(tempName, tempFile) -> do
    System.IO.hClose tempFile
    System.Directory.removeFile tempName
  )
  (
   \(tempName, tempFile) -> do
    System.IO.hPutStr tempFile . unlines . map (newNumberedTasks Data.Map.!) . Data.Map.keys $ newNumberedTasks
    System.IO.hClose tempFile
    System.Directory.removeFile "todo.txt"
    System.Directory.renameFile tempName "todo.txt"
  )

