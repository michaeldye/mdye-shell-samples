#!/usr/bin/env bash

script=$(realpath "$(dirname "$0")")

# See
# https://www.gnu.org/software/gawk/manual/gawk.html.


# Sample 1
infile1="$script/awk-basic.input1.csv"; [[ -f "$infile1" ]] || exit 2

# skip header and print <name>: <lat>,<lon> for each meteorite
awk -F, 'NR>1{ print $1": "$8","$9 }' <"$infile1"
echo "Wrote extracted field data from sloppy csv input" >&2

exit 0
