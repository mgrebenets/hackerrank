import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

botEnergy = foldr (\h e -> (e + h + 1) `div` 2) 0

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- getLine
    let buildings = readNumbers input
    let ans = botEnergy buildings
    print ans
    -- print $ maximum buildings
