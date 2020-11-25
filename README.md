# TOWA Connect (Automatisation)
> Riboulet Célian, Tomm Jobit

### Installer (sur linux) :
``` git clone https://github.com/celian-rib/towa_connect.git ```
Attention : Faire l'installation dans un répertoire linux et non windows si vous utilisez WSL

### Modifier pour faire fonctionner :
- Ouvrir ```config.sh``` avec un editeur de code
- Modifier le nom d'utilisateur (Mettre celui de l'IUT)
- Modifer le chemin accedant au repertoire du projet netbean

### Utilisation :
- Lancer le script towa-connect.sh
- Si tout est bien référencé, il ne vous reste plus qu'a entrer votre mot de passe (2 fois sauf si vous avez une clé ssh enregistrée)
- Et voila, il ne manque plus qua attendre que sortie.log pointe le bout de son nez.

### Comment faire pour ne pas entrer son mot de passe plusieurs fois :
- Faire : ```nano ~/.ssh/config```
- Puis ajouter dans ce fichier : 
```
ControlMaster auto
ControlPath /tmp/ssh_%r@%n:%p
ControlPersist 8h
```
