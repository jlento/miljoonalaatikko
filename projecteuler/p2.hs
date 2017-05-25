fibs = 1 : 2 : zipWith (+) fibs (tail fibs)

result = sum $ filter (\n -> mod n 2 == 0) $ takeWhile (<4000000) fibs
