import Control.Monad
import qualified Data.Vector as V

cavityMap m n = [ [ mark i j | j <- [0..lim]] | i <- [0..lim]]
    where
        lim = n - 1
        mark :: Int -> Int -> Char
        mark i j
            | i <= 0 || j <= 0 || i >= lim || j >= lim = m V.! i V.! j
            | otherwise = compute i j
            where
                compute i j
                    -- using the fact that 'X' is greater than other digits, so no edge case checks here
                    | l < e && r < e && u < e && b < e = 'X'
                    | otherwise = e
                    where
                        e =  m V.! i V.! j
                        l = m V.! i V.! (j - 1)
                        r = m V.! i V.! (j + 1)
                        u = m V.! (i - 1) V.! j
                        b = m V.! (i + 1) V.! j

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    -- no need to convert to ints, characters are Ord as well
    let m = V.fromList (map V.fromList input)
    let ans = cavityMap m n
    mapM_ putStrLn ans
