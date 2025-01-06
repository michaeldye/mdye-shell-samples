#!/usr/bin/env bash

# Notes: Bash doesn't support floating point arithmetic. Bc, a common tool in
# GNU/Linux, does fixed-point arithmetic which gets us basic decimal results
# in calculations with some control of the precision.

# Sample 1

# Setup (Note that this was originally a HackerRank problem)
expression="5+50*3/20 + (19*2)/7"

# Use bc command to get 5 decimal places of precision in answer. We use 5
# b/c it looks like bc truncates and doesn't round up (scale=3 with our
# expression yields '17.928' while scale=5 yields '17.92857'). We know
# printf *will* round up so we use that for our output.
result=$(echo "scale=5; $expression" | bc)

echo "$result"
echo "Wrote answer with 5 decimal places of precision" >&2

printf "%.3f\n" "$result"
echo "Used printf to round result to 3 decimal places" >&2

exit 0
