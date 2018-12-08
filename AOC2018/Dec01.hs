#!/usr/bin/env stack
-- stack --resolver lts-12.7 script

import qualified Data.IntSet as IntSet

fname :: String
fname = "Dec01.dat"

readInt :: String -> Int
readInt ('+':xs) = read xs
readInt xs = read xs

findRepeating :: [Int] -> Int
findRepeating = go IntSet.empty
  where
    go _ [] = -1
    go seen (x:xs)
      | x `IntSet.member` seen = x
      | otherwise = go (IntSet.insert x seen) xs


main :: IO ()
main = do

  changes <- fmap ((map readInt) . lines) $ readFile fname
  let partialSums = scanl (+) 0 (cycle changes)

  putStrLn $ "Part 1 answer: " ++ show (sum changes)
  putStrLn $ "Part 2 answer: " ++ show (findRepeating partialSums)
