# Towa Connect
> Towa-connect est un programme réaliser par Riboulet Célian dans le cadre du projet towa de l'iut informatique de bordeaux.

> Son but est d'automatiser l'export de script sur le serveur de l'iut, ainsi que la récupération du fichier sortie.log

> Contribution : Riboulet Célian, Tomm Jobit, Antoine Virgos

### Installer (sur linux) :
``` git clone https://github.com/celian-rib/towa_connect.git ```

### Modifier pour faire fonctionner :
- Ouvrir config.sh avec un editeur de code ```nano config.sh```
- Modifier le nom d'utilisateur (Mettre son nom d'utilisateur de l'IUT).
- Modifier le chemin d'accès au repertoire du projet netbeans (Prendre pour exemple celui déjà present).

### Utilisation :
- Lancer le script towa-connect.sh ```bash towa-connect.sh```
- Votre mot de passe vous sera deméndé plusieurs fois, il existe une solution pour ça ...
- Attendre que le script récupère le fichier sortie.log

### Comment faire pour ne pas entrer son mot de passe plusieurs fois :
- Faire : ```nano ~/.ssh/config```
- Puis ajouter dans ce fichier : 
```
ControlMaster auto
ControlPath /tmp/ssh_%r@%n:%p
ControlPersist 8h
```
