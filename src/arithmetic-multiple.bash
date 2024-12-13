#!/usr/bin/env bash

# multiple operations separated by , are evaluated; only the last is returned
t2=$((a = 9 * 2, a / 3))

echo "Result of calc: $t2" >&2
echo "$t2"
exit 0
