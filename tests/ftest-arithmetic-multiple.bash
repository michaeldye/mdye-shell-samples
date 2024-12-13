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
value=$(execute "$script"); assert_return_code $? 0

# assert answer we expected
assert_num "$value" 6
