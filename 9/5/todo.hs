{-# OPTIONS -Wall -Werror #-}

import qualified Data.Map
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
 System.IO.writeFile fileName newTasks
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

