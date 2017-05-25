-- cabal update
-- cabal install csv

import Text.CSV

isTriangleNumber :: Int -> Bool
isTriangleNumber x =
  rem (2*x) n == 0 && rem (div (2*x) n) (n + 1) == 0
    where n = floor $ sqrt (2.0 * fromIntegral x)

intFromWord :: String -> Int
intFromWord [] = 0
intFromWord (x:xs) = intFromChar x + intFromWord xs
  where intFromChar c = fromEnum c - fromEnum 'A' + 1

main = do
  d <- parseCSVFromFile "/vagrant/p042_words.txt"
  case d of
    Right ws ->
      print $ length $ filter isTriangleNumber $ map intFromWord $ concat ws
    Left e ->
      print e
