#!/usr/bin/env bash

# See https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-read.

## Sample 1

# Read line from stdin ('-r' used to prevent Bash from using \ as escape char)
read -r line1
echo "${line1}"


## Sample 2

# Read single char from next line
read -r -n1 line2char
echo "${line2char}"
echo "Wrote line2char's value to stdout" >&2

# Be a good citizen and eat up rest of line2
IFS=$'\n' read -r


## Sample 3

# Read line of space-delim items into array
IFS=' ' read -r -a num_names

# Use a subshell to protect IFS
(IFS=','; echo "${num_names[*]}")
echo "Wrote string of num_names array content to stdout" >&2


## Sample 4

# Consume all lines of text with read, count words in for loop
count=0
while read -r line; do
    for _word in $line; do
      count=$((count+1))
    done
done

echo "$count"
echo "Wrote word count from remaining lines on stdin to stdout" >&2

exit 0
