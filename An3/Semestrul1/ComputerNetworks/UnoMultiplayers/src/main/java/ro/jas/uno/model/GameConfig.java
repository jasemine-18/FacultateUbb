package ro.jas.uno.model;

public class GameConfig {

    // numărul de cărți inițiale în mână
    public static final int INITIAL_HAND_SIZE = 3;

    // numărul de culori (hardcodate în enum)
    public static final int CARD_COLORS = CardColor.values().length;

    // valorile posibile ale cărților (0–9)
    public static final int MIN_VALUE = 0;
    public static final int MAX_VALUE = 9;

    // opțional — seed pentru deck random
    public static final long RANDOM_SEED = System.currentTimeMillis();

    private GameConfig() {} // prevenim instanțierea
}
