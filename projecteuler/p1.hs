-- Project Euler, Problem 1
-- https://projecteuler.net

sumOfMultiplesOf3And5Below :: Int -> Int
sumOfMultiplesOf3And5Below n = sum [x | x <- [1..(n-1)], mod x 3 == 0 || mod x 5 == 0]

main :: IO ()
main = print $ sumOfMultiplesOf3And5Below 1000
