#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

set -e

(execute "$script"); assert_return_code $? 0

assert_num "$(stat -c "%s" "$work"/data.dump)" 0
