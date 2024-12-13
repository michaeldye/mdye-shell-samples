#!/usr/bin/env bash

set -u
set -o pipefail

# include common functions from project base
base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

# define useful vars for use in script
script=$(script_path "$base" "$0")
# work=$(workdir "$script")

# case 1: pass w/ required envvars set
export ENVVAR1="foo"
export ENVVAR2="goo"

execute "$script"; assert_return_code $? 0 || exit $?

# case 2: fails b/c not all envvars set
unset ENVVAR1
execute "$script"; assert_return_code $? 1
