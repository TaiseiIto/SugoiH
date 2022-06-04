{-# OPTIONS -Wall -Werror #-}

type ListZipper a = ([a], [a])

zipList :: [a] -> ListZipper a
zipList list = (list, [])

goForward :: ListZipper a -> Maybe (ListZipper a)
goForward (x : xs, bs) = Just (xs, x : bs)
goForward ([],     _)  = Nothing

goBack :: ListZipper a -> Maybe (ListZipper a)
goBack (xs, b : bs) = Just (b : xs, bs)
goBack (_,      []) = Nothing

unJust :: Maybe (ListZipper a) -> ListZipper a
unJust (Just z) = z
unJust Nothing  = ([], [])

main :: IO ()
main = putStrLn . show . unJust $ do
 pos <- goForward . zipList $ ([1, 2, 3, 4] :: [Int])
 goBack pos

