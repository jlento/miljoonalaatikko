-- Project Euler, Problem 2
-- https://projecteuler.net

fibs :: [Int]
fibs = 1 : 2 : zipWith (+) fibs (tail fibs)

sumOfEvenFibsUnder :: Int -> Int
sumOfEvenFibsUnder x = sum $ filter (\i -> mod i 2 == 0) $ takeWhile (<x) fibs

main :: IO ()
main = print $ sumOfEvenFibsUnder 4000000
