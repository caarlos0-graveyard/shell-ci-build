#!/bin/bash
set -eo pipefail

linux() {
  sudo apt-get update
  sudo apt-get install -y shellcheck
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
