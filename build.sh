#!/usr/bin/env bash
set -eo pipefail
[[ "${DEBUG:-}" ]] && set -x

success() {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] Linting %s...\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] Linting %s...\n" "$1"
  exit 1
}

check() {
  local script="$1"
  shellcheck "$script" || fail "$script"
  success "$script"
}

find_prunes() {
  local prunes="! -path './.git/*'"
  if [ -f .gitmodules ]; then
    while read -r module; do
      prunes="$prunes ! -path './$module/*'"
    done < <(grep path .gitmodules | awk '{print $3}')
  fi
  echo "$prunes"
}

find_cmd() {
  # GNU `find` dropped compatibility support for the `+` syntax with 4.5.12 (release 2013), it
  # instead uses `/` which has been supported for a long time. BSD `find` however still used `+`.
  local perm_format_specifier="/"
  if [ "$(uname -s)" = "Darwin" ]; then
    perm_format_specifier="+"
  fi

  echo "find . -type f -and \( -perm ${perm_format_specifier}111 -or -name '*.sh' \) $(find_prunes)"
}

check_all_executables() {
  echo "Linting all executables and .sh files, ignoring files inside git modules..."
  eval "$(find_cmd)" | while read -r script; do
    head=$(head -n1 "$script")
    [[ "$head" =~ .*ruby.* ]] && continue
    [[ "$head" =~ .*zsh.* ]] && continue
    [[ "$head" =~ ^#compdef.* ]] && continue
    check "$script"
  done
}

if [[ "$0" == "${BASH_SOURCE[0]}" ]]; then
  check_all_executables
fi
