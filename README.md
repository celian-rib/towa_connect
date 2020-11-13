# TOWA Connect (Automatisation)
> Riboulet Célian

### Installer (sur linux) :
``` git clone https://github.com/celian-rib/towa_connect.git ```

### Modifier pour faire fonctionner :
- Ouvrir towa-connect.sh avec un editeur de code
- Modifier le nom d'utilisateur (Mettre celui de l'IUT)
- Modifer le chemin accedant au repertoire des classes principales netbeans
- Modifer le chemin accedant au repertoire des classes de test netbeans

### Ce qui se passe :
Tout les fichiers .java sont réunis dans un seul dossier, ensuite le dossier depot est vidé (via ssh) pour que le nouveau dossier puisse etre déposé (avec rsync)

### Utilisation :
- Lancer le script towa-connect.sh
- Si tout est bien référencé, il ne vous reste plus qu'a entrer votre mot de passe (2 fois sauf si vous avez une clé ssh enregistrée)
- Et voila, il ne manque plus qua attendre que sortie.log pointe le bout de son nez.
