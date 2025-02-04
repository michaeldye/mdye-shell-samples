#!/usr/bin/env bash
set -u

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

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

if [[ "${DEBUG:=}" ]]; then
  echo "NOTE: 'DEBUG' on so Bash tracing is on and will be redirected to a test's stderr capture"
else
  echo "NOTE: 'DEBUG' not on. Set envvar 'DEBUG=y' to enable Bash tracing if desired"
fi

echo "NOTE: All stdout and stderr output from test execution is written to a workdir adjacent to the test" >&2
declare -a testjobs

# TODO: implement some job pooling here w/ a max forks option
for test in "$(realpath "$test_scripts")"/*.bash; do
  sp=$(script_path "$base" "$test") || {
    echo -e "\nERROR: Script modified while setting up test: $test" >&2
    exit 55
  }
  work=$(workdir "$test")

  (execute "$test" "$sp" > "$work"/stdout 2> "$work"/stderr; exit $?) &
  testjobs[$!]="$test"
  printf "."
  total=$((total+1))
done

echo ""

failures=0

# check testjobs, wait if necessary
for job in "${!testjobs[@]}"; do
  wait "$job" || {
    failures=$((failures+1))
    echo "FAILURE: $(basename "${testjobs[$job]}")" >&2
  }
done


echo "Test summary: $((total-failures))/$total tests succeeded" >&2

exit $failures
