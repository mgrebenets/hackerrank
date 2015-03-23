import Control.Monad
import Data.List

diff line1 line2 =  length (line1 \\ line2) + length (line2 \\ line1)

main :: IO ()
main = do
    line1 <- getLine
    line2 <- getLine
    let ans = diff line1 line2
    print ans
