#!/usr/bin/env bash

# Sample 1

# Setup
word_upper="SOMEWORD"

word_lower="${word_upper,,}"

echo "$word_lower"
echo "Wrote lowercase word to stdout" >&2


# Note: some 'cut' and 'tr' examples were originally from HackerRank exercises

# Sample 2

# `cut` can extract chars by index; *important*: they are 1-indexed, not 0
echo "$word_upper" | cut -c3
echo "Wrote M to stdout" >&2

# cut can also extract ranges
echo "$word_upper" | cut -c3-5
echo "Wrote MEW to stdout" >&2


# Sample 3

# Setup (note use of ansi-c quoting here, https://www.gnu.org/software/bash/manual/html_node/ANSI_002dC-Quoting.html)
line=$'Los Angeles, California\t3,819,702\t2\tLos Angeles-Long Beach-Santa Ana, CA'
line_csv=$'Foo,33,Niner'

# When specifying a delimiter (or using the default, TAB), use "fields" switch
# (-f) to specify index
echo "$line" | cut -f1-3
echo "Wrote fields 1-3 (inclusive) to stdout" >&2

echo "$line_csv" | cut -d ',' -f2
echo "Wrote field 3 from csv line to stdout" >&2


# Sample 4

# Setup
contact="Donny Kerabatsos <donny@hollywoodstarlanesfan.tld>"

# tr takes 'mapping' of < to replacement ( and > to ), respectively
echo "$contact" | tr '<>' '()'
echo "Wrote contact info with replaced delimiters to stdout" >&2


# Sample 5

# Setup
too_many_spaces="lots        of    repeated    spaces"

echo "$too_many_spaces" | tr -s ' '
echo "Wrote input with collapsed-to-singular space ranges" >&2


# Sample 6

# Setup
sloppy_separators="Los Angeles     California         93010"

# sed replaces repeated sequences of spaces with tabs (*important*, it leaves
# single spaces alone)
echo "$sloppy_separators" | sed -E 's/\s{2,}/\t/g'


exit 0
