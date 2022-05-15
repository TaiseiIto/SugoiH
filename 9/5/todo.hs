{-# OPTIONS -Wall -Werror #-}

import qualified System.Environment

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
action programName ("add" : _) = do
 putStrLn $ "add"
 printUsage programName
 return ()
action programName ("remove" : _) = do
 putStrLn $ "remove"
 printUsage programName
 return ()
action programName ("view" : _) = do
 putStrLn $ "view"
 printUsage programName
 return ()
action programName (command : _) = do
 putStrLn $ "Invalid command : " ++ command
 printUsage programName
 return ()

printUsage :: String -> IO ()
printUsage = putStrLn . usage

usage :: String -> String
usage programName = unlines . map (programName ++) $
 [
  " add <file name> <todo>",
  " remove <file name> <todo number>",
  " view <file name>"
 ]

