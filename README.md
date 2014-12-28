shell-travis-build [![Build Status](https://travis-ci.org/caarlos0/shell-travis-build.svg?branch=master)](https://travis-ci.org/caarlos0/shell-travis-build)
==================

A submodule to your shell projects travis build, linting with shellcheck.

## Build

- The `install.sh` script will install shellckeck.
- The `build.sh` will lint all executable files with shellcheck, avoiding
Ruby, compdef and the like files. The max depth is 2.

## Usage

```sh
git submodule add https://github.com/caarlos0/shell-travis-build.git build
cp build/travis.yml.example .travis.yml
```

Or tweak your `.travis.yml` to be like this:

```yml
language: bash
install:
  - ./build/install.sh
script:
  - ./build/build.sh
```
