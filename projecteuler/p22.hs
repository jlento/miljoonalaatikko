-- Project Euler, Problem 22
-- https://projecteuler.net

import Text.CSV
import Data.List

alphabeticalValue :: String -> Int
alphabeticalValue = sum . map (\c -> 1 + fromEnum c - fromEnum 'A')

sumOfScores :: [[String]] -> Int
sumOfScores =  sum . zipWith (*) [1..] . map alphabeticalValue . sort . concat

main :: IO ()
main = do
  s <- parseCSVFromFile "p022_names.txt"
  case s of
    Right x -> print $ sumOfScores x
    Left x -> print x
