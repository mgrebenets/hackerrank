import Control.Monad
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Char

pangram line = if Set.size s == 26 then "pangram" else "not pangram"
    where
        s = Set.fromList (concatMap id (words lowLine))
        lowLine = map toLower line

main :: IO ()
main = do
    line <- getLine
    let ans = pangram line
    putStr ans
