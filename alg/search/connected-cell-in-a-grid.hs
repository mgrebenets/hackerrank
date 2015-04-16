import Control.Monad
import qualified Data.Vector as V
import qualified Data.Set as S
import Data.List

cellValue m i j = m V.!i V.!j

-- maxIsland :: V.Vector (V.Vector Int) -> Int -> Int -> (S.Set (Int, Int), [Int])
maxIsland m r c = mapAccumL (track 0) S.empty [ (i, j) | i <- [0..r - 1], j <- [0..c - 1] ]
    where
        -- track :: Int -> S.Set (Int, Int) -> (Int, Int) -> (S.Set (Int, Int), Int)
        track cnt marked (i, j)
            | S.member (i, j) marked = (marked, cnt)
            | value == 0 = (marked, 0)
            | otherwise =
                -- don't reuse 'marked' name here, will loop forever
                let remarked = S.insert (i, j) marked
                    inner = mapAccumL (track (cnt)) remarked neighbours
                in (fst inner, 1 + sum (snd inner))
            where
                -- this list comprehension can be made easier, but I'm too tired of this thing already
                neighbours = [ (v, h) | (v, h) <- [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1), (i - 1, j - 1), (i - 1, j + 1), (i + 1, j - 1), (i + 1, j + 1)], v >= 0 && v < r && h >=0 && h < c ]
                value = cellValue m i j

-- TC3 answer is 15

readNumbers :: String -> [Int]
readNumbers = map read . words

main :: IO ()
main = do
    r <- readLn :: IO Int
    c <- readLn :: IO Int
    input <- replicateM r getLine
    let list = map readNumbers input
    let m = V.fromList (map V.fromList list)
    let ans = maxIsland m r c
    print $ maximum $ snd ans
