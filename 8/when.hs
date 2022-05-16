{-# OPTIONS -Wall -Werror #-}

import qualified Control.Monad

main :: IO ()
main = do
 input <- getLine
 Control.Monad.when (input == "SWORDFISH") $ putStrLn input

