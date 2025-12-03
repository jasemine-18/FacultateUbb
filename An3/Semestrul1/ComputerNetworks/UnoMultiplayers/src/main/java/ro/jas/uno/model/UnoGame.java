package ro.jas.uno.model;

import java.util.*;

public class UnoGame {

    private final Deck deck;
    private final Map<String, Player> players = new HashMap<>();
    private Card topCard;

    public UnoGame() {
        this.deck = new Deck();
        // topCard va fi setat când intră primul jucător sau la primul join
    }

    public synchronized void addPlayer(String username) {
        if (players.containsKey(username)) {
            return;
        }

        Player p = new Player(username);
        players.put(username, p);

        // dăm cărțile inițiale
        for (int i = 0; i < GameConfig.INITIAL_HAND_SIZE; i++) {
            Card c = deck.draw();
            p.addCard(c);
        }

        // dacă nu avem încă topCard, scoatem una din deck
        if (topCard == null) {
            topCard = deck.draw();
        }
    }

    public synchronized Card getTopCard() {
        return topCard;
    }

    public synchronized List<Card> getHand(String username) {
        Player p = players.get(username);
        if (p == null) {
            return Collections.emptyList();
        }
        return p.getHand();
    }

    public synchronized Card drawCard(String username) {
        Player p = players.get(username);
        if (p == null) {
            return null;
        }
        Card c = deck.draw();
        if (c != null) {
            p.addCard(c);
        }
        return c;
    }

    private boolean canPlayOnTop(Card card) {
        if (card == null || topCard == null) {
            return false;
        }
        boolean sameColor = card.getColor() == topCard.getColor();
        boolean sameValue = card.getValue() == topCard.getValue();
        return sameColor || sameValue;
    }

    public synchronized boolean playCard(String username, Card card) {
        Player p = players.get(username);
        if (p == null) {
            return false;
        }
        if (!canPlayOnTop(card)) {
            return false;
        }
        if (!p.hasCard(card)) {
            return false;
        }
        p.removeCard(card);
        topCard = card;
        return true;
    }
}
