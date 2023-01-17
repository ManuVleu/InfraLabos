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
  dir="$dest_dir/"
  dir+=$(basename "$source_dir")
  dir+="-$timestamp.tar.gz"
  tar -czf "$dir" "$source_dir" > "$dest_dir/backup-$timestamp.log" 2> "$dest_dir/backup-$timestamp.log"
}

function process_cli_args {
    if [ $# -gt 3 ]; then
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
            if ! [ -d "$1" ]; then
              echo "Error: destination directory doesn't exist" >&2
              exit 1
            fi
            dest_dir=$1
            ;;
        -*)
            echo "Error: Invalid option $arg" >&2
            usage
            exit 1
            ;;
        *)
            if [ -d "$arg" ]; then
              source_dir=$arg
            else
              echo "Error: source directory doesn't exist" >&2
              exit 1
            fi
            ;;
        esac
    done
    create_backup
}

function main {
    process_cli_args "$@"
}

main "$@"
