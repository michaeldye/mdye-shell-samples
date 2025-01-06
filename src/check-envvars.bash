#!/usr/bin/env bash

# Each of the following envvars must be set or the command interpreter will
# error. The leading : is a noop; it's used here to prevent executing each
# envvar's value as a program
: "${ENVVAR1?}" "${ENVVAR2?}"

echo "$ENVVAR1 $ENVVAR2"

exit 0
