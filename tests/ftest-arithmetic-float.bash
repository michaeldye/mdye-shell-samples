#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

read -r -d '' expected <<-'EOF'
	17.92857
	17.929
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$actual" "$expected"
