package ro.jas.toy.model.value;

import ro.jas.toy.model.type.*;

public class IntValue implements Value {
    private final int val;
    public IntValue(int v) { this.val = v; }
    public int getVal() { return val; }
    @Override public String toString() { return Integer.toString(val); }
    @Override public Type getType() { return new IntType(); }
}
