import Control.Monad
import qualified Data.Vector as V
import qualified Data.Set as S
import Data.List

-- cellValue m r c = m V.!r V.!c

-- maxIsland m r c = [ track m i j | i <- [0..r - 1], j <- [0..c - 1] ]
--     where
--         marked = S.empty
--         track m i j acc
--             | S.member (i, j) marked = acc
--             | otherwise = do
--                 S.insert (i, j) marked
--                 return acc + sum [ track m v h | v <- [i - 1, i + 1], h <- [j - 1, j + 1], v >= 0 && v < r && h >= 0 && h < c ]


-- track m i j acc = (i, j)

fullIndex i j r = r * i + j

-- how the hell to pass

cellValue m i j = m V.!i V.!j

-- maxIsland :: t -> Int -> Int
maxIsland :: V.Vector (V.Vector Char) -> Int -> Int -> (Int, [Int])
maxIsland m r c = mapAccumL (track 0) S.empty [ (i, j) | i <- [0..r - 1], j <- [0..c - 1] ]
    where
        track :: Int -> S.Set (Int, Int) -> (S.Set (Int, Int), Int)
        track cnt marked (i, j)
            | S.member (i, j) marked = (marked, cnt)
            | value == 0 = (marked, cnt)
            | otherwise = (marked, cnt)
                -- let marked = S.insert (i, j) marked
                -- TODO: figure this out
                -- in mapAccumL track (acc + 1, marked) neighbours
                -- in (marked, cnt)
            where
                neighbours = [ (h, v) | h <- [i - 1, i + 1], v <- [j - 1, j + 1], h >= 0 && h < r && v >=0 && v < c ]
                value = cellValue m i j

        -- = ((acc, marked), 0)

    -- return $ track m i j S.empty acc
    -- where
    --     -- track :: t -> Int -> Int -> Int -> Int
    --     track m i j marked acc
    --         | S.member (i * r + j) marked = (makred, acc)
    --         | otherwise = do
    --             let marked = S.insert (i * r + j) marked
    --             return (acc + 1)


-- maxIsland m r c = [ track m i j | i <- [0..r - 1], j <- [0..c - 1]]
--     where
--         marked = S.empty
--         track m i j acc
--             | S.member (i, j) marked = acc
--             | otherwise = do
--                 S.insert (i, j) marked
--                 return sum [ track m di dj | h <- [-1, 1], v <- [-1, 1], di >= 0 && di < r && dj >= 0 && dj < c, let di = i + v, let dj = j + h]

main :: IO ()
main = do
    r <- readLn :: IO Int
    c <- readLn :: IO Int
    input <- replicateM r getLine
    let m = V.fromList (map V.fromList input)
    -- print m
    let ans = maxIsland m r c
    -- print ans
    print "--"
