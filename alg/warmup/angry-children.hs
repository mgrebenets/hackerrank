-- Enter your code here. Read input from STDIN. Print output to STDOUT
import Control.Monad
import Data.List
import Data.Array
--import Data.Sequence (unstableSort, fromList)
--import Data.Foldable (toList)


-- sort, take all consequent slices of k elements (from start to end) and compute unfairness (max - min)
-- then take min of those unfainesses

-- takeaway: couldn't move (take k (drop d list)) part into |... part
-- like so unfairness slice | d <- [...], slice <- (take k (drop d list))
-- somehow slice would come out as Int, not [Int] !

-- performance: sorting doesn't seem to be an issue
-- problem is with taking multiple slices (take + drop)
-- must find a way to compute range without generating new arrays

-- takeaway: performance: expensive to split lists, try using indexes instead

-- another takeaway: sort is not an issue
-- the problem is minimum [...]
-- meaning there's yet another list allocated to hold the minimums...
-- and then there's O(1)? to find minimum...
-- could it be reduced in a way

--unfairness :: [Int] -> Int
--unfairness slice = maximum slice - minimum slice


--slice xs s k = take k . drop s $ xs
--slice xs s k = take k $ drop s xs
--slice :: Int -> Int -> [Int]-> [Int]
--slice xs s k = take k (drop s xs)

foldMin :: ([Int], Int, Int, Int) -> Int
foldMin (list, s, k, m) = if s >= k - 1
  then foldMin(list, s - 1, k, minimum [list!!s - list!!(s - k + 1), m]) else m

foldMin2 (list, s, k, m )
  | s >= k - 1 = foldMin2(list, s - 1, k, min2)
  | otherwise = m
  where
    comp = list!!s - list!!(s - k + 1)
    min2 = if comp < m then comp else m


angryKids :: Int -> [Int] -> Int
--angryKids :: Int -> (Array Int Int) -> Int

--angryKids k list = minimum [unfairness (slice list s k) | s <- [0..((length list) - k)] ]
--angryKids k list = minimum [list!!(s + k - 1) - list!!s | s <- [0..(length list - k)]]
--angryKids k list = (sort ([list!!(s + k - 1) - list!!s | s <- [0..(length list - k)]]))!!0

-- this will fail really fast, with wrong answers (obviously)
-- it shows that minimum as well as sort is the problem here
--angryKids k list = ([list!!(s + k - 1) - list!!s | s <- [0..(length list - k)]])!!0

--angryKids k list = foldMin(list, length list - 1, k, last list)
--angryKids k list = foldMin2(list, length list - 1, k, last list)
angryKids k list = minimum [array!(s + k - 1) - array!s | s <- [0..(len - k)]]
  where
    array = listArray (0, len - 1) (sort list)
    len = length list

  --angryKids k list = minimum [list!!(s + k - 1) - list!!s | s <- [0..(length list - k)]]

  --op :: Int -> [Int]
  --anrgyKids k list = foldl' (op) (last list) list

main :: IO ()
main = do
  n <- readLn :: IO Int
  k <- readLn :: IO Int
  list <- replicateM n readLn :: IO [Int]
  --  let array = listArray (0, length list - 1) (sort list) :: Array Int Int
  let ans = angryKids k list
  --  print ans
  print  ans
