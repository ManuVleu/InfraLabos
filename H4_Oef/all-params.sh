#!/bin/bash
if [ ${#} == '0' ]
then
  echo "Geen argumenten opgegeven";
  exit 1; 
fi

for i in $(seq ${#});
do
  echo ${1}
  shift
done
