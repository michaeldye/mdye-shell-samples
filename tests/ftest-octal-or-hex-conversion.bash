#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

read -r -d '' expected <<-'EOF'
	61
	75
	117
	075, 0x75
	61, 117
	A
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$actual" "$expected"
