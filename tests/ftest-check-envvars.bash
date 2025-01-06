#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

# case 1: pass w/ required envvars set
export ENVVAR1="foo"
export ENVVAR2="goo"

execute "$script"; assert_return_code $? 0 || exit $?

# case 2: fails b/c not all envvars set
unset ENVVAR1
execute "$script"; assert_return_code $? 1
