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
action programName ("add" : arguments) = do
 putStrLn . ("Invalid add arguments :" ++) . foldl (\concatenated argument -> concatenated ++ " " ++ argument) "" $ arguments
 printUsage programName
 return ()
action programName ("remove" : arguments) = do
 putStrLn . ("Invalid remove arguments :" ++) . foldl (\concatenated argument -> concatenated ++ " " ++ argument) "" $ arguments
 printUsage programName
 return ()
action programName ("view" : arguments) = do
 putStrLn . ("Invalid view arguments :" ++) . foldl (\concatenated argument -> concatenated ++ " " ++ argument) "" $ arguments
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

