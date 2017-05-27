-- Project Euler, Problem 20
-- https://projecteuler.net

sumOfDigits :: Integer -> Integer
sumOfDigits = sum . map (\c -> toInteger $ fromEnum c - fromEnum '0') . show

sumOfDigitsInFactorial :: Integer -> Integer
sumOfDigitsInFactorial n = sumOfDigits $ fst $ factmod10 (1, n)
  where factmod10 (a, s)
          | s == 1 || s == 0 = (a, 1)
          | rem (a*s) 10 == 0 = factmod10 (div (a*s) 10, s - 1)
          | otherwise = factmod10 (a*s, s - 1)

main :: IO ()
main = print $ sumOfDigitsInFactorial 100
