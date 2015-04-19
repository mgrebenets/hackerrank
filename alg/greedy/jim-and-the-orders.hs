import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

readPair [a, b] = (a, b)

-- compareOrders (i1, t1, d1, f1) (i2, t2, d2, f2) = f1 `compare` f2
compareOrders (i1, (t1, d1, f1)) (i2, (t2, d2, f2)) = f1 `compare` f2

orders fans = sortBy compareOrders $ zip [1..] $ map ((\(a, b) -> (a, b, a + b)) . readPair) fans

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let fans = map readNumbers input
    let ans = orders fans
    putStrLn $ unwords (map (show . fst) ans)
