import Control.Monad

readNumbers :: String -> [Int]
readNumbers = map read . words

partition :: (Ord a) => [a] -> [a]
partition [] = []
partition (p:xs) = [l | l <- xs, l < p] ++ [p] ++ [g | g <- xs, g > p]


main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- getLine
    let input = readNumbers list
    let ans = partition input
    putStrLn (unwords (map show ans))
