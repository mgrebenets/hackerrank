import Control.Monad
import Data.Array

-- convert element string into a tuple of int and string values
readElement e = (n, s)
  where
    arr = words e
    n = read (head arr) :: Int
    s = last arr

count :: [(Int, String)] -> [(Int, Int)]
count input = assocs . accumArray (+) 0 (0, 99) . map (\(i, s) -> (i, 1)) $ input

-- conv :: [(Int, Int)] -> [Int]
-- conv counts = assocs . accumArray (+) 0 (0, 99) . map (\(i, c) -> (i, c)) $ counts

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- replicateM n getLine
  let input = map readElement list
  print input
  let counts = count input
  print counts

  -- now have to process counts properly
  -- have to do another accum array here
  -- let ans = conv counts
  -- print ans

  -- after getting the counts, filter only thouse that have count > 0
  -- then map each tuple to an array that replicates 2nd value 1st value number of times
  -- let lists = map (\(x, y) -> replicate y x) . filter (\(x, y) -> y > 0) $ count input
  -- finally, flatten it up by using concatMap, which first runs map using the id function
  -- and then concats the results into a single list
  -- and id is just identify so it does nothing
  -- let ans = concatMap id lists
  -- putStr $ unwords (map show ans)
