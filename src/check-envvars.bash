#!/usr/bin/env bash

# each of the following must be set or the command interpreter will barf
# the trailing : is a noop used in this case to prevent executing each ENVVAR's value as a program
: "${ENVVAR1?}" "${ENVVAR2?}"

echo "$ENVVAR1 $ENVVAR2"

exit 0
