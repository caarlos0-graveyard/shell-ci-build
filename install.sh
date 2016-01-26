#!/bin/bash
set -eo pipefail

linux() {
  local filename="shellcheck_0.3.7-5_amd64.deb"
  wget "http://ftp.debian.org/debian/pool/main/s/shellcheck/$filename"
  sudo dpkg -i "$filename"
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
