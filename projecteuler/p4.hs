-- Project Euler, Problem 4
-- https://projecteuler.net

import Data.List
import Data.Maybe

decending2NDigitPalindromes :: Int -> [Int]
decending2NDigitPalindromes n =
  map (\x -> read $ show x ++ reverse (show x)) ([(10^n - 1),(10^n - 2)..(10^(n - 1))] :: [Int])

smallerOfNDigitFactors :: Int -> Int -> Maybe Int
smallerOfNDigitFactors n x
  | div x m + 1 > m || x > m*m = Nothing
  | otherwise = find ((0 ==) . rem x) [(div x m)..m]
  where m = 10^n - 1

largestPalindromeOutOfProductOfTwoNdigitNumbers :: Int -> Maybe Int
largestPalindromeOutOfProductOfTwoNdigitNumbers n =
  find (isJust . smallerOfNDigitFactors n) $ decending2NDigitPalindromes n

main :: IO ()
main = case largestPalindromeOutOfProductOfTwoNdigitNumbers 3 of
  Just x -> print x
  Nothing -> undefined
