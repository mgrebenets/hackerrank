-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.List
-- import qualified Data.Set as S

-- sample
-- 2 3 4
-- 30 120 210 300

-- another case of misleading description
-- leading into lists or sets and recursive solution
-- which is not effective
-- while actually have to look differently
-- have to look at possible LAST numbers
-- instead of generating all possible sequences

-- combos are
-- aaa
-- aab
-- bba
-- baa
-- the thing is that we only care about number of as and bs
-- but not their order, any order of same number of as and bs produces same result

-- if account for all order permutations thats exactly 2^(n-1) combos
-- easy to see if treating as as 0s and bs as 1s

-- numger of DISTINCT combos in regards to sum is even less
-- it's exactly n, just go from 0...0 to 1..1
-- each time having different no of 0s (and 1s)

-- so it's a list which is
-- [a*n + b*0, a*(n-1) + b*1, a*(n-2) + b*2, ..., a*1 + b*(n-1), a*0 + b*n]
-- that's exactly n elements there and because a < b, all are sorted too
-- well, ok, just saw one test case where those are not sorted
-- so it's up to me to swap a and b if they are not in order

-- as usual all those lists are not effective
-- including grouping and sortin them
-- use more effective implementation or arrays

readTestCase = replicateM 3 getLine
readNumbers xs = map read xs :: [Int]

-- read inputs into a tuple and sort if required
readInputs [n, a, b]
  | a <= b = (n, a, b)
  | otherwise = (n, b, a)

-- count (n, a, b, s)
--   | n <= 1 = [s]
--   | otherwise = count (n - 1, a, b, s + a) ++ count (n - 1, a, b, s + b)

-- count (n, a, b, s)
--   | n <= 1 = S.singleton s
--   | otherwise = count (n - 1, a, b, s + a) `S.union` count (n - 1, a, b, s + b)

-- rmdups = map head . group . sort

-- stones (n, a, b) = rmdups (count (n, a, b, 0))
-- stones (n, a, b) = count (n, a, b, 0)

stones (n, a, b)
  | a == b = [a * (n - 1)]
  | otherwise = [a * (n - i) + b * (i - 1) | i <- [1..n] ]

main :: IO ()
main = do
  t <- readLn :: IO Int
  testCases <- replicateM t readTestCase
  let inputs = map (readInputs . readNumbers) testCases
  -- print inputs
  -- THIS SHIT IS LAZY!!!
  -- just calling this line doesn't mean anything is computed
  -- the execution is delayed until I do print...
  -- so ater all the algorightm and data structure are not optimal
  let ans = map stones inputs
  putStr $ unlines $ map (unwords . map show) ans
