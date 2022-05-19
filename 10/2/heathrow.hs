{-# OPTIONS -Wall -Werror #-}

data Label = A | B | C deriving (Show)

data Section = Section
 {
  getA :: Int,
  getB :: Int,
  getC :: Int
 } deriving (Show)

type Path       = [(Label, Int)]
type RoadSystem = [Section]

distance :: Path -> Int
distance = sum . map snd

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _  = undefined
groupsOf _ [] = []
groupsOf n xs = ((take n xs) :) . groupsOf n . drop n $ xs

main :: IO ()
main = do
 contents <- getContents
 let
  threes     = groupsOf 3 . map read . lines $ contents
  roadSystem = map (\[a, b, c] -> Section a b c) threes
  path       = optimalPath roadSystem
  pathString = concat . map (show . fst) $ path
  pathTime   = sum . map snd $ path
 putStrLn . ("The best path to take is : " ++) $ pathString
 putStrLn . ("Time taken : " ++) . show $ pathTime
 return ()

optimalPath :: RoadSystem -> Path
optimalPath roadSystem = reverse $ let
 (bestAPath, bestBPath) = foldl roadStep ([], []) roadSystem
 in if distance bestAPath <= distance bestBPath
  then bestAPath
  else bestBPath

roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) = let
 timeA          = distance pathA
 timeB          = distance pathB
 forwardTimeToA = timeA + a
 crossTimeToA   = timeB + b + c
 forwardTimeToB = timeB + b
 crossTimeToB   = timeA + a + c
 newPathToA
  | forwardTimeToA <= crossTimeToA = (A, a) : pathA
  | otherwise                      = (C, c) : (B, b) : pathB
 newPathToB
  | forwardTimeToB <= crossTimeToB = (B, b) : pathB
  | otherwise                      = (C, c) : (A, a) : pathA
 in (newPathToA, newPathToB)

