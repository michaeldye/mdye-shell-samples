#!/usr/bin/env bash

set -u

## Example 1

# Makes inline group or "code block" (not really an "anonymous function" as
# some say b/c the vars are not local to the block without the use of the
# subshell)
sum=$({
  # shellcheck disable=SC2030
  v1=1
  v2=2
  echo $((v1+v2))
})

# "-v" is used to check if variable is defined
# shellcheck disable=SC2031
[[ -v v1 ]] && {
  echo "ERROR: local var 'v1' from function defined in outer scope and shouldn't be" >&2
  exit 4
}

echo "$sum"
echo "Wrote sum to stdout" >&2

## Example 2

# Setup
of1="zurr.out"

echo -e "zurr\ndurr" > "$of1"
echo "Wrote content of file $of1 to stdout" >&2

# Code block with io redirection; we use the non-private var behavior to our
# advantage
{
  read -r word1
  read -r word2
} < "$of1"

echo "$word1 $word2"
echo "Output words read from $of1" >&2

## Example 3

# Setup
someval=9001
someotherval=$((someval*2))

of2="computed-vals.out"

# Output from the code block is redirected to the file; note that the block runs
# in a subshell so we can't pipe to it and have a var in the block take the
# piped input.
{
  echo "Header"
  echo "$someval,$someotherval"
} > "$of2"

# We read the line back for ftest
tail -n1 "$of2"
echo "Wrote compute values to local file $of2 with header addition" >&2

exit 0
