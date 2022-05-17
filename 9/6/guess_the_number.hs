{-# OPTIONS -Wall -Werror #-}

-- Usage
-- $ ./guess_the_number <max absolute number>

import qualified System.Environment
import qualified System.Random

main :: IO ()
main = do
 args <- System.Environment.getArgs
 randGen <- System.Random.getStdGen
 case args of
  [arg] -> case (reads :: String -> [(Int, String)]) arg of
   [(maxAbs, _)] -> askForNumbers . (System.Random.randomRs :: (Int, Int) -> System.Random.StdGen -> [Int]) (-maxAbs, maxAbs) $ randGen
   _             -> cantParse arg
  _     -> printUsage
 return ()

askForNumbers :: [Int] -> IO ()
askForNumbers [] = return ()
askForNumbers (number : futureNumbers) = do
 putStrLn "Guess the number."
 input <- getLine
 case input of
  "" -> return ()
  _  -> case (reads :: String -> [(Int, String)]) input of
   [(guessedNumber, _)]
     | number <  guessedNumber -> do
      putStrLn . ("Less than " ++) . show $ guessedNumber
      askForNumbers (number : futureNumbers)
     | number == guessedNumber -> do
      putStrLn "Correct!"
      askForNumbers futureNumbers
     | guessedNumber < number  -> do
      putStrLn . ("Greater than " ++) . show $ guessedNumber
      askForNumbers (number : futureNumbers)
   _                    -> do
    cantParse input
    askForNumbers (number : futureNumbers)
 return ()

cantParse :: String -> IO ()
cantParse string = putStrLn . ("Can't parse " ++) . (string ++) $ " as Int."

printUsage :: IO ()
printUsage = do
 progName <- System.Environment.getProgName
 putStrLn "Usage"
 putStrLn . ("$ " ++) . (progName ++) $ "<max absolute number>"

