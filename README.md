# TOWA Connect
> Riboulet Célian, Tomm Jobit

### Installation linux :
- Copier le projet ```git clone https://github.com/celian-rib/towa_connect.git```
> Attention : Faire l'installation dans un répertoire linux et non windows si vous utilisez WSL.

### Modifier pour faire fonctionner :
- Ouvrir ```config.sh``` avec un editeur de code (Modifier aucun autre fichier).
- Modifier le nom d'utilisateur (Nom d'utilisateur IUT).
- Modifer le chemin accedant au repertoire du projet Netbeans. (Souvent dans le dossier .../Document/NeatbeansProject/Towa)

### Utilisation du script :
- Lancer le script ```./towa-connect.sh```
- Entrer son mot-de-passe, il vous sera demandé plusieurs fois, pour eviter cela voir plus bas...
- Le script vous fera d'abord attendre que le fichier sortie.log soit créé, puis vous l'enverra pour directement l'afficher.

### Comment faire pour ne pas entrer son mot de passe plusieurs fois :
- Faire : ```nano ~/.ssh/config```
- Puis ajouter dans ce fichier : 
```
ControlMaster auto
ControlPath /tmp/ssh_%r@%n:%p
ControlPersist 8h
```
