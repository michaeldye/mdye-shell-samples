#!/usr/bin/env bash

# Truncates data.dump to 0 without changing perms; creates file if it doesn't
# exist same as cat /dev/null > data.dump without the process fork b/c : is a
# builtin
: > data.dump

exit 0
