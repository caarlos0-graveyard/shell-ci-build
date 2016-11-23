#!/bin/bash
set -eo pipefail

linux() {
  local url="https://github.com/caarlos0/shellcheck-docker/releases/download/v0.4.5/shellcheck"
  if which sudo >/dev/null 2>&1; then
    sudo curl -Lso /usr/bin/shellcheck "$url"
  else
    curl -Lso /usr/bin/shellcheck "$url"
  fi
  sudo chmod +x /usr/bin/shellcheck
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
