#!/usr/bin/env bash

script=$(realpath "$(dirname "$0")")

# See also "test-operator.bash".
# See https://tldp.org/LDP/abs/html/x17129.html and https://computing.stat.berkeley.edu/tutorial-using-bash/regex.html.


# Sample 1

# Setup
word_yes="yes"

if [[ "$word_yes" =~ ^[yY] ]]; then
  echo "Flexible yes"
else
  echo "Bug: regex character class expected to work" >&2
  exit 2
fi


# Sample 2

# Setup
word_no="no"

if [[ "$word_no" =~ ^[nN]$ ]]; then
  echo "Bug: regex word ending not respected"
else
  echo "Hard n/N"
fi


# Sample 3, regex with grep

# Setup
infile1="$script"/regex-basic.input1.txt; [[ -f "$infile1" ]] || exit 4

grep -v 'nologin' <"$infile1"
echo "Reported presidents who have assigned shells" >&2

# The grep tool uses BRE (basic regex) by default which doesn't support:
# character class references like \d, requires escaping parens in the capture
# groups, and can't take repeat quantities (cf.
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html). Use
# the Perl regex (-P) option to get advanced regex behavior. Note that
# busybox's grep doesn't have this support.

grep -vP '\w+:x:([\d]{2,}):\1' <"$infile1" | cut -d ':' -f1,5
echo "Reported presidents' usernames who don't have own GIDs" >&2

# Notably, the reference to the captured group, "\1", *does* work in BRE too.

exit 0
