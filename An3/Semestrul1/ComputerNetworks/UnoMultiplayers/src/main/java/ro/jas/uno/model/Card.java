package ro.jas.uno.model;

public class Card {
    private final CardColor cardColor; //culoarea cartii
    private final int value; //valoarea cartii

    public Card(CardColor cardColor, int value){
        this.cardColor = cardColor;
        this.value =value;
    }

    public CardColor getColor(){
        return cardColor;
    }

    public int getValue(){
        return value;
    }

    public String toProtocolString(){
        return cardColor.name() + "-" +value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Card other = (Card) o;
        return value == other.value && cardColor == other.cardColor;
    }

    @Override
    public int hashCode() {
        int result = cardColor != null ? cardColor.hashCode() : 0;
        result = 31 * result + value;
        return result;
    }


    public static Card fromProtocolString(String s){
        String[] parts = s.split("-");
        CardColor c = CardColor.valueOf(parts[0]);
        int v = Integer.parseInt(parts[1]);
        return new Card(c,v);
    }

    @Override
    public String toString() {
        return toProtocolString();
    }

}
