{-# OPTIONS -Wall -Werror #-}

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
action programName ("remove" : arguments) = do
 putStrLn . invalidArgumentsMessage "remove" $ arguments
 printUsage programName
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
add fileName todo = System.IO.appendFile fileName $ todo ++ "\n"

invalidArgumentsMessage :: String -> [String] -> String
invalidArgumentsMessage command = ("Invalid " ++) . (command ++) . (" arguments :" ++) . foldl (\concatenated argument -> concatenated ++ " " ++ argument) ""

printUsage :: String -> IO ()
printUsage = putStrLn . usage

usage :: String -> String
usage programName = unlines . map (programName ++) $
 [
  " add <file name> <todo>",
  " remove <file name> <todo number>",
  " view <file name>"
 ]

