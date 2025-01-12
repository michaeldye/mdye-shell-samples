#!/usr/bin/env bash

set -uo pipefail

base=$(realpath "$(dirname "$0")"/../)

function usage() {
  echo "$0 make_target"
}

(($# != 1)) && {
  echo "ERROR: missing required arg" >&2
  usage >&2
  exit 4
}

targ="$1"; shift
echo "INFO: Continually watching for changes in $(realpath "$base") and executing make target: $targ" >&2

while true; do
  while inotifywait -e close_write -r "$base"; do
    make "$targ"
  done
done
