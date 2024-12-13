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

# N.B. we must set -e after this b/c failing to hit the delim given to read
# causes an error
read -r -d '' expected <<-'EOF'
	61
	75
	117
	075, 0x75
	61, 117
	A
EOF

set -e

actual=$("$script"); assert_return_code $? 0

assert_str "$actual" "$expected"
