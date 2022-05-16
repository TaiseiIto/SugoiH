{-# OPTIONS -Wall -Werror #-}

import qualified Data.Char

main :: IO ()
main = do
 contents <- getContents
 putStr $ map Data.Char.toUpper contents

