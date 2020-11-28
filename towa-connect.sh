#! /bin/bash
# ======================================================================================
# Fonctionnement :
# - Creation d'un dossier towa (Supprimé au préalable si il existe).
# - Copie des *.java se trouvants dans les dossier test et src dans un dossier "towa".
# - Connexion au serveur pour supprimer sortie.log et le dossier towa existant.
# - Connexion au serveur pour envoyer le dossier towa créé précedemment.
# - Connexion au serveur pour attendre la création du fichier sortie.log
# - Connexion au serveur pour attendre le remplissage du fichier sortie.log
# - Connexion au serveur pour récuperer le fichier sortie.log
# ======================================================================================


source config.sh # Récupère les variables du fichier config.sh

towaScriptsSrc="${mainPath}/src/towa" # Chemin d'accès du dossier src du projet netbeans
towaTestsSrc="${mainPath}/test/towa" # Chemin d'accès du dossier test du projet netbeans

echo -en "\e[36m" # Cyan
cat splashscreen.txt

echo -en "\e[90m" # grey

# Supression du dossier towa dans le cas ou il existe
[ -d "towa" ] &&  rm -r towa 

[ -f sortie.log ] &&  rm sortie.log

# Creation du dossier towa puis remplissage de ce dernier
mkdir towa
cp $towaScriptsSrc/*.java towa
cp $towaTestsSrc/*.java towa

# - Connexion au serveur pour supprimer sortie.log et le dossier towa existant.
ssh -R 2222:localhost:22 $iutuser@info-ssh1.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  rm sortie.log
  rm -r towa
EOF

# - Connexion au serveur pour envoyer le dossier towa créé précedemment.
rsync -r ./towa $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot

# Suppression du dossier towa en local
rm -r towa

# - Connexion au serveur pour attendre la création du fichier sortie.log
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
    
  echo -en "\e[92mContenu en attente       : \e[33m["

  NBLIGNE=\$(wc -l ~/iut-remise/towa/info_s1/$iutuser/depot/sortie.log | cut -f 1 -d " ")

  while [[ \$NBLIGNE -lt 2 ]]
  do 
    NBLIGNE=\$(wc -l ~/iut-remise/towa/info_s1/$iutuser/depot/sortie.log | cut -f 1 -d " ")
    echo -ne "▄"
    sleep 0.5
    echo -ne "▀"
    sleep 0.5
  done 
  echo -ne "]"
EOF

# - Connexion au serveur pour récuperer le fichier sortie.log
rsync -r $iutuser@info-ssh1.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot/sortie.log ./

echo
echo -en "\e[37m"

# Affichage résultat
if tail -n 1 sortie.log | grep -q validé 
then # Si le niveau est validé on n'affiche pas sortie.log
  echo -e "\e[36m";
  grep validé sortie.log
else
  cat sortie.log 
fi
