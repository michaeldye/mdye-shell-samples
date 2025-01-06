#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

# note the use of tabs in the LA population line
read -r -d '' expected <<-'EOF'
	1  The Man in Me                      Bob Dylan                          Dylan      3:08
	2  Her Eyes are a Blue Million Miles  Captain Beefheart                  Beefheart  2:54
	3  My Mood Swings                     Elvis Costello and Cait O'Riordan  Costello   2:10
	P1="Arthur Digby Sellers",P2="Malibu Police Chief",P3="Smokey",P4="Jackie Treehorn"
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$actual" "$expected"
