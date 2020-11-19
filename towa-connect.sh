#! /bin/bash

#ELEMENTS A MODIFIER
#============================================================================

#Nom d'utilisateur de l'iut a changer (exemple : criboulet)
iutuser='USERNAME'

#Dossier source du projet a changer pour votre configuration:
mainPath='/mnt/c/Users/nomutilisateur/Documents/NetBeansProjects/Towa';

#============================================================================

towaScriptsSrc="${mainPath}/src/towa" 
towaTestsSrc="${mainPath}/test/towa"

cat splashscreen.txt

rm -r towa

echo "- creating output folder"
mkdir towa
cp $towaScriptsSrc/*.java towa
cp $towaTestsSrc/*.java towa
echo "- output folder filled with scripts"

echo

echo "Connecting to delete actual files"


#Revers tunnel
ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  echo "---------------------------"
  echo "removing sortie.log"
  rm sortie.log
  echo "removing actual towa folder"
  rm -r towa
  echo "---------------------------"
EOF

echo "Connecting to send new files"

rsync -r ./towa $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot

rm -r towa


echo "Connecting to retrieve sortie.log"
#Revers tunnel
ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  echo "---------------------------"

  echo "waiting for sortie.log to get created"
  while [ ! -f sortie.log ]
  do 
    echo -n "."
    sleep 0.2
  done

  echo
  echo "-----sortie.log created----"

  echo "waiting for sortie.log to get filled"

  # notfound=1

  # while (( notfound )); do
  
  #   wc -l sortie.log | cut -f 1 -d " "

  #   #if [[ $size -gt 0 ]]; then
  #   #  notfound=0;
  #   #fi 

  #   # echo -n "/"
    
  #   sleep 0.2
  # done

  #SLEEP DE LA DEFAITE
  sleep 20

  echo
  echo "-----sortie.log filled----"
EOF

rsync -r $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot/sortie.log ./

cat sortie.log

echo "COMPLETE ;)"
