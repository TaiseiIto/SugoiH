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

heathrowToLondon :: RoadSystem
heathrowToLondon =
 [
  Section 50 10 30,
  Section  5 90 20,
  Section 40  2 25,
  Section 10  8  0
 ]

distance :: Path -> Int
distance = sum . map snd

main :: IO ()
main = do
 putStrLn . show . optimalPath $ heathrowToLondon
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

