#!/bin/bash
set -eo pipefail

linux() {
  hash shellcheck 2>/dev/null || { echo >&2 "I require shellcheck but it wasn’t installed. Aborting."; exit 1; }
}

osx() {
  brew update
  brew install shellcheck
}

if [ "$(uname -s)" = "Darwin" ]; then
  osx
else
  linux
fi
