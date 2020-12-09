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



# Mettre les fichiers dans le dossier depot/towa (normalement rien de change)
# Supprimer le fichier partie2.log
# Attendre creation partie2.log
# Attendre remplissage partie2.log
# Recup partie2.log 
# Recup tous les resultat de partie (entre 1 - 9).
# Filter tous les resultat (Apres).

source config.sh # Récupère les variables du fichier config.sh

towaScriptsSrc="${mainPath}/src/towa" # Chemin d'accès du dossier src du projet netbeans
towaTestsSrc="${mainPath}/test/towa" # Chemin d'accès du dossier test du projet netbeans
partieJouees=1

echo -en "\e[36m" # Cyan
cat splashscreen.txt

if [ ! -z "$1" ]; 
  then
    if [ "$1" -ge 1 ] && [ "$1" -le 9 ];
      then
        partieJouees="$1"
      else 
        echo -e "\e[31mNombre de partie invalide (entre 1 et 9)"  
        exit 1
    fi
fi

echo
echo -e "\e[37mLancement de $partieJouees partie(s)"
echo



echo -en "\e[90m" # grey

# Création du dossier resultats dans le cas ou il existe pas
test ! -d resultats && mkdir resultats

# Supression du dossier towa dans le cas ou il existe
[ -d "towa" ] &&  rm -r towa 

[ -f partie2.log ] &&  rm partie2.log

# Supression des fichiers résultats dans le cas ou ils existent
rm -f resultats/resultats_Towa*

# Creation du dossier towa puis remplissage de ce dernier
mkdir towa
cp $towaScriptsSrc/*.java towa
cp $towaTestsSrc/*.java towa

# - Connexion au serveur pour supprimer sortie.log et le dossier towa existant.
ssh -R 2222:localhost:22 $iutuser@info-ssh2.iut.u-bordeaux.fr << EOF
  cd ~/iut-remise/towa/info_s1/$iutuser

  test -f partie.xml && sed -i "s/nombre_executions>.</nombre_executions>$partieJouees</g" partie.xml

  cd ~/iut-remise/towa/info_s1/$iutuser/depot
  rm ../partie2.log
  rm -f ../resultats_Towa*
  rm -r towa
EOF

# - Connexion au serveur pour envoyer le dossier towa créé précedemment.
rsync -r ./towa $iutuser@info-ssh2.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/depot

# Suppression du dossier towa en local
rm -r towa

# - Connexion au serveur pour attendre la création du fichier sortie.log
ssh -R 2222:localhost:22 $iutuser@info-ssh2.iut.u-bordeaux.fr << EOF
  
  cd ~/iut-remise/towa/info_s1/$iutuser/
  
  echo -en "\e[92mEn attente de partie2.log  : \e[36m["
  while [ ! -f partie2.log ]
  do 
    echo -ne "▄"
    sleep 0.3
    echo -ne "▀"
    sleep 0.3
  done
  echo "]"
EOF
  
echo 

ssh -R 2222:localhost:22 $iutuser@info-ssh2.iut.u-bordeaux.fr << EOF

  cd ~/iut-remise/towa/info_s1/$iutuser/
  # echo -en "\e[92mContenu en attente       : \e[36m["

  NBLIGNE=\$(wc -l ~/iut-remise/towa/info_s1/$iutuser/partie2.log | cut -f 1 -d " ")

  while [[ \$NBLIGNE -lt 2 ]]
  do 
    NBLIGNE=\$(wc -l ~/iut-remise/towa/info_s1/$iutuser/partie2.log | cut -f 1 -d " ")
    # echo -ne "▄"
    # sleep 1
    # echo -ne "▀"
    sleep 1
  done 
  # echo -ne "]"
EOF

# - Connexion au serveur pour récuperer le fichier sortie.log
rsync -r $iutuser@info-ssh2.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/partie2.log ./


rsync -r $iutuser@info-ssh2.iut.u-bordeaux.fr:~/iut-remise/towa/info_s1/$iutuser/resultats_Towa* ./resultats

echo
echo -en "\e[37m"

grep joue partie2.log

let nbpartie=1;
for f in resultats/resultats_Towa*
do
  echo "====Partie $nbpartie============================================"
  grep -A1 @ $f | tail -n 1 #ligne apres le @
  echo
  echo "Joueur n° 1"
  grep -A5 "n° 1" $f | tail -n 3 
  echo
  echo "Joueur n° 2"
  grep -A5 "n° 2" $f | tail -n 3 
  echo
  let nbpartie=$nbpartie+1
done
