import Control.Monad
import Data.Array
import Data.List

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

countLessThan = mapAccumL (\acc (x, c) -> (acc + c, (x, acc + c))) 0

main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- replicateM n getLine
    let input = map readElement list
    -- print input
    let counts = count input
    -- print counts

    -- have the counts, now need to go through them and accumulate a new array
    -- for each count, take the second value in the tuple and sum it up with accumulated value and put result into resulting array
    let ans = map snd (snd (countLessThan counts))
    putStr $ unwords (map show ans)
