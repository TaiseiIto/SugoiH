{-# OPTIONS -Wall -Werror #-}

import qualified Control.Exception
import qualified Data.Map
import qualified System.Directory
import qualified System.Environment
import qualified System.IO

main :: IO ()
main = do
 programName <- System.Environment.getProgName
 commandLineArguments <- System.Environment.getArgs
 action programName commandLineArguments
 return ()

action :: String -> [String] -> IO ()
action programName [] = do
 putStrLn "No command"
 printUsage programName
 return ()
action _ ["add", fileName, todo] = do
 add fileName todo
 return ()
action programName ("add" : arguments) = do
 putStrLn . invalidArgumentsMessage "add" $ arguments
 printUsage programName
 return ()
action _ ["bump", fileName, number] = do
 bump fileName . (read :: String -> Int) $ number
 return ()
action programName ("bump" : arguments) = do
 putStrLn . invalidArgumentsMessage "bump" $ arguments
 printUsage programName
 return()
action _ ["remove", fileName, number] = do
 remove fileName . (read :: String -> Int) $ number
 return ()
action programName ("remove" : arguments) = do
 putStrLn . invalidArgumentsMessage "remove" $ arguments
 printUsage programName
 return ()
action _ ["view", fileName] = do
 view fileName
 return ()
action programName ("view" : arguments) = do
 putStrLn . invalidArgumentsMessage "view" $ arguments
 printUsage programName
 return ()
action programName (command : _) = do
 putStrLn $ "Invalid command : " ++ command
 printUsage programName
 return ()

add :: String -> String -> IO ()
add fileName = System.IO.appendFile fileName . (++ "\n")

bump :: String -> Int -> IO ()
bump fileName number = do
 fileContents <- System.IO.readFile fileName
 let
  numberedTasks = Data.Map.fromList . zip ([0..] :: [Int]) . lines $ fileContents
  newNumberedTasks = Data.Map.foldlWithKey' (\tasks key task -> Data.Map.insert (bumpNewKey number key) task tasks) Data.Map.empty numberedTasks
  newTasks = Data.Map.foldl' (\tasks task -> tasks ++ task ++ "\n") "" newNumberedTasks
 putStrLn newTasks
 return ()

bumpNewKey :: Int -> Int -> Int
bumpNewKey number key
 | key <  number = key + 1
 | key == number = 0
 | otherwise     = key

invalidArgumentsMessage :: String -> [String] -> String
invalidArgumentsMessage command = ("Invalid " ++) . (command ++) . (" arguments :" ++) . foldl (\concatenated argument -> concatenated ++ " " ++ argument) ""

printUsage :: String -> IO ()
printUsage = putStrLn . usage

remove :: String -> Int -> IO ()
remove fileName number = do
 fileContents <- System.IO.readFile fileName
 let
  numberedTasks = Data.Map.fromList . zip ([0..] :: [Int]) . lines $ fileContents
  newNumberedTasks = Data.Map.filterWithKey (\key _ -> key /= number) numberedTasks
  newTasks = Data.Map.foldl' (\tasks task -> tasks ++ task ++ "\n") "" newNumberedTasks
 Control.Exception.bracketOnError
  (System.IO.openTempFile "." "temp")
  (
   \(tempName, tempFile) -> do
    System.IO.hClose tempFile
    System.Directory.removeFile tempName
  )
  (
   \(tempName, tempFile) -> do
    System.IO.hPutStr tempFile newTasks
    System.IO.hClose tempFile
    System.Directory.removeFile fileName
    System.Directory.renameFile tempName fileName
  )
 return ()

usage :: String -> String
usage programName = unlines . map (programName ++) $
 [
  " add <file name> <todo>",
  " remove <file name> <todo number>",
  " view <file name>"
 ]

view :: String -> IO()
view fileName = do
 fileContents <- System.IO.readFile fileName
 let numberedTasks = Data.Map.fromList . zip ([0..] :: [Int]) . lines $ fileContents
 putStrLn . Data.Map.foldlWithKey' (\string key task -> string ++ show key ++ " - " ++ task ++ "\n") "" $ numberedTasks
 return ()

