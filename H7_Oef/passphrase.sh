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
  return ${passphrase::-1}
}

function process_cli_args {
  echo 'process cli'
}

function main {
  generate_passphrase
  echo "$?"
}

main
