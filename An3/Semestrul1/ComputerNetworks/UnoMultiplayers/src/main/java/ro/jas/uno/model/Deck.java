package ro.jas.uno.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class Deck {

    private final List<Card> cards = new ArrayList<>();
    private final Random random;

    public Deck() {
        this(new Random(GameConfig.RANDOM_SEED));
    }

    public Deck(Random random) {
        this.random = random;
        initStandardDeck();
        shuffle();
    }

    private void initStandardDeck() {
        // UNO simplificat: culori x valori [MIN_VALUE..MAX_VALUE]
        for (CardColor color : CardColor.values()) {
            for (int value = GameConfig.MIN_VALUE; value <= GameConfig.MAX_VALUE; value++) {
                cards.add(new Card(color, value));
            }
        }
    }

    public void shuffle() {
        Collections.shuffle(cards, random);
    }

    public boolean isEmpty() {
        return cards.isEmpty();
    }

     // Extrage o carte din varful pachetului.
     // @return Card daca mai exista, altfel null.
    public Card draw() {
        if (cards.isEmpty()) {
            return null;
        }
        return cards.remove(cards.size() - 1);
    }

    public int size() {
        return cards.size();
    }
}
