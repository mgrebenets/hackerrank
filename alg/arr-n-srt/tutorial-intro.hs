import Control.Monad
import Data.List
import Data.Maybe

readNumbers :: String -> [Int]
readNumbers = map read . words

main :: IO ()
main = do
    e <- readLn :: IO Int
    n <- readLn :: IO Int
    line <- getLine
    let list = readNumbers line
    print (Data.Maybe.fromJust (elemIndex e list))
