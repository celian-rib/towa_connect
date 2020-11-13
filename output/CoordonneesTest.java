package towa;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Tests sur la classe Coordonnees.
 */
public class CoordonneesTest {

    @Test
    public void testConstructeurInt() {
        Coordonnees c = new Coordonnees(1, 12);
        assertEquals(1, c.ligne);
        assertEquals(12, c.colonne);
        c = new Coordonnees(0, 0);
        assertEquals(0, c.ligne);
        assertEquals(0, c.colonne);
    }

    @Test
    public void testDepuisChar() {
        Coordonnees c = Coordonnees.depuisCars('c', 'A');
        assertEquals(2, c.ligne);
        assertEquals(0, c.colonne);
    }

    /**
     * Test de carLigne pour les valeurs admises.
     */
    @Test
    public void testCarLigne() {
        assertEquals('a', (new Coordonnees(0, 3)).carLigne());
        assertEquals('b', (new Coordonnees(1, 32)).carLigne());
        assertEquals('p', (new Coordonnees(15, 0)).carLigne());
    }

    /**
     * Test de carLigne pour un argument trop petit.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarLigneException1() {
        (new Coordonnees(-1, 0)).carLigne();
    }

    /**
     * Test de carLigne pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarLigneException2() {
        (new Coordonnees(16, 0)).carLigne();
    }

    /**
     * Test de carColonne pour les valeurs admises.
     */
    @Test
    public void testCarColonne() {
        assertEquals('A', (new Coordonnees(7, 0)).carColonne());
        assertEquals('B', (new Coordonnees(0, 1)).carColonne());
        assertEquals('P', (new Coordonnees(5, 15)).carColonne());
    }

    /**
     * Test de carColonne pour un argument trop petit.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarColonneException1() {
        (new Coordonnees(0, -1)).carColonne();
    }

    /**
     * Test de carColonne pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarColonneException2() {
        (new Coordonnees(0, 16)).carColonne();
    }

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
        final char c = Coordonnees.CAR_PREMIERE_LIGNE - 1;
        Coordonnees.carLigneVersNum(c);
    }

    /**
     * Test de carLigneVersNum pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarLigneVersNumException2() {
        final char c = Coordonnees.CAR_PREMIERE_LIGNE + Coordonnees.NB_LIGNES;
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
        final char c = Coordonnees.CAR_PREMIERE_COLONNE - 1;
        Coordonnees.carColonneVersNum(c);
    }

    /**
     * Test de carColonneVersNum pour un argument trop grand.
     */
    @Test(expected = IllegalArgumentException.class)
    public void testCarColonneVersNumException2() {
        final char c = Coordonnees.CAR_PREMIERE_COLONNE + Coordonnees.NB_COLONNES;
        Coordonnees.carColonneVersNum(c);
    }

    @Test
    public void testConstantes() {
        assertEquals(16, Coordonnees.NB_LIGNES);
        assertEquals(16, Coordonnees.NB_COLONNES);
        assertEquals('a', Coordonnees.CAR_PREMIERE_LIGNE);
        assertEquals('A', Coordonnees.CAR_PREMIERE_COLONNE);
    }
}
