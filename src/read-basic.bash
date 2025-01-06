#!/usr/bin/env bash

# See
# https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-read.
# Also relevant: https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html.

# Note that while 'read' is very commonly used to process lines of text from
# either stdin, it's not very performant (it reads a char-at-a-time) and
# readability can get bad pretty quickyl. If a script needs to process input
# that is large, or the processing is complex, prefer awk, sed or a discrete
# program.

# One way in which 'read' is particularly useful is as a means to populate an
# array with input data. See the 'read-into-array.bash' file for samples of that
# use.

## Sample 1

# Read line from stdin ('-r' used to prevent Bash from using \ as escape char)
# Note that it doesn't matter what we set IFS to b/c there is no word splitting
# happening upon expansion by the shell and read is using its default $'\n'
# delim. We would read only one word from stdin if, for example, we used -d ' '.
read -r line1
echo "${line1}"
# shellcheck disable=SC2028
echo "Wrote line1 (using default IFS that matches \n and \t) to stdout from var" >&2


## Sample 2

# Consume all lines of text with read, count words in for loop (note that IFS
# is set to the default, <space><tab><newline>
count=0
while read -r line; do
    for _word in $line; do
      count=$((count+1))
    done
done

echo "$count"
echo "Wrote word count from remaining lines on stdin to stdout" >&2

exit 0
