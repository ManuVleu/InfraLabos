#!/bin/bash

if [ ${#} == '0' ];
then
  column -t 7 -s ":" /etc/passwd | sort -k 1;
elif [ "${1}" -ge  1 ] && [ "${1}" -le 7 ]; then
  echo "${1}";
  if [ "${1}" -eq 3 ] || [ "${1}" -eq 4 ];  then 
    column -t 7 -s ":" /etc/passwd | sort -n -k "${1}";
    else
    column -t -s ":" /etc/passwd | sort -k "${1}";
  fi
else 
echo "Argument needs to be between 1 and 7 (included)";
exit 1;
fi
