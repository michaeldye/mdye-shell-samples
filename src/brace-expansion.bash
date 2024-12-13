#!/usr/bin/env bash

set -u

# N.B. Output to stdout is evaluated by tests, stderr is context for humans.

# setup uses brace expansion; note that the end of the range *is* visited,
# unlike in other languages
for name in {0..3}; do
  # no need for explicit \n at the end of line sent to echo, echo adds that;
  # use printf if you want control of endings
  echo "$name" > "$name.txt"
done

# brace expansion is done by shell; cat command sees: "cat 0.txt 1.txt 2.txt 3.txt".
# Note that you could use {0..3} here too if we wanted
content_all="$(cat {0,1,2,3}.txt)"

echo "$content_all"

# "extended brace expansion" (introduced in bash version 3) supports other useful ranges
# note that we're putting the range output into an array
chararr=( {A..Z} {a..z} {0..9} )

echo "${chararr[*]}"
