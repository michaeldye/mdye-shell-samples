#!/usr/bin/env bash

set -u
set -o pipefail

# include common functions from project base
base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

# define useful vars for use in script
script=$(script_path "$base" "$0")
work=$(workdir "$script")

# Remove and check each assertion's result if script under test is expected
# to raise errors
set -e

# execute script in its own subshell in workdir

(execute "$script"); assert_return_code $? 0

assert_num "$(stat -c "%s" "$work"/data.dump)" 0
