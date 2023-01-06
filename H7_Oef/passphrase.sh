#!/bin/bash
set -o nounset
set -o errexit

case ${#} in
  "0")
    passphrase
  ;;
  "1")
    if [ ${1} in "-h" | "--help" ]; then
      help
    fi
  ;;
  "2")
    passphrase ${1} ${2}
  ;;
  *)
    echo "There can not be more than 2 parameters. Use -h to get more info" >&2
  ;;
esac


passphrase() {
echo "params${1}"
length=$(cat /usr/share/dict/words | wc -l)
passphrase=''
for i in {1..4};
do
  rnd_nr=$(( ${RANDOM} % ${length} + 1 ))
  passphrase=${passphrase}' '$(sed -n "${rnd_nr}p" /usr/share/dict/words)
done

echo ${passphrase}
}

help() {
echo "Deze functie geeft een wachtwoordszin terug"
echo "Zonder parameters 4 woorden van /usr/share/dict/words"
echo "-h: Drukt deze tekst af"
echo "passphrase.sh [N] [WORDS]: N = aantal woorden in wachtwoordzin(def=4)"
echo "				 WORDS = bestand waarvan woorden wordt gebruikt(def=/usr/share/dict/words)"

}


