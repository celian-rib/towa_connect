package towa;

/**
 * Interface que vous devez implémenter correctement pour valider un niveau.
 * 
 * VOUS NE DEVEZ PAS MODIFIER CE FICHIER.
 */
public interface IJoueurTowa {
    
    /**
     * Cette méthode renvoie, pour un plateau donné et un joueur donné, 
     * toutes les actions possibles pour ce joueur.
     * @param plateau le plateau considéré
     * @param joueurNoir vrai si le joueur noir joue, faux si c'est le blanc
     * @param niveau le niveau de la partie à jouer
     * @return l'ensemble des actions possibles
     */
    String[] actionsPossibles(Case[][] plateau, boolean joueurNoir, int niveau);
}
