#!/usr/bin/env bash

set -u

BASE=$(dirname "$0")
source "$BASE/common.bash"

## Example 1

# makes inline group or "code block" (not really an "anonymous function" as
# some say b/c the vars are not local to the block without the use of the
# subshell)
sum=$({
  # shellcheck disable=SC2030
  v1=1
  v2=2
  echo $((v1+v2))
})

# N.B. this check if var is defined with "-v" is new since bash 4.2
# shellcheck disable=SC2031
[[ -v v1 ]] && {
  echo "ERROR: local var 'v1' from function defined in outer scope and shouldn't be" >&2
  exit 4
}

echo "sum: $sum"

## Example 2

# setup
of1=$(script_outfile "$0" "zurr.out")
echo -e "zurr\ndurr" > "$of1"


# code block with io redirection; we use the non-private var behavior to our
# advantage
{
  read -r line1
  read -r line2
} < "$of1"

echo "lines from file: $line1 \ $line2"


# Example 3

someval=9001
someotherval=$((someval*2))

of2=$(script_outfile "$0" "computed-vals.out")

# everything in the code block will get redirected to the file; note that the
# block runs in a subshell so we can't pipe to it and have a var in the block
# take the piped input.
{
  echo "Header"
  echo "Computed vals: $someval,$someotherval"
} > "$of2"

echo "Wrote values to local file $of2"

exit 0
