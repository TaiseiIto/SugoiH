{-# OPTIONS -Wall -Werror #-}

import qualified System.Random

main :: IO ()
main = do
 gen <- System.Random.getStdGen
 putStrLn . take 20 . System.Random.randomRs ('A', 'Z') $ gen

