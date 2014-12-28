shell-travis-build
==================

A submodule to your shell projects travis build, linting with shellcheck.

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
