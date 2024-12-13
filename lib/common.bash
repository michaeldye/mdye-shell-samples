# a bash lib

set -u

function workdir() {
  local script_path=$1; shift

  local workdir

  workdir="$script_path.workdir"
  mkdir -p "$workdir"
  echo "$workdir"
}

function script_outfile() {
  # script_name is expected to be the name of the script under test; we'll
  # write it to a common output dir named after the script that is a sibling
  # of it on the fs
  local script_name=$1; shift
  local outfile_name=$1; shift

  echo "$(workdir "$script_name")/$outfile_name"
}

function script_path() {
  local proj_base_dir=$1; shift
  local test_path=$1; shift

  local expected_script_name sp

  expected_script_name=$(basename "$test_path" | grep -oP "ftest-\K(.*)")
  sp=$(realpath "$proj_base_dir/src/$expected_script_name")

  [[ -e "$sp" ]] || {
    echo "ERROR: Missing expected script at path $sp" >&2
    return 3
  }

  echo "$sp"
}

function execute() {
  local script="$1"; shift
  local args="$*"

  local work
  work=$(workdir "$script")

  if [[ "${DEBUG:-no}" != "no" ]]; then
    OPTS="xtrace"
  else
    OPTS=""
  fi

  (cd "$work" || exit 2; \
    env SHELLOPTS=$OPTS "$script" "$args")
  return $?
}

function assert_return_code() {
  local code="$1"; shift
  local expected="$1"; shift

  assert_num "$code" "$expected" && {
    return 0
  }

  echo "ERROR: System under test had unexpected exit code: $code. Wanted: $expected" >&2
  return "$code"
}

function assert_str() {
  local actual="$1"; shift
  local expected="$1"; shift

  [[ "$actual" == "$expected" ]] && {
    return 0
  }

  echo -e "Error: Actual and expected values differ. Diff:\n$(diff <(echo "$actual") <(echo "$expected"))" >&2
  return 3
}

function assert_num() {
  local actual="$1"; shift
  local expected="$1"; shift

  ((actual == expected)) && {
    return 0
  }

  echo -e "Error: Actual and expected values differ:\n$actual $expected" >&2
  return 3
}

function assert_byte_qty() {
  local file="$1"; shift
  local expected_bytes="$1"; shift

  [[ -e "$file" ]] && [[ $(stat -c "%s" "$file") -eq "$expected_bytes" ]] && {
    return 0
  }
  return 3
}
