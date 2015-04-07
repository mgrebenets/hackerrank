import Control.Monad
import Data.List

combine :: String -> Int -> (Char, Char) -> (Int, Char)
combine string n (c, d)
    | d == '0' = (n, '0')
    | otherwise = (n + 1, string!!n)

pairUp :: Int -> String -> String -> (Int, String)
pairUp n string bits = mapAccumL (combine string) 0 $ zip string bits

main :: IO ()
main = do
    string <- getLine
    bits <- getLine
    let ans = pairUp 0 string bits
    putStrLn (snd ans)
