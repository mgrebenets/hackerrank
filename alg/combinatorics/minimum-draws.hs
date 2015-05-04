import Control.Monad

solve n = n + 1

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let tests = map read input :: [Int]
    let ans = map (1 +) tests
    mapM_ print ans
