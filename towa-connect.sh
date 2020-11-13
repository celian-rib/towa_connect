#! /bin/bash

# (A MODIFIER)
iutuser='IUTUSERNAME_TOCHANGE' 

#Dossier contenant les classes principales dans le projet netbeans (A MODIFIER)
towaScriptsSrc='/mnt/c/Users/celia/Documents/NetBeansProjects/Towa/src/towa' 
#Dossier contenant les tests dans le projet netbeans (A MODIFIER)
towaTestsSrc='/mnt/c/Users/celia/Documents/NetBeansProjects/Towa/test/towa'

clear

cat splashscreen.txt

echo ""

echo "---------------------------"
echo "Source folders : "
echo $towaScriptsSrc
echo $towaTestsSrc
echo "---------------------------"

echo ""

rm -r towa

echo "- creating output folder"
mkdir towa
cp $towaScriptsSrc/*.java towa
cp $towaTestsSrc/*.java towa
echo "- output folder filled with scripts"

echo ""

echo "---------------------------"
echo "output folder content : "
ls -n towa
echo "---------------------------"

echo "Connecting to delete actual files"
#Revers tunnel
ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  echo "---------------------------"
  echo "removing sortie.log :"
  rm sortie.log
  echo "removing actual towa folder :"
  rm -r towa
  echo "---------------------------"
EOF

echo "Connecting to send new files"
rsync -rv --progress ./towa $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot

rm -r towa

echo "COMPLETE"
