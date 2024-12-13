#!/usr/bin/env bash

# N.B. Output to stdout is evaluated by tests, stderr is context for humans.

# dec number conversion
oct_75_a=$((8#75))
echo "75 declared in octal (usually written as 0$oct_75_a):" >&2
echo "$oct_75_a"

echo "75 in base 10:" >&2
echo "$((10#75))"

hex_75_a=$((16#75))
echo "75 declared in hex (usually written as 0x$hex_75_a):" >&2
echo "$hex_75_a"

# declaration as octal
oct_75_b=075

# declaration as hex
hex_75_b=0x75

# output the literals
echo "75 declared as octal, hex literals and output as strings:" >&2
printf "%s, %s\n" $oct_75_b $hex_75_b

# convert to dec with printf
echo "octal, hex literals converted to dec:" >&2
printf "%d, %d\n" $oct_75_b $hex_75_b

# "quoted string expansion" expands escaped octal or hex values in ascii or unicode
octal_101=$'\101'
echo "A declared as octal 101:" >&2
echo "$octal_101"
