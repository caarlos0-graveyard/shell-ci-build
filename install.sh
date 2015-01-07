#!/bin/bash
set -eo pipefail

main() {
  local filename="shellcheck_0.3.5-2_amd64.deb"
  wget "http://ftp.debian.org/debian/pool/main/s/shellcheck/$filename"
  sudo dpkg -i "$filename"
}

main
