-- Project Euler, Problem 60
-- https://projecteuler.net

import Data.List
import Data.Maybe
import Data.Numbers.Primes

pad x
  | x < 10 = 10
  | x < 100 = 100
  | x < 1000 = 1000
  | x < 10000 = 10000
  | x < 100000 = 100000
  | x < 1000000 = 1000000
  | otherwise = undefined

concatInts :: Int -> Int -> Int
concatInts x y = x * pad y + y

fitsIn :: Int -> [Int] -> Bool
fitsIn x xs = all isPrime $ map (concatInts x) xs ++ map (flip concatInts x) xs

addPrime :: [[Int]] -> Int -> [[Int]]
addPrime [] x = [[x]]
addPrime (xs:xss) x =
  if fitsIn x xs
  then xs : (x:xs) : addPrime xss x
  else xs : addPrime xss x

main :: IO ()
main = print $ find isJust $ map (find ((4<) . length)) $ scanl addPrime [[]] $ primes
