#!/usr/bin/env bash

# v only avail in subshell
# exit code from subshell captured for eval
(v="zurm"; echo "Value in subshell $v"; [[ "$v" == "foo" ]]; exit $?)
co=$?

if ((co != 0)); then
  echo "INFO: subshell exited with code $co, which is what we expect" >&2
else
  echo "ERROR: subshell exited with unexpected code" >&2
  exit 4
fi


exit 0
