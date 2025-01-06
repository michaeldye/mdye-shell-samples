#!/usr/bin/env bash

# N.B. Output to stdout is evaluated by tests, stderr is context for humans.

# dec number conversion
oct_75_a=$((8#75))
echo "$oct_75_a"
echo "Output 75 declared in octal (usually written as 0$oct_75_a)" >&2

echo "75 in base 10:" >&2
echo "$((10#75))"

hex_75_a=$((16#75))
echo "$hex_75_a"
echo "Output 75 declared in hex (usually written as 0x$hex_75_a)" >&2

# declaration as octal
oct_75_b=075

# declaration as hex
hex_75_b=0x75

# output the literals
printf "%s, %s\n" $oct_75_b $hex_75_b
echo "Output '75' declared as octal and hex literals with printf" >&2

# convert to dec with printf
printf "%d, %d\n" $oct_75_b $hex_75_b
echo "Output octal, hex literals converted to decimal with printf" >&2

# "quoted string expansion" expands escaped octal or hex values in ascii or
# unicode
octal_101=$'\101'
echo "$octal_101"
echo "Output octal 101 using quoted string expansion" >&2

exit 0
