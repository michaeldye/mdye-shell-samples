#!/usr/bin/env bash

# See basic 'read' use in script "read-basic.bash" and its caveats.
## Sample 1

# Read specifically 5 lines of words from stdin into array
declare -a num_names_es
for _ in {1..5}; do
  read -r word
  num_names_es+=( "$word" )
done

# N.B. We set IFS in a separate command (via ; here) from the echo b/c the
# shell does the expansion and using the "set for one call" syntax causes
# the IFS var change to be used only by echo, not by the shell.
(IFS=','; echo "${num_names_es[*]}")
echo "Wrote string of num_names_es array content to stdout" >&2


## Sample 2

# Read line of space-delim items into array using the IFS var default
# to let shell expansion tokenize the words.
read -r -a num_names_en

(IFS=','; echo "${num_names_en[*]}")
echo "Wrote string of num_names_en array content to stdout" >&2


## Sample 3

# Read line of semicolon-separated words into an array using the IFS var for
# this 'read' invocation. Note that leaving IFS to its default and setting
# read's -d to ';' would cause only the first word to be written to the array
# and for read to exit. Note that this affects later processing by the next
# sample.
IFS=";" read -r -a num_names_de

(IFS=','; echo "${num_names_de[*]}")
echo "Wrote string of num_names_de array content to stdout" >&2


## Sample 4

# Read all remaining lines from stdin into an array. This works b/c a null
# char won't be reached by read until EOF.
read -d '' -r -a num_names_jp

# output all elements, space-delimited
(IFS=' '; echo "${num_names_jp[@]}")
echo "Wrote elements from num_names_jp array to stdout" >&2

exit 0
