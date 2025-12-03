package ro.jas.uno.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Player {

    private final String username;
    private final List<Card> hand = new ArrayList<>();

    public Player(String username) {
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public List<Card> getHand() {
        // listă read-only, ca să nu fie modificată din exterior
        return Collections.unmodifiableList(hand);
    }

    public void addCard(Card card) {
        if (card != null) {
            hand.add(card);
        }
    }

    public boolean removeCard(Card card) {
        return hand.remove(card);
    }

    public boolean hasCard(Card card) {
        return hand.contains(card);
    }

    public int handSize() {
        return hand.size();
    }
}
