#!/usr/bin/env bash

# See examples about reading stdin into arrays in script
# "read-into-array.bash".

declare -a cheeses=("cheddar" "swiss" "gouda" "edam")

# Sample 1, iterate over elements using Bash regex to match text
for cheese in "${cheeses[@]}"; do
  if [[ "$cheese" =~ ^[gG] ]]; then
    echo "$cheese"
  fi
done

declare -a some=(0 1 2 3)
declare -a somemore=(4 5 6 7 8)
declare -a evenmore=(9)

# Sample 2, concatenate arrays
declare -a numbers
numbers+=( "${some[@]}" "${somemore[@]}" "${evenmore[@]}" )

# output slice of array, start at 2 and retrieve 3 elements total (0-indexed)
(IFS=' '; echo "${numbers[@]:2:3}")
# output slice of array, all elements starting from 3 through end (inclusive, 0-indexed)
(IFS=' '; echo "${numbers[@]:8}")
echo "Wrote slices of strings from num_names_jp array to stdout" >&2

exit 0
