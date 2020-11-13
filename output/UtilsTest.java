package towa;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Tests unitaires pour la classe Utils.
 */
public class UtilsTest {

    /**
     * Test de carLigneVersNum pour les valeurs admises.
     */
    @Test
    public void testCarLigneVersNum() {
        assertEquals(0, Coordonnees.carLigneVersNum('a'));
        assertEquals(1, Coordonnees.carLigneVersNum('b'));
        assertEquals(15, Coordonnees.carLigneVersNum('p'));
    }

    /**
     * Test de carLigneVersNum pour un argument trop petit.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarLigneVersNumException1() {
        final char c = 'a' - 1;
        Coordonnees.carLigneVersNum(c);
    }

    /**
     * Test de carLigneVersNum pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarLigneVersNumException2() {
        final char c = 'a' + 16;
        Coordonnees.carLigneVersNum(c);
    }

    /**
     * Test de carColonneVersNum pour les valeurs admises.
     */
    @Test
    public void testCarColonneVersNum() {
        assertEquals(0, Coordonnees.carColonneVersNum('A'));
        assertEquals(1, Coordonnees.carColonneVersNum('B'));
        assertEquals(15, Coordonnees.carColonneVersNum('P'));
    }

    /**
     * Test de carColonneVersNum pour un argument trop petit.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarColonneVersNumException1() {
        final char c = 'A' - 1;
        Coordonnees.carColonneVersNum(c);
    }

    /**
     * Test de carColonneVersNum pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarColonneVersNumException2() {
        final char c = 'A' + 16;
        Coordonnees.carColonneVersNum(c);
    }

    @Test
    public void testNettoyerTableau() {

        String tab[], tabNettoye[];

        // tableau de taille 0
        tab = new String[0];
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(0, tabNettoye.length);

        // tableau de taille 1 avec 1 élément
        tab = new String[1];
        tab[0] = "coucou";
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(1, tabNettoye.length);
        assertEquals("coucou", tabNettoye[0]);

        // tableau de taille 1 avec 0 élément (null)
        tab = new String[1];
        tab[0] = null;
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(0, tabNettoye.length);

        // tableau de taille 1 avec 0 élément ("")
        tab = new String[1];
        tab[0] = "";
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(0, tabNettoye.length);

        // tableau de taille 2 avec 1 élément ("")
        tab = new String[2];
        tab[0] = "";
        tab[1] = "hello";
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(1, tabNettoye.length);
        assertEquals("hello", tabNettoye[0]);

        // un cas plus complet
        tab = new String[7];
        tab[0] = "";
        tab[1] = "hello";
        tab[2] = null;
        tab[3] = "";
        tab[4] = "hello";
        tab[5] = "";
        tab[6] = null;
        tabNettoye = Utils.nettoyerTableau(tab);
        assertEquals(2, tabNettoye.length);
        assertEquals("hello", tabNettoye[0]);
        assertEquals("hello", tabNettoye[1]);
    }
}
