#!/usr/bin/env bash

# Multiple operations separated by comman are evaluated; only the last is
# returned
t2=$((a = 9 * 2, a / 3))

echo "Result of calc: $t2" >&2
echo "$t2"

exit 0
