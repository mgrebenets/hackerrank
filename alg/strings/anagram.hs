import Control.Monad
import Data.List

diff line1 line2 =  length (line1 \\ line2)

split l = (take (half + adj) l, drop (half + adj) l)
  where
    len = length l
    half = div len 2
    adj = mod len 2

anagram combinedLine = if len1 > len2 then -1 else diff line1 line2
    where
        len1 = length line1
        len2 = length line2
        line1 = fst s
        line2 = snd s
        s = split combinedLine

main :: IO ()
main = do
    n <- readLn :: IO Int
    input <- replicateM n getLine
    let ans = map anagram input
    mapM_ print ans
    -- let t = map split input
    -- mapM_ print t
