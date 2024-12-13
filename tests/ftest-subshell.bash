#!/usr/bin/env bash

set -u
set -o pipefail

# include common functions from project base
base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

# define useful vars for use in script
script=$(script_path "$base" "$0")
work=$(workdir "$script")

# execute script in its own subshell in workdir

(execute "$script"); assert_return_code $? 0
