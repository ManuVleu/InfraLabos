#!/usr/bin/env bash
set -o errexit
set -o nounset

n=4
wordlist_file=/usr/share/dict/words

generate_passphrase() {
  n=$1
  wordlist=$2

  passphrase=$(shuf -n "$n" "$wordlist")

  printf "%s\n" "$passphrase"
}

process_cli_args() {
  if [[ $# -gt 2 ]]; then
    >&2 printf "Error: at most two arguments expected, got $#\n"
    >&2 usage
    exit 1
  fi

  while [[ $# -gt 0 ]]; do
    case $1 in
      -h|--help)

        usage
        exit 0
        ;;
      -*)
     
        >&2 printf "Error: invalid option: %s\n" "$1"
        >&2 usage
        exit 1
        ;;
      *)

        if [[ -f "$1" ]]; then
          wordlist_file="$1"
        elif [[ "$1" =~ ^[0-9]+$ ]]; then
          n="$1"
        else
          >&2 printf "Error: invalid argument: %s\n" "$1"
          >&2 usage
          exit 1
        fi
        ;;
    esac
    shift
  done
}

usage() {
  printf "Usage: passphrase.sh [-h|--help] [N] [WORDS]\n"
}

main() {
  process_cli_args "$@"
  printf "%s\n" "$wordlist_file"
  generate_passphrase "$n"
}

main "$@"
