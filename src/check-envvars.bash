#!/usr/bin/env bash

set -u

# Each of the following envvars must be set or the command interpreter will
# error and exit. The leading : is a noop; it's used here to prevent executing
# each envvar's value as a program. Note that this is true regardless of whether
# "set -u" was given or not.
: "${ENVVAR1?}" "${ENVVAR2?}" # "${NOVAL?}"

echo "$ENVVAR1 $ENVVAR2"

# When checking to see if an envvar is set or not but you don't want to fail
# the program, us parameter substitution's default value syntax with a null
# default value that Bash evaluates to false. For more info, see:
# https://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02.html#tag_02_06_02
unset NOVAL
if [[ "${NOVAL:=}" ]]; then
  echo "Test of null value failed us by evaluating true when NOVAL is unset" >&2
  exit 6
else
  echo "Test of null value acts as we expected by evaluating false when NOVAL is unset" >&2
fi

# Test reverse of above by setting HASVAL with export to a string and expecting
# it to evaluate to true.
export HASVAL="someval"
if [[ "${HASVAL:=}" ]]; then
  echo "Test of non-null value succeeded by evaluating true when HASVAL is set to a string value" >&2
else
  echo "Test of non-null value failed us... when HASVAL='${HASVAL}'" >&2
  exit 7
fi

# Test as above but with tricky values. Note that even when using `set -u`, all
# of the following have undesirable behavior *in that they evaluate true just
# like a proper string value does*:
#
# case: bare null
export TRICKYVAL=null
if [[ "${TRICKYVAL:=}" ]]; then
  echo "Bare null TRICKYVAL looks set" >&2
else
  exit 8
fi

# case: bare false
export TRICKYVAL=false
if [[ "${TRICKYVAL:=}" ]]; then
  echo "Bare false TRICKYVAL looks set" >&2
else
  exit 9
fi

# case: 0
export TRICKYVAL=0
if [[ "${TRICKYVAL:=}" ]]; then
  echo "0 TRICKYVAL looks set" >&2
else
  exit 10
fi

# On the other hand, the following have expected behavior w/r/t checking if an
# envvar is defined:

# case: empty value
export TRICKYVAL=
if [[ "${TRICKYVAL:=}" ]]; then
  exit 11
else
  echo "Phew, empty TRICKYVAL looks *unset* to test" >&2
fi

# case: empty string
export TRICKYVAL=""

if [[ "${TRICKYVAL:=}" ]]; then
  exit 12
else
  echo "Phew, empty string TRICKYVAL looks *unset* to test" >&2
fi

exit 0
