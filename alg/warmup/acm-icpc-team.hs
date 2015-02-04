-- Enter your code here. Read input from STDIN. Print output to STDOUT

import Control.Monad
import Data.Bits
import Data.List
import Data.Char (digitToInt)
import Data.Array

frequencyCount :: Char -> String -> Int
frequencyCount a = foldr (\x sum -> if x == a then sum + 1 else sum) 0

strPopCount :: String -> Int
strPopCount = frequencyCount '1'

strUnion :: String -> String -> String
strUnion s1 s2 = map (\(x, y) -> if x == '1' || y == '1' then '1' else '0') (zip s1 s2)

oring :: [String] -> [String]
oring [] = []
oring [x] = []
oring (x:xs) = oring xs ++ map (strUnion x) xs

-- reverse sort by pop count to get biggest strings first
strCmp s1 s2
  | strPopCount s1 <= strPopCount s2 = GT
  | otherwise = LT

--findTeams xs = last (group (sortBy strCmp (map sort (oring xs))))
-- findTeams xs = last (group (sort (map strPopCount (oring xs))))
-- findTeams xs = last (group (sort (arrOring xs)))
findTeams xs = last (group (sort (arrOring xs)))


readNumbers :: String -> [Int]
readNumbers = map read . words

--getCounts xs = [strPopCount (head teams), length teams]
--    where
--        teams = findTeams xs

getCounts xs = [head teams, length teams]
  where
    teams = findTeams xs

--arrOring :: [String] -> [String]
arrOring list = [strPopCount (strUnion (arr!i) (arr!j)) | i <- [0..len - 2], j <- [i + 1 .. len - 1] ]
  where
    arr = listArray (0, len - 1) (sortBy strCmp list)
    -- arr = listArray (0, len - 1) (sort list)
    len = length list

    --toDec :: String -> Int
    --toDec = foldl' (\acc x -> acc * 2 + digitToInt x) 0

-- tc 4
-- 467
-- 1

main :: IO ()
main = do
  counts <- getLine
  let countsList = readNumbers counts
  let n = head countsList
  let k = last countsList
  skills <- replicateM n getLine
  --    let intSkills = map fromList skills
  --    print intSkills
  --    print $ map strPopCount skills
  --    print $ strUnion (last skills) (last skills)
  --    print $ oring skills
  --    print $ last (group (sortBy strCmp (oring skills)))
  -- print $ sortBy strCmp skills
  -- print $ arrOring skills

  --    print $ oring array
  -- let arr = arrOring skills
  -- print $ head arr
  -- print $ head (sort arr)
  let teamCounts = getCounts skills
  print $ head teamCounts
  print $ last teamCounts
