-- Project Euler, Problem 3
-- https://projecteuler.net

largestPrimeFactor :: Int -> Int
largestPrimeFactor n = snd $ largestPrimeFactor' (2, n)
  where largestPrimeFactor' (a, s)
          | a > div s a = (a, s)
          | rem s a == 0 = largestPrimeFactor' (a, div s a)
          | otherwise = largestPrimeFactor' (a + 1, s)

main :: IO ()
main = print $ largestPrimeFactor 600851475143
