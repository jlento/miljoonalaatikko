-- Project Euler, Problem 51
-- https://projecteuler.net

-- Inspiration from Data.List.Unique
-- cabal install digits

import Data.List
import Data.Numbers.Primes

-- select ith digit
digit :: Int -> Int -> Int
digit i x = rem (div x (10^i)) 10

digits :: [Int] -> Int -> [Int]
digits is x = foldl (\acc a -> digit a x : acc) [] is

setDigitTo :: Int -> Int -> Int -> Int
setDigitTo d i x = x - rem x (10^(i+1)) + rem x (10^i) + 10^i*d

setDigitsTo :: Int -> [Int] -> Int -> Int
setDigitsTo d is x = foldr (setDigitTo d) x is

zeroDigitsIfEqual :: [Int] -> Int -> Int
zeroDigitsIfEqual is x =
  if all (head vs ==) vs
  then setDigitsTo 0 is x
  else x
  where vs = digits is x


newEq :: [Int] -> (Int -> Int -> Bool)
newEq xs = (\p q -> zeroDigitsIfEqual xs p ==  zeroDigitsIfEqual xs q)

newOrder :: [Int] -> (Int -> Int -> Ordering)
newOrder xs = (\p q -> compare (zeroDigitsIfEqual xs p)  ( zeroDigitsIfEqual xs q))

sg :: [Int] -> [Int] -> [[Int]]
sg xs = groupBy (newEq xs) . sortBy (newOrder xs)

filterByLength :: [Int] -> (Int -> Bool) -> [Int] -> [[Int]]
filterByLength xs p = filter (p . length) . sg xs

--repeatedBy :: [Int] -> (Int -> Bool) -> [Int] -> [Int]
--repeatedBy xs p = map head . filterByLength xs p

primesOfNDigits :: Int -> [Int]
primesOfNDigits n =
  takeWhile (10^n>) $ dropWhile (10^(n-1)>) primes

primesOfTheForm is x =
  filter isPrime $ tail $ scanl (\acc d -> setDigitsTo d is acc) x [0..9]

firstFamiliesOf :: Int -> [[[Int]]]
firstFamiliesOf m = map (nDigitFirstFamiliesOf m) [2..]

nDigitFirstFamiliesOf :: Int -> Int -> [[Int]]
nDigitFirstFamiliesOf m n =
  sortBy (\x y -> compare (head x) (head y)) $
  concat $
  zipWith (\xs ys -> filterByLength xs (==m) ys) (subsequences [1..(n-1)]) (repeat (primesOfNDigits n))

firstFamilyOf :: Int -> Maybe [Int]
firstFamilyOf m = find (not . null) (concat $ firstFamiliesOf m)

main :: IO ()
main = print $ firstFamilyOf 8
  --

