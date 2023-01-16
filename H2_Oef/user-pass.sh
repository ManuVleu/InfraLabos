#!/bin/bash
set -o nounset;
set -o errexit;

employees_file='employees.csv'
output_file='user-pass.csv'
usernames_file='usernames.txt'
passwords_file='passwords.txt'

num_employees=$(wc -l $employees_file | cut -d " " -f1);

#generating new passwords for users
apg -n $num_employees -m 15 -x 15 -M NCL > $passwords_file;

#generating usernames
awk '(NR>1)' $employees_file | cut -d "," -f 4-5 | iconv -t ASCII//TRANSLIT | tr [:upper:] [:lower:] | tr "," " " | awk {'print $1 substr($2,1,1) substr($3,1,1) substr($4,1,1)'} > $usernames_file;

#voeg zowel usernames als passwoorden toe aan een nieuwe file
paste -d ',' $usernames_file $passwords_file > $output_file;

#verwijderd de tussenresultaten
rm $usernames_file;
rm $passwords_file;


