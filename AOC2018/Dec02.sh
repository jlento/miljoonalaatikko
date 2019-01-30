#!/bin/bash

# Part two was fun with Unix tools

awk < "${0%.*}.dat" '
{
  delete freqs
  split($0, chars, "")
  for (i in chars) {
    freqs[chars[i]]++
  }
  for (i in freqs) {
    if (freqs[i]==2) {
      twos++
      break
    }
  }
  for (i in freqs) {
    if (freqs[i]==3) {
      threes++
      break
    }
  }
}
END {
  print "Part 1 answer: ", twos * threes
}'

printf "Part 2 answer: "
n=$(head -1 "${0%.*}.dat" | wc -c)
for ((i = 1; i <= n; i++)); do
    sed "s/.//$i" "${0%.*}.dat" | sort | uniq -d
done
