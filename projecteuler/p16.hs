-- Project Euler, Problem 16
-- https://projecteuler.net

sumOfDigits :: Integer -> Int
sumOfDigits = sum . (map (\x -> fromEnum x  - fromEnum '0')) . show

main :: IO ()
main = print $ sumOfDigits (2^1000)
