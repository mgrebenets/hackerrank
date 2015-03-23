import Control.Monad
import Data.List

allAscii = ['a'..'z']

countGemStones = foldl intersect allAscii

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let ans = countGemStones input
    print (length ans)
