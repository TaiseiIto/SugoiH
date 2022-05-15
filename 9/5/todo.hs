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
 putStrLn . usage $ programName
 return ()
action _ ("add" : _) = do
 putStrLn $ "add"
 return ()
action _ ("remove" : _) = do
 putStrLn $ "remove"
 return ()
action _ ("view" : _) = do
 putStrLn $ "view"
 return ()
action _ (command : _) = do
 putStrLn $ "Invalid command : " ++ command
 return ()

usage :: String -> String
usage programName = unlines . map (programName ++) $ [" add <file name> <todo>", " remove <file name> <todo number>", " view <file name>"]

