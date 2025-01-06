#!/usr/bin/env bash

script=$(realpath "$(dirname "$0")")


# Sample 1

# Setup
infile1="$script"/file-basic.input1.tsv; [[ -f "$infile1" ]] || exit 3

# use column to nicely display tab-delimited text
column -ts$'\t' <"$infile1"
echo "Wrote tsv input text in nice, space-separated columns to stdout" >&2


# Sample2

# Setup
infile2="$script"/file-basic.input2.env; [[ -f "$infile2" ]] || exit 4

# Use paste to replace line endings with a specific delimiter

paste -s -d ',' "$infile2"
echo "Wrote summary line of short env file contents to stdout" >&2

exit 0
