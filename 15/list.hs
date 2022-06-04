{-# OPTIONS -Wall -Werror #-}

type ListZipper a = ([a], [a])

zipList :: [a] -> ListZipper a
zipList list = (list, [])

goForward :: ListZipper a -> ListZipper a
goForward (x : xs, bs) = (xs, x : bs)
goForward ([],     _)  = error "Error @ goForward"

goBack :: ListZipper a -> ListZipper a
goBack (xs, b : bs) = (b : xs, bs)
goBack (_,      []) = error "Error @ goBack"

main :: IO ()
main = putStrLn . (show :: ListZipper Int -> String) . goBack . goForward . zipList $ [1, 2, 3, 4]

