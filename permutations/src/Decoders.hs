module Main where
import Data.Char

-- Count how many ways there is to decode a string of digits into string of
-- characters, when 1=a, 2=b, ..., 26=z?
--
-- https://www.youtube.com/watch?v=qli-JCrSwuk


main :: IO ()
main = do
  xs <- getLine
  putStrLn $ ("Fold: " ++).show $ folding (map digitToInt xs)
  putStrLn $ ("Recursion:" ++).show $ recursion (map digitToInt xs)

recursion :: [Int] -> Int
recursion [] = 1
recursion (x:xs)
  | x == 0 = 0
  | xs == [] = 1
  | x == 1 || (x == 2 && head xs < 7) = recursion xs + recursion (tail xs)
  | otherwise = recursion xs

folding :: [Int] -> Int
folding [] = 1
folding (0:_) = 0
folding (x:xs) = fst.fst $ foldl update ((1, 1), x) xs
  where update ((n1, n2), y) z
          | y == 0 && z == 0 = ((0, 0), z)
          | y == 0           = ((n1, n1), z)
          | z == 0 && y > 2  = ((0, 0), z)
          | z == 0           = ((n2, n1), z)
          | y < 3 &&  z < 7  = ((n1 + n2, n1), z)
          | otherwise        = ((n1, n1), z)

-- The recursive approach is running into trouble quite quickly due to
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
