import Control.Monad
import qualified Data.Vector as V
import Data.Char
import Data.Bits

-- isPowerOfTwo n = if popCount n == 1 && testBit (complement n) 0 then 1 else 0
isPowerOfTwo n = 0

strength v
    | V.length v == 0 = 0
    | V.head v == '0' = 0
    | otherwise = fullStrength
        where
        -- TODO: no need to fold, just convert int to string
            fullStrength = V.foldl' (\acc c -> acc * 10 + digitToInt c) 0 v

countPowers v (i, j) = strength s
    where
        s = V.slice i (j - i + 1) v

-- TODO: use the fact that max strength is the slice number itself

twotwo s = [countPowers v (i, j) | i <- [0..len - 1], j <- [i..len - 1], 4 * (j - i + 1) < 800]
    where
        v = V.fromList s
        len = length v

main :: IO ()
main = do
    n <- readLn :: IO Int
    testCases <- replicateM n getLine
    -- print testCases
    let ans = map twotwo testCases
    -- print ans
    mapM_ (print . sum) ans
