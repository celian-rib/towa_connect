#! /bin/bash

source config.sh

towaScriptsSrc="${mainPath}/src/towa" 
towaTestsSrc="${mainPath}/test/towa"

echo -en "\e[36m" # Cyan
cat splashscreen.txt

echo -en "\e[90m" # grey

[ -d "towa" ] &&  rm -r towa

mkdir towa
cp $towaScriptsSrc/*.java towa
cp $towaTestsSrc/*.java towa

ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  rm sortie.log
  rm -r towa
EOF

rsync -r ./towa $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot

rm -r towa

ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  
  echo -en "\e[92mEn attente de sortie.log : \e[33m["
  while [ ! -f sortie.log ]
  do 
    echo -ne "▄"
    sleep 0.5
    echo -ne "▀"
    sleep 0.5
  done
  echo "]"
EOF

echo

counter=0

echo -en "\e[92mContenu en attente       : \e[33m["
while (( $counter < 20 ))
do 
  echo -ne "▄"
  sleep 0.5
  echo -ne "▀"
  sleep 0.5
  counter=$counter+1
done
echo "]"

rsync -r $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot/sortie.log ./

echo
echo -en "\e[37m"

if tail -n 1 sortie.log | grep -q validé 
then 
  echo -e "\e[36m";
  grep validé sortie.log
else
  cat sortie.log 
fi
