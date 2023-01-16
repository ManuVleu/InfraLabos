#!/bin/bash

set -o nounset
set -o errexit

# Define default values
destination_dir="/tmp"
source_dir=$HOME

# Process command line options
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -h|-\?|--help)
    echo "Usage: backup.sh [OPTIONS] [DIR]"
    echo "Options:"
    echo "  -h, -?, --help                 Print this help message and exit"
    echo "  -d, --destination DIR          The directory where the backup will be written to. Default is /tmp"
    echo "  DIR                            The directory to be backed up. Default is the current user's home directory."
    exit 0
    ;;
    -d|--destination)
    destination_dir="$2"
    shift
    ;;
    *)
    source_dir="$1"
    ;;
esac
shift
done

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    >&2 echo "Error: source directory $source_dir does not exist"
    exit 1
fi

# Check if destination directory exists
if [ ! -d "$destination_dir" ]; then
    >&2 echo "Error: destination directory $destination_dir does not exist"
    exit 1
fi

# Get the current timestamp
timestamp=$(date +%Y%m%d%H%M)

# Create the archive file name
archive_file="$(basename "$source_dir")-$timestamp.tar.bz2"

# Create the log file name
log_file="backup-$timestamp.log"

# Perform the backup
tar -cjvf "$destination_dir/$archive_file" "$source_dir" &> "$destination_dir/$log_file"

# Check for errors
if [ $? -ne 0 ]; then
    >&2 echo "Error: backup failed. See $destination_dir/$log_file for more information."
    exit 1
else
    echo "Backup completed successfully. Archive file: $destination_dir/$archive_file, Log file: $destination_dir/$log_file"
fi