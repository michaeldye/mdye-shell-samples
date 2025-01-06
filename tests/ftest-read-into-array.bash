#!/usr/bin/env bash

# This is boilerplate test file content that is useful when defining a new test

set -u
set -o pipefail

# common functions
base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

# "script" is script under test
script=$(script_path "$base" "$0")

# "work" is the created workdir for the script
work=$(workdir "$script")

read -r -d '' input <<-'EOF'
	uno
	dos
	tres
	cuatro
	cinco
	one two three four five
	eins;zwei;drei;fier;funf
	ichi
	ni
	san
	shi
	go
EOF

read -r -d '' expected <<-'EOF'
	uno,dos,tres,cuatro,cinco
	one,two,three,four,five
	eins,zwei,drei,fier,funf
	ichi ni san shi go
EOF

# Exit on error; remove and check each assertion's result if script under test
# is expected to raise errors. Note that this must be done after we abuse the
# delimiter on read above
set -e

# Use fd 3 (normally unused) to output from tee so we can both capture stdout
# and display it on the console when the test is executed
exec 3>&1

# write to stdin

# Execute script in its own subshell in workdir
actual=$(execute "$script" <<<"$input" | tee /dev/fd/3); assert_return_code $? 0

# check stdout
assert_str "$actual" "$expected"
