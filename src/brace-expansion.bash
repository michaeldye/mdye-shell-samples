#!/usr/bin/env bash

set -u

# N.B. Output to stdout is evaluated by tests, stderr is context for humans.

# Setup uses brace expansion; note that the end of the range *is* visited,
# unlike in other languages
for name in {0..3}; do
  # No need for explicit \n at the end of line sent to echo, echo adds that;
  # Use printf instead to control line endings
  echo "$name" > "$name.txt"
done

# Brace expansion is done by shell so cat command sees: "cat 0.txt 1.txt 2.txt
# 3.txt". Note that we could use {0..3} here too if we wanted
content_all="$(cat {0,1,2,3}.txt)"

echo "$content_all"
echo "Wrote content from concatenated output files to stdout" >&2

# "Extended brace expansion" (introduced in Bash version 3) supports other
# useful ranges. Note that we're writing the range output into an array
chararr=( {A..Z} {a..z} {0..9} )

echo "${chararr[*]}"
echo "Wrote generated brace expanded content to stdout" >&2

exit 0
