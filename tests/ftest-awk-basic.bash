#!/usr/bin/env bash

set -u
set -o pipefail

base=$(realpath "$(dirname "$0")"/../)
source "$base/lib/common.bash"

script=$(script_path "$base" "$0")

work=$(workdir "$script")

read -r -d '' expected <<-'EOF'
	Aachen: 50.775000,6.083330
	Aarhus: 56.183330,10.233330
	Abee: 54.216670,-113.000000
	Acapulco: 16.883330,-99.900000
	Achiras: -33.166670,-64.950000
	Adhi Kot: 32.100000,71.800000
	Adzhi-Bogdo (stone): 44.833330,95.166670
	Agen: 44.216670,0.616670
	Aguada: -31.600000,-65.233330
	Aguila Blanca: -30.866670,-64.550000
	Aioun el Atrouss: 16.398060,-9.570280
	Aïr: 19.083330,8.383330
	Aire-sur-la-Lys: 50.666670,2.333330
	Akaba: 29.516670,35.050000
EOF

set -e

exec 3>&1
actual=$(execute "$script" | tee /dev/fd/3); assert_return_code $? 0

assert_str "$actual" "$expected"
