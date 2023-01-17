#!/bin/bash

names_str=$(ip link | cut -d " " -f 2 | awk '(NR>1)')
names=("$names_str")
states_str=$(ip link | cut -d " " -f 9 | awk '(NR>1)')
states=("$states_str")


for (( i=0; i<${#names[@]}; i++ ));
do
  echo "${names[$i]}"
  echo "${states[$i]}"
  ip a l "${names[$i]:-1}" | awk '/inet/ {print $2}'
  echo ""
done
