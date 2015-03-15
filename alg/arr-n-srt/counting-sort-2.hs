import Control.Monad
import Data.Array

readNumbers :: String -> [Int]
readNumbers = map read . words

count input = assocs . accumArray (+) 0 (0, 99) . map (\i -> (i, 1)) $ input

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- getLine
  let input = readNumbers list
  -- after getting the counts, filter only thouse that have count > 0
  -- then map each tuple to an array that replicates 2nd value 1st value number of times
  let lists = map (\(x, y) -> replicate y x) . filter (\(x, y) -> y > 0) $ count input
  -- finally, flatten it up by using concatMap, which first runs map using the id function
  -- and then concats the results into a single list
  -- and id is just identify so it does nothing
  let ans = concatMap id lists
  putStr $ unwords (map show ans)
