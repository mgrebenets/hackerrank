import Control.Monad

readNumbers :: String -> [Int]
readNumbers = map read . words

convert [] = []
convert (c:p:xs) = (c ++ p) : convert xs

readInput [b, w, x, y, z] = (b, w, x, y, z)

solve (b, w, x, y, z) = b * mx + w * my
    where
        mx = min x (y + z)
        my = min y (x + z)

main :: IO ()
main = do
    t <- readLn :: IO Int
    input <- replicateM (t * 2) getLine
    let ints = map readNumbers input
    let tests = map readInput $ convert ints
    let ans = map solve tests
    mapM_ print ans
