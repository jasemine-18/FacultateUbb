package ro.jas.toy.model.value;

import ro.jas.toy.model.type.*;

public class BoolValue implements Value {
    private final boolean val;
    public BoolValue(boolean v) { this.val = v; }
    public boolean getVal() { return val; }
    @Override public String toString() { return Boolean.toString(val); }
    @Override public Type getType() { return new BoolType(); }
}