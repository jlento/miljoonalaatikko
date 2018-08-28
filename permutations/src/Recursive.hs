module Main where
import Data.Char

-- Count how many ways there is to decode a string of digits into string of
-- characters, when 1=a, 2=b, ..., 26=z?
--
-- https://www.youtube.com/watch?v=qli-JCrSwuk


main :: IO ()
main = do
  xs <- getLine
  print $ noi (map digitToInt xs)

-- Number Of Interpretations
noi :: [Int] -> Int
noi [] = 1
noi (x:xs)
  | x == 0 = 0
  | xs == [] = 1
  | x == 1 || (x == 2 && head xs < 7) = noi xs + noi (tail xs)
  | otherwise = noi xs


-- This recursive approach is running into trouble quite quickly due to
-- combinatorial explosion with some test data. Try:
--     stack ghc src/Recursive.hs
--     stack exec src/Recursive <<<"1111111111111111111111111111111111111"
--
-- Notice any familiar sequence if running with?
--     "1"
--     "11"
--     "111"
--     "1111"
--     "11111"
--     "111111"
--     ...
--
-- Does this give a hint about a more efficient approach? :)
