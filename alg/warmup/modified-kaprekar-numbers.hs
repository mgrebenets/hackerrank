import Control.Monad
import Data.List

-- isKaprekar :: Int -> Bool
isKaprekar n =
    n == l + r
    where
        square = n ^ 2
        squareStr = show square
        len = length squareStr
        (lStr, rStr) = splitAt (len `div` 2) squareStr
        l = if null lStr then 0 else read lStr :: Int
        r = if null rStr then 0 else read rStr :: Int

kaprekars a b = filter isKaprekar [a..b]

main :: IO ()
main = do
    a <- readLn :: IO Int
    b <- readLn :: IO Int
    let kaps = kaprekars a b
    putStrLn $ if null kaps then "INVALID RANGE" else unwords $ map show kaps
