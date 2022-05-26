{-# OPTIONS -Wall -Werror #-}

newtype DiffList a = DiffList
 {
  getDiffList :: [a] -> [a]
 }

toDiffList :: [a] -> DiffList a
toDiffList = DiffList . (++)

fromDiffList :: DiffList a -> [a]
fromDiffList = ($ []) . getDiffList

instance Semigroup (DiffList a) where
 x <> y = (DiffList .) ((. getDiffList) (getDiffList x .) ) $ y

instance Monoid (DiffList a) where
 mempty  = DiffList id

main :: IO ()
main = putStrLn . show . fromDiffList $ toDiffList ([1,2,3,4] :: [Int]) `mappend` toDiffList ([1,2,3] :: [Int])

