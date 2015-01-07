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

check_all_executables() {
  echo "Linting all executables with maxdepth=2..."
  find . -maxdepth 2 -type f -perm +111 | grep -v "\.git" | while read script; do
    head=$(head -n1 "$script")
    [[ "$head" = "#!/usr/bin/env ruby" ]] && continue
    [[ "$head" =~ ^#compdef.* ]] && continue
    check "$script"
  done
}

check_all_executables
