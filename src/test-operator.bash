#!/usr/bin/env bash

# See https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html and https://www.baeldung.com/linux/bash-single-vs-double-brackets.

# Notes:
# [] is POSIX compliant, [[]] is not. Lots of the below conveniences don't work
# with [].


# Sample 1

# Setup
val=3

if [[ "$val" -eq 3 ]] && false; then
  echo "Bug: this should not be reached" >&2
  exit 4
fi

# Deceptively similar to the former, but broken; [[ false ]] is true. Note that
# the following would also be evaluated to true: 0, 1, "0".

# shellcheck disable=SC2158
if [[ "$val" -eq 3 && false ]]; then
  echo "Tricky programmer mistake, the false here is evaluated to true by test"
else
  echo "Bug: this should not be reached" >&2
  exit 5
fi

# shellcheck disable=SC2050
if [[ "zurr" == "DOY" || "9" -lt "12" ]]; then
  echo "Bash test permits || in expression" >&2
else
  echo "Bug: this should not be reached" >&2
  exit 6
fi


# shellcheck disable=SC2050
if [[ (444 -eq 2 && 99 -gt 3) || "foo" == "foo" ]]; then
  echo "Bash test permits unescaped ()'s to group operations in expression" >&2
else
  echo "Bug: this should not be reached" >&2
  exit 7
fi

exit 0
