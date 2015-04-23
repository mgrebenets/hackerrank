import Control.Monad
import qualified Data.Map as Map
import Data.Maybe

-- ugly, could improve by appending "teen"s with special rules
numberStrings = Map.fromList
    [(1, "one")
    ,(2, "two")
    ,(3, "three")
    ,(4, "four")
    ,(5, "five")
    ,(6, "six")
    ,(7, "seven")
    ,(8, "eight")
    ,(9, "nine")
    ,(10, "ten")
    ,(11, "eleven")
    ,(12, "twelve")
    ,(13, "thirteen")
    ,(14, "fourteen")
    ,(15, "fifteen")
    ,(16, "sixteen")
    ,(17, "seventeen")
    ,(18, "eighteen")
    ,(19, "nineteen")
    ]

sayNumber n = fromJust $ Map.lookup n numberStrings

sayHour = sayNumber

sayMinutes m
    | m < 20 = sayNumber m
    -- assume only "twenties" here
    | otherwise = "twenty " ++ sayNumber (m `mod` 20)

nextHour h
    | h == 11 = 12
    | otherwise = (h + 1) `mod` 12

sayTime h m
    | m == 0 = hourStr ++ " o' clock"
    | m == 30 = "half past " ++ hourStr
    | m == 15 = "quarter past " ++ hourStr
    | m == 45 = "quarter to " ++ nextHourStr
    | m < 30 = sayMinutes m ++ " minutes past " ++ hourStr
    | m > 30 = sayMinutes (60 - m) ++ " minutes to " ++ nextHourStr
    where
        hourStr = sayHour h
        nextHourStr = sayHour $ nextHour h


main :: IO ()
main = do
    h <- readLn :: IO Int
    m <- readLn :: IO Int
    -- print h
    -- print m
    -- print $ sayHour h
    putStrLn $ sayTime h m
