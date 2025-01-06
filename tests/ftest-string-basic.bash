#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

# note the use of tabs in the LA population line
read -r -d '' expected <<-'EOF'
	someword
	M
	MEW
	Los Angeles, California	3,819,702	2
	33
	Donny Kerabatsos (donny@hollywoodstarlanesfan.tld)
	lots of repeated spaces
	Los Angeles	California	93010
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$actual" "$expected"
