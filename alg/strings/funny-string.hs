import Control.Monad
import Data.List
import Data.Char
import Data.Function

squash :: String -> [Int]
squash s = tail . snd $ mapAccumL (\acc c -> (ord c, ord c - acc)) 0 s

-- funny s = zipWith ((-) `on` abs) (squash s) (squash $ reverse s)
funny s = foldl (\f (a, b) -> (abs a == abs b) && f) True $ zip (squash s) (squash $ reverse s)

spell f = if f then "Funny" else "Not Funny"

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let ans = map (spell . funny) input
    mapM_ putStrLn ans
