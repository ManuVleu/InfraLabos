#!/bin/bash

# Usage: passphrase.sh [N] [WORDS]
# N = aantal woorden in wachtwoordzin (default = 4)
# WORDS = bestand dat woordenlijst bevat (default = /usr/share/dict/words)

set -o nounset
set -o errexit

n=4
wordlist_file="/usr/share/dict/words"

function usage {
  echo "Usage: passphrase.sh [N] [WORDS]"
  echo "N = aantal woorden in wachtwoordzin (default = 4)"
  echo "WORDS = bestand dat woordenlijst bevat (default = /usr/share/dict/words)"
}

function generate_passphrase {
  passphrase=$(shuf -n "$n" "$wordlist_file" | tr '\n' ' ')
  echo "${passphrase}"
}

function process_cli_args {
  if [ "$#" -gt 2 ]; then
    echo "Error: too many arguments provided" >&2
    usage
    exit 1
  fi

  for arg in "$@"; do
    case "$arg" in
    -h | --help)
        usage
        exit 0
        ;;
    -*)
        echo "Error: Invalid option $arg" >&2
        usage
        exit 1
        ;;
    *)
        if [ -f "$arg" ]; then
          wordlist_file=$arg
        else
          n=$arg
        fi
        ;;
    esac
  done
  generate_passphrase
}

function main {
  passphrase=$(process_cli_args "$@")
  echo "$passphrase"
}

main "$@"
