import Control.Monad

readNumbers :: String -> [Int]
readNumbers = map read . words

readPair [a, b] = (a, b)

grid r c = 2 * (c - 1) + 9 * ((r - 1) `div` 2) + 1 * (r `div` 2)

main :: IO ()
main = do
    input <- getLine
    let (r, c) = readPair $ readNumbers input
    print $ grid r c
