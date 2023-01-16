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
  tar -czf "$dest_dir"/"$source_dir"_"$timestamp".tar.gz "$source_dir"
}

function process_cli_args {
    if [ $# -gt 2 ]; then
        echo "Error: too many arguments provided" >&2
        usage
        exit 1
    fi

    for arg in "$@"; do
        case "$arg" in
        -h | --help | -\?)
            usage
            exit 0
            ;;
        -d | --destination)
            shift
            dest_dir=$1
            ;;
        -*)
            echo "Error: Invalid option $arg" >&2
            usage
            exit 1
            ;;
        *)
            source_dir=$arg
            ;;
        esac
    done
    create_backup
}

function main {
    create_backup "$@"
}

main "$@"
