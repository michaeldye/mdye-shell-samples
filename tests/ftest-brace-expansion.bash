#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

read -r -d '' expected <<-EOF
	0
	1
	2
	3
	A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9
	1
	2
	3
	4
	5
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$(cat "$work/0.txt")" "0"
assert_str "$(cat "$work/1.txt")" "1"
assert_str "$(cat "$work/2.txt")" "2"
assert_str "$(cat "$work/3.txt")" "3"

assert_str "$actual" "$expected"
