import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

-- the task is to find minimum of all a's and minimum of all b's and multiply the two

findMins = foldl' (\[min_a, min_b] [a, b] -> [min min_a a, min min_b b]) [maxBound :: Int, maxBound :: Int]

multiply [a, b] = a * b

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let inputs = map readNumbers list
  -- print inputs
  let ans = multiply (findMins inputs)
  print ans
