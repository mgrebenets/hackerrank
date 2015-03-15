import Control.Monad
import Data.Array

-- need to work with arrays for this one, not lists
-- then reduce (fold) initial array using array of 0s as accumulator
-- when reducing x do acc[x]++ and go on

readNumbers :: String -> [Int]
readNumbers = map read . words

-- find out what the fuck this line does in detail
-- so I assume that assocs . accumArray is function composition
-- and it is then applied to arguments

-- accumArray
-- (+) is accumulating function
-- 0 is initial value
-- (0, 99) is bounds of the array
-- it also needs association list though...

-- ok, so assocs is an aliast to toAscList and returns all key/value pairs
-- in ascending key order, so assocs gets combined with accumArray
-- but accumArray is missing its last arument which is association list
-- so since it's missing last argument, it is a curried function then
-- then assocs . accumArray ... gets combined with map(\i -> (i, 1))
-- so the functions should be applied from right to left to `intput`
-- first the map is applied
-- and it takes input, which is the original array
-- and maps each `i` to a (`i`, 1) tuple, thus counting each number once
-- so that's clear now, map is preparing foundation for later accumulation
-- next accumulation kicks in and constructs an array from list of associatinos
-- also doing the + operation for same indeces along the way
-- finaly, assocs converts it to ascending list by the keys
count input = assocs . accumArray (+) 0 (0, 99) . map (\i -> (i, 1)) $ input

main :: IO ()
main = do
  n <- readLn :: IO Int
  list <- getLine
  let input = readNumbers list

  -- \(i, j) -> i is same as fst
  -- \(i, j) -> j is same as snd
  let ans = map snd $ count input

  -- map show ans will apply show to each element, that actually results into a list of strings
  -- [0, 1, 1] --> ["0", "2", "1"]
  -- so next string is to unword that stuff, which turns it from a list of words (or strings)
  -- to a string of words separated by spaces
  -- finally, using putStr will drop the quotes to produce expected output
  putStr $ unwords (map show ans)
