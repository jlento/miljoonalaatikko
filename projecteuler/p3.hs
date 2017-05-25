factor :: Int -> [Int]
factor n = undefined

factor' :: (Int,Int) -> (Int,Int)
factor' (g,n)
  | rem n g == 0 = (g, div n g)
  | g >= div n 2 = (n,1)
  | otherwise = factor' (g+1,n)

factor'' :: [Int] -> (Int, Int) -> ([Int], Int, Int)
factor'' fs (g,n)
  | n == 1 = ((g:fs),g,n)
  | otherwise = factor'' (g:fs) (factor' (g,n))

n = 600851475143 :: Int

main = print $ factor'' [] (2,n)
