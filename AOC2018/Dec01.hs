#!/usr/bin/env stack
-- stack --resolver lts-12.5 script

readInt :: String -> Int
readInt = read . filter (not . (`elem` "+"))

main :: IO ()
main = do
  changes <- fmap ((map readInt) . lines) $ readFile "Dec01.dat"
  putStrLn $ "Part 1 answer: " ++ show (sum changes)
