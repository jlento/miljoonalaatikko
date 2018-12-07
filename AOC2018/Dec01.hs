#!/usr/bin/env stack
-- stack --resolver lts-12.5 script

fname :: String
fname = "Dec01.dat"

readInt :: String -> Int
readInt = read . filter (not . (`elem` "+"))

main :: IO ()
main = do
  changes <- fmap ((map readInt) . lines) $ readFile fname
  putStrLn $ "Part 1 answer: " ++ show (sum changes)
