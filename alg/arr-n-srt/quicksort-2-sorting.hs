import Control.Monad

readNumbers :: String -> [Int]
readNumbers = map read . words

-- so I just learned that scanl and scanr
-- are functions that report intermideate states
-- while folding
-- could be applied here, probably
-- quicksort :: (Ord a) => [a] -> [a]
quicksort [] acc = ([], acc)
quicksort [x] acc = ([x], acc)
quicksort (p:xs) acc = (arr, sidesAcc ++ [arr])
    where
        leftRun = quicksort [l | l <- xs, l < p] acc
        rightRun = quicksort [g | g <- xs, g > p] (snd leftRun)
        sidesAcc = snd rightRun
        arr = fst leftRun ++ [p] ++ fst rightRun


main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- getLine
    let input = readNumbers list
    let ans = quicksort input []
    let prep = snd ans
    putStr (unlines (map (unwords . map show) prep))
    -- same as
    -- putStr $ unlines $ map (unwords . map show) prep
