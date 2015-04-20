import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words
readPair [a, b] = (a, b)

buy k toys = length $ takeWhile (<k) $ scanl (+) 0 toys

main :: IO ()
main = do
    input <- getLine
    let (n, k) = readPair (readNumbers input)
    input <- getLine
    let toys = sort $ readNumbers input
    -- print toys
    let ans = buy k toys
    print $ ans - 1
