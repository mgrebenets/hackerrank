-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.List
import qualified Data.Set as S

-- sample
-- 2 3 4
-- 30 120 210 300

-- as usual all those lists are not effective
-- including grouping and sortin them
-- use more effective implementation or arrays

readTestCase = replicateM 3 getLine
readNumbers xs = map read xs :: [Int]
readInputs [n, a, b] = (n, a, b)

-- count (n, a, b, s)
--   | n <= 1 = [s]
--   | otherwise = count (n - 1, a, b, s + a) ++ count (n - 1, a, b, s + b)

count (n, a, b, s)
  | n <= 1 = S.singleton s
  | otherwise = count (n - 1, a, b, s + a) `S.union` count (n - 1, a, b, s + b)

-- rmdups = map head . group . sort

-- stones (n, a, b) = rmdups (count (n, a, b, 0))
stones (n, a, b) = count (n, a, b, 0)

-- instance Show a => Show (S.Set a) where
--   show = go
--     where
--       go EmptySet = ""
--       go (S.Insert x S.EmptySet) = show x
--       go (S.Insert x xs) = show x ++ " " ++ go xs

main :: IO ()
main = do
  t <- readLn :: IO Int
  testCases <- replicateM t readTestCase
  let inputs = map (readInputs . readNumbers) testCases
  let ans = map stones inputs
  let ansList = map S.toList ans
  -- TODO: the code below takes way too much time!!!!
  -- TODO: find a fast way to print contents of list of sets
  -- S.map show ansList
  putStr $ unlines $ map (unwords . map show) ansList
