#!/usr/bin/env bash
# Grant that custom checks are working.
set -eo pipefail

# shellcheck disable=SC1091
source ./build.sh

# Lint the build script
echo "Linting the build.sh script..."
check ./build.sh

# Test that we find the correct amount of files.
echo -e "\nValidating the result of find_cmd()..."
files=$(eval "$(find_cmd)")
files_count=$(echo "$files" | wc -l)

expected_files_count=8
if (( files_count == expected_files_count )); then
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] Found the expected number of files (%s)\n" $expected_files_count
else
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] Build scripts’s find_cmd didn’t find the expected number of files (%s)\n" $expected_files_count
  printf "\r\033[2K         Files found:\n"
  for file in $files; do
    printf "\r\033[2K         - %s\n" "$file"
  done
  exit 1
fi

exit 0
