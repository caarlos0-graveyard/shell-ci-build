#!/usr/bin/env bash
# Grant that custom checks are working.
set -eo pipefail
# shellcheck disable=SC1091
source ./build.sh
check ./build.sh
