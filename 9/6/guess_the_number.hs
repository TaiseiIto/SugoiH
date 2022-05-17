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
  [_] -> do
   askForNumbers . (System.Random.randomRs :: (Int, Int) -> System.Random.StdGen -> [Int]) (-10000, 10000) $ randGen
  _ -> printUsage
 return ()

askForNumbers :: [Int] -> IO ()
askForNumbers [] = return ()
askForNumbers (number : _) = do
 putStrLn . show $ number
 return ()

printUsage :: IO ()
printUsage = do
 progName <- System.Environment.getProgName
 putStrLn "Usage"
 putStrLn . ("$ " ++) . (progName ++) $ "<max absolute number>"

