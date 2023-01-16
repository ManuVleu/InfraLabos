#!/bin/bash

set -o nounset
set -o errexit

dest_dir="/tmp"
source_dir="$HOME"

function usage {
  echo "Usage: backup.sh [OPTIES] [DIR]"
  echo "-h|-?|--help = drukt uitleg over commando af"
  echo "-d|--destination = bestemming van backup"
  echo "DIR = bronmap van backup"
}

function create_backup {
  # Current timestamp
  timestamp=$(date +%Y%m%d%H%M)
  echo "$timestamp"
  #tar -czf "$dest_dir"/backup_"$timestamp".tar.gz "$source_dir"
}

function main {
    create_backup "$@"
    echo "$?"
}

main "$@"
