#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if [ "${#}" -eq "0" ]; then
  echo "No arguments given";
  exit 1;
fi

for i in "${@}";
do
  if [ ! -d "${HOME}/.trash" ]; then
    mkdir ~/.trash
    echo "Created directory ${HOME}/.trash"
  fi
  if [ -f "${i}" ]; then
    if [ ! -L "${i}" ]; then
      gzip "${i}"
      mv -v "${i}.gz" "${HOME}/.trash"
    else
     echo "File is a link, won't be removed"
    fi
  else
    echo "File is not a file"
  fi  
  shift
done

find /home/osboxes/.trash -type f -mtime +14 -exec rm -v "${i}" {} \;
