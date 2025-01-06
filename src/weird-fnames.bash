#!/usr/bin/env bash

# N.B. Output to stdout is evaluated by tests, stderr is context for humans.

_() {
  echo "function with name _ is a little less weird" >&2
}

:() {
  echo "def of function named : looks like a monkey" >&2
}

: || exit 3
_ || exit 4

exit 0
