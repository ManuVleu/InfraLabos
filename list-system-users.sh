#!bin/bash
LEN_FILE=$(wc -l /etc/passwd | cut -d " " -f 1)
for ((i=1;i<=$LEN_FILE;i+=1));
do
GEBR=$(head -n $i /etc/passwd | tail -1 | cut -d ":" -f 1)
UID_G=$(head -n $i /etc/passwd | tail -1 | cut -d ":" -f 3)
if [[ $UID_G < 1000 ]]; then
echo $GEBR
echo $UID_G
fi
done
