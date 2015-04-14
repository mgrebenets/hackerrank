import Control.Monad
import Data.List

readNumbers :: String -> [Int]
readNumbers = map read . words

cutTheSticks :: (Ord a, Num a) => [a] -> [Int] -> [Int]
cutTheSticks [] acc = acc
cutTheSticks l acc = cutTheSticks (filter (> 0) (map (\x -> x - m) l)) (acc ++ [length l])
    where
        m = minimum l

main :: IO ()
main = do
    n <- readLn :: IO Int
    list <- getLine
    let input = sort $ readNumbers list
    let ans = cutTheSticks input []
    mapM_ print ans
