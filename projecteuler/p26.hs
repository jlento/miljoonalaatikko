-- Project Euler, Problem 26
-- https://projecteuler.net

import Data.List
import Data.Function

nominators :: Int -> Int -> [Int]
nominators x y
  | rem x y == 0 = x : [x]
  | x < y = nominators (10 * x) y
  | otherwise = x : nominators (10 * rem x y) y

cycleLength :: [Int] -> Int
cycleLength l = go [] l
  where go _ [] = undefined
        go [] (x:xs) = go [x] xs
        go vs (x:xs)
          | any (x==) vs = length $ takeWhile (x/=) vs
          | otherwise = go (x:vs) xs

main :: IO ()
main = print $ maximumBy (compare `on` (cycleLength . nominators 1)) [2..999]
