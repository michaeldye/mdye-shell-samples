#!/usr/bin/env bash
set -u

# linux-only realpath used
PROJ_BASE=$(realpath "$(dirname "$0")"/../)
source "$PROJ_BASE/lib/common.bash"

function usage() {
  echo "$0 test_dir"
}

(($# != 1)) && {
  echo "ERROR: missing required arg" >&2
  usage >&2
  exit 4
}

test_scripts="$1"; shift

total=0
failures=0

echo "NOTE: Set envvar 'DEBUG=y' to enable Bash trace capture to stderr"
echo "NOTE: All stdout and stderr output from test execution is written to a workdir adjacent to the test" >&2

for test in "$(realpath "$test_scripts")"/*.bash; do
  sp=$(script_path "$PROJ_BASE" "$test")
  work=$(workdir "$test")
  printf "%-50s " "$(basename "$test")" >&2

  if execute "$test" "$sp" > "$work"/stdout 2> "$work"/stderr; then
    echo "PASS" >&2
  else
    failures=$((failures+1))
    echo "FAIL" >&2
  fi
  total=$((total+1))
done

echo "Summary: $((total-failures))/$total tests succeeded" >&2

if [[ "failures" -gt 0 ]]; then
  echo "ERROR: test failures occurred." >&2
fi

exit $failures
